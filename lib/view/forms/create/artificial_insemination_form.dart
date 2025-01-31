import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:integrazoo/base.dart';

import 'package:integrazoo/view/components/button.dart';
import 'package:integrazoo/view/components/unexpected_error_alert_dialog.dart';

import 'package:integrazoo/view/components/bovine/multi_bovine_selector.dart';
import 'package:integrazoo/view/components/bovine/multi_earring_controller.dart';

import 'package:integrazoo/view/components/breeder/single_breeder_selector.dart';
import 'package:integrazoo/view/components/breeder/single_breeder_selector_controller.dart';

import 'package:integrazoo/control/bovine_controller.dart';
import 'package:integrazoo/control/reproduction_controller.dart';

import 'package:integrazoo/database/database.dart';


class ArtificialInseminationForm extends StatefulWidget {
  final Reproduction? reproduction;
  final bool shouldPop;

  const ArtificialInseminationForm({ super.key, this.reproduction, this.shouldPop = false });

  @override
  State<ArtificialInseminationForm> createState() => _ArtificialInseminationForm();
}

class _ArtificialInseminationForm extends State<ArtificialInseminationForm> {
  final _formKey = GlobalKey<FormState>();

  final earringsController = MultiEarringController();
  final breederController = SingleBreederSelectorController();

  DateTime date = DateTime.now();
  late final TextEditingController dateController;

  final TextEditingController strawNumberController = TextEditingController();

  final DateFormat formatter = DateFormat('dd/MM/yyyy');

  Exception? exception;

  @override
  void initState() {
    super.initState();

    if (widget.reproduction != null) {
      date = widget.reproduction!.date;
      earringsController.earrings.add(widget.reproduction!.cow);
      breederController.setBreeder(widget.reproduction!.breeder);
      strawNumberController.text = widget.reproduction!.strawNumber.toString();
    }

    dateController = TextEditingController(text: formatter.format(date));
  }

  @override
  Widget build(BuildContext context) {
    if (exception != null) {
      return UnexpectedErrorAlertDialog(title: 'Erro Inesperado',
                                        message: 'Algo de inespearado aconteceu durante a execução do aplicativo.',
                                        onPressed: () => setState(() => exception = null));
    }

    final addButton = Button(text: "CONFIRMAR", color: Colors.green, onPressed: registerInseminations);

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
            dateController.text = formatter.format(pickedDate);
          });
        }
      },
    );

    final cowSelector = MultiBovineSelector(
      earringsController: earringsController,
      sex: Sex.female,
      wasDiscarded: false,
      isReproducing: false,
      isPregnant: false,
      label: "Vacas",
    );

    final breederSelector = SingleBreederSelector(breederController: breederController);

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

    Divider divider = const Divider(color: Colors.transparent);

    final column = <Widget>[
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

    return IntegrazooBaseApp(
      title: "REGISTRAR INSEMINAÇÃO ARTIFICIAL",
      body: SingleChildScrollView(child:
        Form(
        autovalidateMode: AutovalidateMode.always,
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: column)
        )
      ))
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

      for (final earring in earringsController.earrings) {
        BovineController.getBovine(earring).then(
          (bovine) {
            if (bovine == null) {
              throw Exception("Bovine not found.");
            }

            final bovineUpdate = bovine.copyWith(isReproducing: true);

            BovineController.saveBovine(bovineUpdate).onError((e, s) {
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
          'breeder': breederController.breeder,
          'strawNumber': int.parse(strawNumberController.text),
        });

        futures.add(ReproductionController.saveReproduction(reproduction));
      }

      Future.wait(futures).then((values) {
        if (values.contains(0)) {
          inspect("Something went wrong");
        }

        if (context.mounted) {
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
    if (earringsController.earrings.isEmpty) {
      return 'Por favor, escolha ao menos uma vaca.';
    }

    if (strawNumberController.text.isEmpty) {
      return 'Por favor, digite o número da pipeta.';
    }

    if (breederController.breeder == null) {
      return 'Por favor, escolha o reprodutor.';
    }

    return null;
  }

  void clearForm() {
    setState(() {
      earringsController.clear();
      breederController.clear();
      strawNumberController.clear();
      date = DateTime.now();
      dateController.text = formatter.format(date);
    });
  }
}
