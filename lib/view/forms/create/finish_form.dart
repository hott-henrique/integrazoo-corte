import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:integrazoo/control/finish_controller.dart';

import 'package:intl/intl.dart';

import 'package:integrazoo/base.dart';

import 'package:integrazoo/view/components/button.dart';

import 'package:integrazoo/view/components/bovine/single_bovine_selector.dart';
import 'package:integrazoo/view/components/bovine/earring_controller.dart';

import 'package:integrazoo/control/bovine_controller.dart';

import 'package:integrazoo/database/database.dart';


class FinishForm extends StatefulWidget {
  const FinishForm({ super.key });

  @override
  State<FinishForm> createState() => _FinishForm();
}

class _FinishForm extends State<FinishForm> {
  final _formKey = GlobalKey<FormState>();

  final earringController = EarringController();

  FinishingReason? reason;

  final weightController = TextEditingController();
  final hotCarcassWeightController = TextEditingController();

  final observationController = TextEditingController();

  late final TextEditingController dateController;
  DateTime date = DateTime.now();

  final DateFormat formatter = DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    super.initState();
    dateController = TextEditingController(text: formatter.format(date));
  }

  @override
  Widget build(BuildContext context) {
    final bovineSelector = SingleBovineSelector(earringController: earringController, wasDiscarded: false);

    final reasonDropdown = DropdownMenu<FinishingReason>(
      initialSelection: reason,
      dropdownMenuEntries: FinishingReason.values.map((r) => DropdownMenuEntry(value: r, label: r.toString())).toList(),
      onSelected: (value) => setState(() => reason = value!),
      label: const Text('Motivação'),
      expandedInsets: EdgeInsets.zero
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

    final hotCarcassWeightField = TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(border: OutlineInputBorder(),
                                        label: Text("Peso da Carcaça Quente - Kilogramas"),
                                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                                        hintText: "Digite o peso da carcaça quente em kilogramas."),
      controller: hotCarcassWeightController,
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

    final observationField = TextFormField(
      keyboardType: TextInputType.text,
      controller: observationController,
      decoration: const InputDecoration(border: OutlineInputBorder(),
                                        label: Text("Observação (Opcional)"),
                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                        hintText: "Digite alguma observação sobre essa finalização.")
    );

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

    final addButton = Button(text: "SALVAR", color: Colors.green, onPressed: discardBovine);

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
      if (reason == FinishingReason.slaughter) ...[
        weightField,
        divider,
        hotCarcassWeightField,
        divider,
      ],
      addButton
    ];

    return IntegrazooBaseApp(
      title: "FINALIZAR ANIMAL",
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

      final discard = Finish.fromJson({
        'id': 0,
        'bovine': earring,
        'date': date,
        'reason': reason!.index,
        'observation': observationController.text.isEmpty ? null : observationController.text,
        'weight': double.tryParse(weightController.text),
        'hotCarcassWeight': double.tryParse(hotCarcassWeightController.text)
      });

      FinishController.save(earring, discard).then(
        (_) {
          if (mounted) {
            SnackBar snackBar = const SnackBar(
              content: Text('Finalização salva com sucesso.'),
              backgroundColor: Colors.green,
              showCloseIcon: true
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            clearForm();
          }
        }
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
