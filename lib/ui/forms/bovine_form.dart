import 'dart:developer'; // ignore: unused_import

import 'package:flutter/material.dart';
import 'package:integrazoo/styles/app_text_styles.dart';

import 'package:intl/intl.dart';

import 'package:integrazoo/backend.dart';


class BovineForm extends StatefulWidget {
  final Bovine? bovine;
  final bool shouldPop;
  final VoidCallback? postSaved;

  const BovineForm({ super.key, this.bovine, this.shouldPop = false, this.postSaved });

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

  DateTime entryDate = DateTime.now();
  final entryDateController = TextEditingController();
  final entryWeightController = TextEditingController();

  Sex bovineSex = Sex.female;
  bool isBreeder = false;

  @override
  void initState() {
    super.initState();

    entryDateController.text = DateFormat.yMd("pt_BR").format(entryDate);

    if (widget.bovine != null) {
      earringController.text = widget.bovine!.earring.toString();
      nameController.text = widget.bovine!.name?.toString() ?? "";
      bovineSex = widget.bovine!.sex;
      isBreeder = widget.bovine!.isBreeder;

      loadBovineEntry(widget.bovine!.earring);
    }

    sexController.text = bovineSex.toString();
  }

  Future<void> loadBovineEntry(int earring) async {
    final entry = await BovineService.getBovineEntry(earring); // Fetch the entry data

    if (entry != null) {
      setState(() {
        entryWeightController.text = entry.weight?.toString() ?? "";

        entryDate = entry.date ?? entryDate;
        entryDateController.text = DateFormat.yMd("pt_BR").format(entryDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final nameField = TextFormField(
      keyboardType: TextInputType.text,
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

    final entryDatePicker = TextFormField(
      controller: entryDateController,
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
          setState(() {
            entryDate = pickedDate;
            entryDateController.text = DateFormat.yMd("pt_BR").format(pickedDate);
          });
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

    final addButton = TextButton(onPressed: createBovine, child: const Text("SALVAR"));

    const divider = Divider(height: 8, color: Colors.transparent);

    final header = Text(
      widget.bovine == null ? "REGISTRANDO ANIMAL" : "EDITANDO ANIMAL #${widget.bovine!.earring}",
      textAlign: TextAlign.center,
      style: AppTextStyles.pageHeading,
    );

    final column = <Widget>[
      header,
      if (widget.bovine == null) ...[
        earringField,
        divider,
      ],
      nameField,
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
          entryDatePicker,
          divider,
          entryWeightField,
        ],
      ),
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

      await transaction(() async {
        final exists = await BovineService.doesEarringExists(int.parse(earringController.text));

        if (exists && widget.bovine == null) {
          if (mounted) {
            SnackBar snackBar = const SnackBar(
              content: Text('Brinco ja foi utilizado.'),
              backgroundColor: Colors.red,
              showCloseIcon: true
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        } else {
          await saveBovine();

          if (entryWeightController.text.isNotEmpty || entryDateController.text.isNotEmpty) {
            await saveEntry();
          }

          if (mounted) {
            SnackBar snackBar = const SnackBar(
              content: Text('Informações salvas com sucesso.'),
              backgroundColor: Colors.green,
              showCloseIcon: true
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);

            if (widget.shouldPop) {
              Navigator.of(context).pop();
            } else {
              clearForm();
            }

            widget.postSaved?.call();
          }
        }
      });

    }
  }

  Future<int> saveBovine() {
    final bovine = Bovine.fromJson({
      'name': nameController.text.isEmpty ? null : nameController.text,
      'sex': bovineSex.index,
      'earring': int.parse(earringController.text),
      'wasDiscarded': widget.bovine?.wasDiscarded ?? false,
      'isReproducing': widget.bovine?.isReproducing ?? false,
      'isPregnant': widget.bovine?.isPregnant ?? false,
      'hasBeenWeaned': widget.bovine?.hasBeenWeaned ?? false,
      'isBreeder': isBreeder,
    });

    return BovineService.saveBovine(bovine);
  }

  Future<int> saveEntry() {
    final bovineEntry = BovineEntry.fromJson({
      'bovine': int.parse(earringController.text),
      'weight': double.tryParse(entryWeightController.text),
      'date': entryDate,
    });

    return BovineService.saveBovineEntry(bovineEntry);
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
      entryWeightController.clear();
      entryDateController.clear();
      bovineSex = Sex.female;
      sexController.text = bovineSex.toString();
      isBreeder = false;
    });
  }
}
