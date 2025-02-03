import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:integrazoo/base.dart';

import 'package:integrazoo/view/components/button.dart';
import 'package:integrazoo/view/components/unexpected_error_alert_dialog.dart';

import 'package:integrazoo/control/bovine_controller.dart';

import 'package:integrazoo/database/database.dart';

import 'package:integrazoo/globals.dart';


class BovineForm extends StatefulWidget {
  const BovineForm({ super.key });

  @override
  BovineFormState createState() {
    return BovineFormState();
  }
}

class BovineFormState extends State<BovineForm> {
  final _formKey = GlobalKey<FormState>();

  final earringController = TextEditingController();
  final nameController = TextEditingController();
  final sexController = TextEditingController();
  Sex bovineSex = Sex.female;
  bool isBreeder = false;

  late final TextEditingController dateEntryController;

  final entryWeightController = TextEditingController();

  final DateFormat formatter = DateFormat('dd/MM/yyyy');

  Exception? exception;

  @override
  void initState() {
    super.initState();
    sexController.text = bovineSex.toString();
    dateEntryController = TextEditingController(text: null);
  }

  @override
  Widget build(BuildContext context) {
    if (exception != null) {
      return UnexpectedErrorAlertDialog(title: 'Erro Inesperado',
                                        message: 'Algo de inespearado aconteceu durante a execução do aplicativo.',
                                        onPressed: () => setState(() => exception = null));
    }

    final nameField = TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        label: Text("Nome do Animal (Opcional)"),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: "Digite o nome do animal"
      ),
      controller: nameController,
    );

    final earringField = TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        label: Text("Brinco"),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: "Digite o brinco do animal"
      ),
      controller: earringController,
      validator: (String? value) {
        if (value == null) {
          return null;
        }

        if (value.isNotEmpty && int.tryParse(value) == null) {
          return "Por favor, digite um número válido.";
        }

        return null;
      },
    );

    final sexDropdown = DropdownMenu<Sex?>(
      label: const Text("Sexo"),
      controller: sexController,
      dropdownMenuEntries: Sex.values.map((sex) => DropdownMenuEntry(value: sex, label: sex.toString())).toList(),
      onSelected: (value) {
        if (value == null) {
          return;
        }

        setState(() => bovineSex = value);
      },
      expandedInsets: EdgeInsets.zero,
    );

    final dateEntryPicker = TextFormField(
      controller: dateEntryController,
      decoration: const InputDecoration(border: OutlineInputBorder(),
                                        label: Text("Data"),
                                        hintText: "Digite a data de aquisição do animal.",
                                        floatingLabelBehavior: FloatingLabelBehavior.always),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: null,
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
        );
        if (pickedDate != null) {
          setState(() => dateEntryController.text = formatter.format(pickedDate));
        }
      },
    );

    final entryWeightField = TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(border: OutlineInputBorder(),
                                        label: Text("Peso"),
                                        hintText: "Digite o peso de aquisição do animal.",
                                        floatingLabelBehavior: FloatingLabelBehavior.always),
      controller: entryWeightController,
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

    final isBreederCheckbox = Row(children: [
      Checkbox(value: isBreeder, onChanged: (value) => (
       setState(() {
          if (value == null) return;

          isBreeder = value;
        })
      )),
      Text(bovineSex == Sex.male ? "Reprodutor" : "Matriz")
    ]);

    final addButton = Button(text: "SALVAR", color: Colors.green[400]!, onPressed: createBovine);

    const divider = Divider(height: 8, color: Colors.transparent);

    final column = <Widget>[
      nameField,
      divider,
      earringField,
      divider,
      sexDropdown,
      divider,
      isBreederCheckbox,
      divider,
      ExpansionTile(
        title: const Text("Informações de Aquisição (Opcional)"),
        shape: Border.all(width: 0, color: Colors.transparent),
        children: [
          divider,
          dateEntryPicker,
          divider,
          entryWeightField,
        ],
      ),
      divider,
      addButton
    ];

    return IntegrazooBaseApp(
      title: "REGISTRAR ANIMAL",
      body: SingleChildScrollView(child: Form(
        autovalidateMode: AutovalidateMode.always,
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: column)
        )
      ))
    );
  }

  void createBovine() async {
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

      await database.transaction(() async {
          final exists = await BovineController.doesEarringExists(int.parse(earringController.text));

          if (exists) {
            SnackBar snackBar = const SnackBar(
              content: Text('Brinco ja foi utilizado.'),
              backgroundColor: Colors.red,
              showCloseIcon: true
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else {
            await saveBovine();
            if (entryWeightController.text.isNotEmpty || dateEntryController.text.isNotEmpty) {
              await saveEntry();
            }

            if (context.mounted) {
              SnackBar snackBar = const SnackBar(
                content: Text('Animal adicionado com sucesso.'),
                backgroundColor: Colors.green,
                showCloseIcon: true
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              clearForm();
            }
          }
      });

    }
  }

  Future<int> saveBovine() {
    final bovine = Bovine.fromJson({
      'name': nameController.text.isEmpty ? null : nameController.text,
      'sex': bovineSex!.index,
      'earring': int.parse(earringController.text),
      'wasDiscarded': false,
      'isReproducing': false,
      'isPregnant': false,
      'hasBeenWeaned': false,
      'isBreeder': isBreeder,
      'weight540': null
    });

    return BovineController.saveBovine(bovine);
  }

  Future<int> saveEntry() {
    final bovineEntry = BovineEntry.fromJson({
      'bovine': int.parse(earringController.text),
      'weight': double.tryParse(entryWeightController.text),
      'date': DateTime.tryParse(dateEntryController.text),
    });

    return BovineController.saveBovineEntry(bovineEntry);
  }

  String? validateAllFields() {
    if (earringController.text.isEmpty) {
      return 'Por favor, digite o brinco do animal.';
    }

    return null;
  }

  void clearForm() {
    setState(() {
      nameController.clear();
      earringController.clear();
      sexController.clear();
      entryWeightController.clear();
      dateEntryController.clear();
      bovineSex = Sex.female;
      isBreeder = false;
    });
  }
}
