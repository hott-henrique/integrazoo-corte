import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:integrazoo/view/components/button.dart';
import 'package:integrazoo/view/components/unexpected_error_alert_dialog.dart';

import 'package:integrazoo/control/bovine_controller.dart';
import 'package:integrazoo/control/weaning_controller.dart';

import 'package:integrazoo/database/database.dart';
import 'package:integrazoo/globals.dart';


class WeaningInfoForm extends StatefulWidget {
  final int earring;
  final Weaning? weaning;
  final VoidCallback postSaved;

  const WeaningInfoForm({ super.key, required this.earring, this.weaning, required this.postSaved });

  @override
  State<WeaningInfoForm> createState() => _WeaningInfoForm();
}

class _WeaningInfoForm extends State<WeaningInfoForm> {
  final _formKey = GlobalKey<FormState>();

  final weightController = TextEditingController();

  late DateTime date;
  late final TextEditingController dateController;

  final DateFormat formatter = DateFormat('dd/MM/yyyy');

  Exception? exception;

  @override
  void initState() {
    super.initState();
    date = widget.weaning?.date ?? DateTime.now();
    dateController = TextEditingController(text: formatter.format(date));
    weightController.text = (widget.weaning?.weight ?? "").toString();
  }

  @override
  Widget build(BuildContext context) {
    if (exception != null) {
      return UnexpectedErrorAlertDialog(title: 'Erro Inesperado',
                                        message: 'Algo de inespearado aconteceu durante a execução do aplicativo.',
                                        onPressed: () => setState(() => exception = null));
    }

    final addButton = Button(text: "SALVAR", color: Colors.green, onPressed: saveWeaning);

    final datePicker = TextFormField(
      controller: dateController,
      decoration: const InputDecoration(border: OutlineInputBorder(),
                                        label: Text("Data do Desmame"),
                                        floatingLabelBehavior: FloatingLabelBehavior.always),
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
      datePicker,
      divider,
      weightField,
      divider,
      addButton
    ];

    return SingleChildScrollView(child:
      Form(
        autovalidateMode: AutovalidateMode.always,
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: column)
        )
      )
    );
  }

  void saveWeaning() async {
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

    await database.transaction(() async {
      final weaning = Weaning.fromJson({
        'bovine': widget.earring,
        'date': date,
        'weight': double.parse(weightController.text)
      });

      await updateStatus();

      await WeaningController.saveWeaning(weaning);

      SnackBar snackBar = const SnackBar(
        content: Text("Desmame registrado com sucesso"),
        backgroundColor: Colors.green,
        showCloseIcon: true
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

      clearForm();

      widget.postSaved();
    });
  }

  Future<int> updateStatus() async {
    final bovine = await BovineController.getBovine(widget.earring);

    if (bovine == null) {
      throw Exception("Could not find the bovine to update: ${widget.earring}");
    }

    final bovineUpdate = bovine.copyWith(hasBeenWeaned: true);

    return BovineController.saveBovine(bovineUpdate);
  }

  String? validateAllFields() {
    if (weightController.text.isEmpty) {
      return "Por favor, digite o peso do animal.";
    }

    return null;
  }

  void clearForm() {
    setState(() {
      weightController.clear();
      date = DateTime.now();
      dateController.text = formatter.format(date);
    });
  }
}
