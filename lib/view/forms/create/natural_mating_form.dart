import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:integrazoo/base.dart';


import 'package:integrazoo/view/components/bovine/earring_controller.dart';
import 'package:integrazoo/view/components/bovine/single_bovine_selector.dart';

import 'package:integrazoo/control/bovine_controller.dart';
import 'package:integrazoo/control/reproduction_controller.dart';

import 'package:integrazoo/database/database.dart';


class NaturalMatingForm extends StatefulWidget {
  final Reproduction? reproduction;
  final bool shouldPop;

  const NaturalMatingForm({ super.key, this.reproduction, this.shouldPop = false });

  @override
  State<NaturalMatingForm> createState() => _NaturalMatingForm();
}

class _NaturalMatingForm extends State<NaturalMatingForm> {
  final _formKey = GlobalKey<FormState>();

  final cowEarringController = EarringController();
  final bullEarringController = EarringController();

  DateTime date = DateTime.now();
  late final TextEditingController dateController;

  @override
  void initState() {
    super.initState();

    if (widget.reproduction != null) {
      date = widget.reproduction!.date;
      cowEarringController.setEarring(widget.reproduction!.cow);
      bullEarringController.setEarring(widget.reproduction!.bull);
    }

    dateController = TextEditingController(text: DateFormat.yMd("pt_BR").format(date));
  }

  @override
  Widget build(BuildContext context) {
    final addButton = TextButton(onPressed: registerMatings, child: const Text("SALVAR"));

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

    final cowSelector = SingleBovineSelector(
      earringController: cowEarringController,
      sex: Sex.female,
      wasDiscarded: false,
      isReproducing: false,
      isPregnant: false,
      label: "Vaca",
    );

    final bullSelector = SingleBovineSelector(
      earringController: bullEarringController,
      sex: Sex.male,
      wasDiscarded: false,
      isReproducing: false,
      label: "Touro",
    );

    Divider divider = const Divider(color: Colors.transparent);

    final column = <Widget>[
      if (widget.reproduction == null) cowSelector,
      divider,
      bullSelector,
      divider,
      datePicker,
      divider,
      addButton
    ];

    return IntegrazooBaseApp(
      title: "REGISTRAR COBERTURA",
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

  void registerMatings() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

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

    BovineController.getBovine(cowEarringController.earring!).then(
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
      'kind': ReproductionKind.coverage.index,
      'diagnostic': ReproductionDiagonostic.waiting.index,
      'date': date,
      'cow': cowEarringController.earring!,
      'bull': bullEarringController.earring!,
      'breeder': null
    });

    ReproductionController.saveReproduction(reproduction).then((value) {
      if (context.mounted) {
        SnackBar snackBar = const SnackBar(
          content: Text('Reprodução registrada com sucesso.'),
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

  String? validateAllFields() {
    if (cowEarringController.earring == null) {
      return 'Por favor, seleciona a vaca.';
    }

    if (bullEarringController.earring == null) {
      return 'Por favor, seleciona o touro.';
    }

    return null;
  }

  void clearForm() {
    setState(() {
      cowEarringController.clear();
      bullEarringController.clear();
      date = DateTime.now();
      dateController.text = DateFormat.yMd("pt_BR").format(date);
    });
  }
}
