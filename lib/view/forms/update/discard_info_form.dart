import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:integrazoo/view/components/button.dart';
import 'package:integrazoo/view/components/unexpected_error_alert_dialog.dart';

import 'package:integrazoo/control/bovine_controller.dart';

import 'package:integrazoo/database/database.dart';


class DiscardInfoForm extends StatefulWidget {
  final int earring;
  final Discard? discard;
  final VoidCallback postSaved;

  const DiscardInfoForm({ super.key, required this.earring, this.discard, required this.postSaved});

  @override
  DiscardInfoFormState createState() {
    return DiscardInfoFormState();
  }
}

class DiscardInfoFormState extends State<DiscardInfoForm> {
  final _formKey = GlobalKey<FormState>();

  final observationController = TextEditingController();
  final weightController = TextEditingController();

  final reasonController = TextEditingController();
  DiscardReason? reason;

  late DateTime date;
  late final TextEditingController dateController;

  final DateFormat formatter = DateFormat('dd/MM/yyyy');

  Exception? exception;

  @override
  void initState() {
    super.initState();

    date = widget.discard?.date ?? DateTime.now();
    dateController = TextEditingController(text: formatter.format(date));
    weightController.text = (widget.discard?.weight ?? "").toString();
    observationController.text = widget.discard?.observation ?? "";
    reasonController.text = (widget.discard?.reason ?? "").toString();
    reason = widget.discard?.reason;
  }

  @override
  Widget build(BuildContext context) {
    if (exception != null) {
      return UnexpectedErrorAlertDialog(title: 'Erro Inesperado',
                                        message: 'Algo de inespearado aconteceu durante a execução do aplicativo.',
                                        onPressed: () => setState(() => exception = null));
    }

    final reasonDropdown = DropdownMenu<DiscardReason>(
      dropdownMenuEntries: DiscardReason.values.map((r) => DropdownMenuEntry(value: r, label: r.toString())).toList(),
      onSelected: (value) => setState(() => reason = value!),
      label: const Text('Motivação'),
      controller: reasonController,
      expandedInsets: EdgeInsets.zero
    );

    final observationField = TextFormField(
      keyboardType: TextInputType.text,
      controller: observationController,
      decoration: const InputDecoration(border: OutlineInputBorder(),
                                        label: Text("Observação"),
                                        floatingLabelBehavior: FloatingLabelBehavior.auto)
    );

    final weightField = TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(border: OutlineInputBorder(),
                                        label: Text("Peso - Kilogramas"),
                                        floatingLabelBehavior: FloatingLabelBehavior.auto),
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

    final addButton = Button(text: "SALVAR", color: Colors.green, onPressed: discardBovine);

    final datePicker = TextFormField(
      controller: dateController,
      decoration: const InputDecoration(border: OutlineInputBorder(),
                                        label: Text("Data do Descarte"),
                                        floatingLabelBehavior: FloatingLabelBehavior.auto),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: date,
          firstDate: DateTime(2000),
          lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
        );
        if (pickedDate != null) {
          setState(() {
            date= pickedDate;
            dateController.text = formatter.format(pickedDate);
          });
        }
      },
    );

    Divider divider = const Divider(color: Colors.transparent);

    final column = <Widget>[
      reasonDropdown,
      divider,
      observationField,
      divider,
      datePicker,
      divider,
      weightField,
      divider,
      addButton
    ];

    return Form(
      autovalidateMode: AutovalidateMode.always,
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: column)
      )
    );
  }

  void discardBovine() {
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

      updateBovineStatus();

      final discard = Discard.fromJson({
        'id': 0,
        'bovine': widget.earring,
        'date': date,
        'reason': reason!.index,
        'observation': observationController.text.isEmpty ? null : observationController.text,
        'weight': double.tryParse(weightController.text)
      });

      BovineController.discard(widget.earring, discard).then(
        (_) {
          if (context.mounted) {
            SnackBar snackBar = const SnackBar(
              content: Text('Informações de descartes salvas com sucesso.'),
              backgroundColor: Colors.green,
              showCloseIcon: true
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            clearForm();
            widget.postSaved();
          }
        },
        onError: (e) => setState(() => exception = e)
      );
    }
  }

  void updateBovineStatus() {
    BovineController.getBovine(widget.earring).then(
      (bovine) {
        if (bovine == null) {
          // TODO: RAISE ERROR.
          return;
        }

        final bovineUpdate = bovine.copyWith(wasDiscarded: true);

        BovineController.saveBovine(bovineUpdate);
      }
    );
  }

  String? validateAllFields() {
    if (reason == null) {
      return 'Por favor, escolha a razão do descarte.';
    }

    return null;
  }

  void clearForm() {
    setState(() {
      observationController.clear();
      weightController.clear();
      reason = null;
      date = DateTime.now();
      dateController.text = formatter.format(date);
    });
  }
}
