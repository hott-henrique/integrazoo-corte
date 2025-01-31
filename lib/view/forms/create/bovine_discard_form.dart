import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:integrazoo/base.dart';

import 'package:integrazoo/view/components/button.dart';
import 'package:integrazoo/view/components/unexpected_error_alert_dialog.dart';

import 'package:integrazoo/view/components/bovine/single_bovine_selector.dart';
import 'package:integrazoo/view/components/bovine/earring_controller.dart';

import 'package:integrazoo/control/bovine_controller.dart';
import 'package:integrazoo/database/database.dart';


class BovineDiscardForm extends StatefulWidget {
  const BovineDiscardForm({ super.key });

  @override
  BovineDiscardFormState createState() {
    return BovineDiscardFormState();
  }
}

class BovineDiscardFormState extends State<BovineDiscardForm> {
  final _formKey = GlobalKey<FormState>();

  final earringController = EarringController();

  final observationController = TextEditingController();
  final weightController = TextEditingController();
  DiscardReason? reason;

  late final TextEditingController dateController;
  DateTime date = DateTime.now();

  final DateFormat formatter = DateFormat('dd/MM/yyyy');

  Exception? exception;

  @override
  void initState() {
    super.initState();
    dateController = TextEditingController(text: formatter.format(date));
  }

  @override
  Widget build(BuildContext context) {
    if (exception != null) {
      return UnexpectedErrorAlertDialog(title: 'Erro Inesperado',
                                        message: 'Algo de inespearado aconteceu durante a execução do aplicativo.',
                                        onPressed: () => setState(() => exception = null));
    }

    final reasonDropdown = DropdownMenu<DiscardReason>(
      initialSelection: reason,
      dropdownMenuEntries: DiscardReason.values.map((r) => DropdownMenuEntry(value: r, label: r.toString())).toList(),
      onSelected: (value) => setState(() => reason = value!),
      label: const Text('Motivação'),
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


    final addButton = Button(text: "Confirmar Descarte", color: Colors.red, onPressed: discardBovine);

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

    final bovineSelector = SingleBovineSelector(earringController: earringController, wasDiscarded: false);

    Divider divider = const Divider(color: Colors.transparent);

    final column = <Widget>[
      bovineSelector,
      divider,
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

    return IntegrazooBaseApp(
      title: "DESCARTAR ANIMAL",
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

      int earring = earringController.earring!;

      final discard = Discard.fromJson({
        'id': 0,
        'bovine': earring,
        'date': date,
        'reason': reason!.index,
        'observation': observationController.text.isEmpty ? null : observationController.text,
        'weight': double.tryParse(weightController.text)
      });

      BovineController.discard(earring, discard).then(
        (_) {
          if (context.mounted) {
            SnackBar snackBar = const SnackBar(
              content: Text('Descarte realizado.'),
              backgroundColor: Colors.green,
              showCloseIcon: true
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            clearForm();
          }
        },
        onError: (e) => setState(() => exception = e)
      );
    }
  }

  void updateBovineStatus() {
    BovineController.getBovine(earringController.earring!).then(
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

    if (earringController.earring == null) {
      return 'Por favor, escolha um animal.';
    }

    return null;
  }

  void clearForm() {
    setState(() {
      earringController.clear();
      observationController.clear();
      weightController.clear();
      reason = null;
      date = DateTime.now();
      dateController.text = formatter.format(date);
    });
  }
}
