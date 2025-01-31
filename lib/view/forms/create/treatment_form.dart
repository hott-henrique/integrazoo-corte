import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:integrazoo/base.dart';

import 'package:integrazoo/view/components/button.dart';
import 'package:integrazoo/view/components/unexpected_error_alert_dialog.dart';

import 'package:integrazoo/view/components/bovine/earring_controller.dart';
import 'package:integrazoo/view/components/bovine/single_bovine_selector.dart';
import 'package:integrazoo/control/treatment_controller.dart';

import 'package:integrazoo/database/database.dart';


class TreatmentForm extends StatefulWidget {
  final Treatment? treatment;
  final bool shouldPop;

  const TreatmentForm({ super.key, this.treatment, this.shouldPop = false });

  @override
  State<TreatmentForm> createState() => _TreatmentFormState();
}

class _TreatmentFormState extends State<TreatmentForm> {
  final _formKey = GlobalKey<FormState>();

  final earringController = EarringController();

  final reasonController = TextEditingController();
  final medicineController = TextEditingController();

  DateTime startingDate = DateTime.now();
  late final TextEditingController startingDateController;

  DateTime endingDate = DateTime.now();
  late final TextEditingController endingDateController;

  final DateFormat formatter = DateFormat('dd/MM/yyyy');

  Exception? exception;

  @override
  void initState() {
    super.initState();

    startingDate = widget.treatment?.startingDate ?? startingDate;
    endingDate = widget.treatment?.endingDate ?? endingDate;

    reasonController.text = widget.treatment?.reason ?? "";
    medicineController.text = widget.treatment?.medicine ?? "";

    earringController.setEarring(widget.treatment?.bovine);

    startingDateController = TextEditingController(text: formatter.format(startingDate));
    endingDateController = TextEditingController(text: formatter.format(endingDate));
  }

  @override
  Widget build(BuildContext context) {
    if (exception != null) {
      return UnexpectedErrorAlertDialog(
        title: 'Erro Inesperado',
        message: 'Algo de inespearado aconteceu durante a execução do aplicativo.',
        onPressed: () => setState(() => exception = null)
      );
    }

    final bovineSelector = SingleBovineSelector(
      sex: null,
      wasDiscarded: false,
      isReproducing: null,
      isPregnant: null,
      label: "Animal",
      earringController: earringController,
    );

    final reasonField = TextFormField(
      controller: reasonController,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        hintText: 'Digite o motivo do tratamento',
        border: OutlineInputBorder(),
        label: Text("Razão do Tratmento"),
        floatingLabelBehavior: FloatingLabelBehavior.always
      ),
    );

    final medicineNameField = TextFormField(
      controller: medicineController,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        hintText: 'Digite o nome do medicamento',
        border: OutlineInputBorder(),
        label: Text("Nome do Medicamento"),
        floatingLabelBehavior: FloatingLabelBehavior.always
      ),
    );

    final startingDatePicker = TextFormField(
      controller: startingDateController,
      decoration: const InputDecoration(border: OutlineInputBorder(),
                                        label: Text("Data de Início do Tratamento"),
                                        floatingLabelBehavior: FloatingLabelBehavior.auto),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: startingDate,
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
        );
        if (pickedDate != null) {
          setState(() {
            startingDate = pickedDate;
            startingDateController.text = formatter.format(pickedDate);
          });
        }
      },
    );

    final endingDatePicker = TextFormField(
      controller: endingDateController,
      decoration: const InputDecoration(border: OutlineInputBorder(),
                                        label: Text("Data Final do Tratamento"),
                                        floatingLabelBehavior: FloatingLabelBehavior.auto),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: endingDate,
          firstDate: DateTime(2000),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        );
        if (pickedDate != null) {
          setState(() {
            endingDate = pickedDate;
            endingDateController.text = formatter.format(pickedDate);
          });
        }
      },
    );

    final saveButton = Button(text: "Confirmar", color: Colors.green, onPressed: registerTreatment);

    Divider divider = const Divider(color: Colors.transparent);

    final column = <Widget>[
      bovineSelector,
      divider,
      medicineNameField,
      divider,
      reasonField,
      divider,
      startingDatePicker,
      divider,
      endingDatePicker,
      divider,
      saveButton
    ];

    return IntegrazooBaseApp(
      title: "REGISTRAR TRATAMENTO",
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

  void registerTreatment() {
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

      final treatment = Treatment.fromJson({
        'id': widget.treatment?.id ?? 0,
        'medicine': medicineController.text,
        'reason': reasonController.text,
        'startingDate': startingDate,
        'endingDate': endingDate,
        'bovine': earringController.earring,
      });

      TreatmentController.saveTreatment(treatment).then(
        (_) {
          if (context.mounted) {
            SnackBar snackBar = const SnackBar(
              content: Text('Tratamento registrado com sucesso.'),
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
        },
      );

    }
  }

  String? validateAllFields() {
    if (earringController.earring == null) {
      return 'Por favor, escolha o animal.';
    }

    if (medicineController.text.isEmpty) {
      return 'Por favor, digite o medicamento utilizado.';
    }

    if (reasonController.text.isEmpty) {
      return 'Por favor, digite a razão do tratamento.';
    }

    return null;
  }

  void clearForm() {
    setState(() {
      medicineController.text = "";
      reasonController.text = "";

      startingDate = DateTime.now();
      startingDateController.text = formatter.format(startingDate);

      endingDate = DateTime.now();
      endingDateController.text = formatter.format(endingDate);

      earringController.clear();
    });
  }
}
