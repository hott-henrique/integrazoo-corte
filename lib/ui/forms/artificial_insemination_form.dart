import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:integrazoo/styles/app_text_styles.dart';

import 'package:intl/intl.dart';

import 'package:integrazoo/backend.dart';

import 'package:integrazoo/ui/components.dart';


class ArtificialInseminationForm extends StatefulWidget {
  final Reproduction? reproduction;
  final bool shouldPop;

  const ArtificialInseminationForm({ super.key, this.reproduction, this.shouldPop = false });

  @override
  State<ArtificialInseminationForm> createState() => _ArtificialInseminationForm();
}

class _ArtificialInseminationForm extends State<ArtificialInseminationForm> {
  final _formKey = GlobalKey<FormState>();

  final earringsService = MultiEarringController();
  final breederService = SingleBreederSelectorController();

  DateTime date = DateTime.now();
  late final TextEditingController dateController;

  final TextEditingController strawNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.reproduction != null) {
      date = widget.reproduction!.date;
      earringsService.earrings.add(widget.reproduction!.cow);
      breederService.setBreeder(widget.reproduction!.breeder);
      strawNumberController.text = widget.reproduction!.strawNumber.toString();
    }

    dateController = TextEditingController(text: DateFormat.yMd("pt_BR").format(date));
  }

  @override
  Widget build(BuildContext context) {
    final addButton = TextButton(onPressed: registerInseminations, child: const Text("SALVAR"),);

    final datePicker = TextFormField(
      controller: dateController,
      decoration: const InputDecoration(border: OutlineInputBorder(),
                                        label: Text("Data"),
                                        floatingLabelBehavior: FloatingLabelBehavior.auto),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: date,
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
        );
        if (pickedDate != null) {
          setState(() {
            date = pickedDate;
            dateController.text = DateFormat.yMd("pt_BR").format(pickedDate);
          });
        }
      },
    );

    final cowSelector = MultiBovineSelector(
      earringsService: earringsService,
      sex: Sex.female,
      wasDiscarded: false,
      isReproducing: false,
      isPregnant: false,
      label: "Vacas",
    );

    final breederSelector = SingleBreederSelector(breederService: breederService);

    final strawNumberField = TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(border: OutlineInputBorder(),
                                        label: Text("Número da Pipeta"),
                                        hintText: "Digite o número da pipeta.",
                                        floatingLabelBehavior: FloatingLabelBehavior.always),
      controller: strawNumberController,
      validator: (String? value) {
        if (value == null) {
          return "Por favor, digite um número válido.";
        }

        if (value.isNotEmpty && int.tryParse(value) == null) {
          return "Por favor, digite um número válido.";
        }

        return null;
      },
    );

    final header = Text(
      widget.reproduction == null ? "REGISTRANDO INSEMINAÇÕES" : "EDITANDO INSEMINAÇÃO NA VACA #${widget.reproduction!.cow}",
      textAlign: TextAlign.center,
      style: AppTextStyles.pageHeading,
    );

    Divider divider = const Divider(color: Colors.transparent);

    final column = <Widget>[
      header,
      if (widget.reproduction == null) ...[
        cowSelector,
        divider
      ],
      breederSelector,
      divider,
      datePicker,
      divider,
      strawNumberField,
      divider,
      addButton
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        autovalidateMode: AutovalidateMode.always,
        key: _formKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: column)
      )
    );
  }

  void registerInseminations() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();

      String? error = validateAllFields();

      if (error != null) {
        SnackBar snackBar = SnackBar(
          content: Text(error),
          backgroundColor: Colors.red,
          showCloseIcon: true
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
      }

      List<Future<int>> futures = List.empty(growable: true);

      for (final earring in earringsService.earrings) {
        BovineService.getBovine(earring).then(
          (bovine) {
            if (bovine == null) {
              throw Exception("Bovine not found.");
            }

            final bovineUpdate = bovine.copyWith(isReproducing: true);

            BovineService.saveBovine(bovineUpdate).onError((e, s) {
              throw Exception("Failed to update bovine when saving artificial insemination.");
            });
          }

        );
        final reproduction = Reproduction.fromJson({
          'id': widget.reproduction?.id ?? 0,
          'kind': ReproductionKind.artificialInsemination.index,
          'diagnostic': ReproductionDiagonostic.waiting.index,
          'date': date,
          'cow': earring,
          'bull': null,
          'breeder': breederService.breeder,
          'strawNumber': int.parse(strawNumberController.text),
        });

        futures.add(ReproductionService.saveReproduction(reproduction));
      }

      Future.wait(futures).then((values) {
        if (values.contains(0)) {
          inspect("Something went wrong");
        }

        if (mounted) {
          SnackBar snackBar = const SnackBar(
            content: Text('Inseminações registradas com sucesso.'),
            backgroundColor: Colors.green,
            showCloseIcon: true
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);

          if (widget.shouldPop) {
            Navigator.of(context).pop();
          } else {
            clearForm();
          }
        }
      });
    }
  }

  String? validateAllFields() {
    if (earringsService.earrings.isEmpty) {
      return 'Por favor, escolha ao menos uma vaca.';
    }

    if (strawNumberController.text.isEmpty) {
      return 'Por favor, digite o número da pipeta.';
    }

    if (breederService.breeder == null) {
      return 'Por favor, escolha o reprodutor.';
    }

    return null;
  }

  void clearForm() {
    setState(() {
      earringsService.clear();
      breederService.clear();
      strawNumberController.clear();
      date = DateTime.now();
      dateController.text = DateFormat.yMd('pt_BR').format(date);
    });
  }
}
