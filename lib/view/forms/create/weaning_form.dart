import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:integrazoo/base.dart';


import 'package:integrazoo/view/components/bovine/single_bovine_selector.dart';
import 'package:integrazoo/view/components/bovine/earring_controller.dart';

import 'package:integrazoo/control/bovine_controller.dart';
import 'package:integrazoo/control/weaning_controller.dart';

import 'package:integrazoo/database/database.dart';


class WeaningForm extends StatefulWidget {
  const WeaningForm({ super.key });

  @override
  State<WeaningForm> createState() => _WeaningForm();
}

class _WeaningForm extends State<WeaningForm> {
  final _formKey = GlobalKey<FormState>();

  final earringController = EarringController();
  final weightController = TextEditingController();

  DateTime date= DateTime.now();
  late final TextEditingController dateController;

  @override
  void initState() {
    super.initState();
    dateController = TextEditingController(text: DateFormat.yMd("pt_BR").format(date));
  }

  @override
  Widget build(BuildContext context) {
    final addButton = TextButton(onPressed: saveWeaning, child: const Text("SALVAR"));

    final datePicker = InputDatePickerFormField(
      initialDate: date,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
      keyboardType: TextInputType.text,
      fieldLabelText: "Data do Desmame",
      onDateSubmitted: (value) => date = value,
      onDateSaved: (value) => date = value,
    );

    final cowSelector = SingleBovineSelector(
      hasBeenWeaned: false,
      label: "Animais",
      earringController: earringController,
    );

    final weightField = TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        label: Text("Peso"),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: "Digite o peso do animal"
      ),
      controller: weightController,
      validator: (String? value) {
        if (value == null) {
          return null;
        }

        if (value.isNotEmpty && double.tryParse(value) == null) {
          return "Por favor, digite um número válido.";
        }

        return null;
      },
    );

    Divider divider = const Divider(color: Colors.transparent);

    final column = <Widget>[
      cowSelector,
      divider,
      datePicker,
      divider,
      weightField,
      divider,
      addButton
    ];

    return IntegrazooBaseApp(
      title: "REGISTRAR DESMAME",
      body: SingleChildScrollView(child:
        Form(
          autovalidateMode: AutovalidateMode.always,
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: column)
          )
        )
      )
    );
  }

  void saveWeaning() {
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

    final earring = earringController.earring!;

    final weaning = Weaning.fromJson({
      'bovine': earring,
      'date': date,
      'weight': double.parse(weightController.text)
    });

    updateStatus();

    WeaningController.saveWeaning(weaning).then(
      (_) {
        SnackBar snackBar = const SnackBar(
          content: Text("Desmame registrado com sucesso"),
          backgroundColor: Colors.green,
          showCloseIcon: true
        );

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          clear();
          // Navigator.of(context).pop();
        }
      }
    );
  }

  void updateStatus() {
    final earring = earringController.earring!;

    BovineController.getBovine(earring).then(
      (cow) {
        if (cow == null) {
          // TODO: RAISE ERROR.
          return;
        }

        final cowUpdate = cow.copyWith(hasBeenWeaned: true);

        BovineController.saveBovine(cowUpdate);
      }
    );
  }

  String? validateAllFields() {
    if (earringController.earring == null) {
      return "Por favor, selecione o animal.";
    }

    if (weightController.text.isEmpty) {
      return "Por favor, digite o peso do animal.";
    }

    return null;
  }

  void clear() {
    setState(() {
      earringController.clear();
      weightController.clear();
      date = DateTime.now();
      dateController = TextEditingController(text: DateFormat.yMd("pt_BR").format(date));
    });
  }
}
