import 'dart:developer';

import 'package:flutter/material.dart';



import 'package:integrazoo/control/bovine_controller.dart';

import 'package:integrazoo/database/database.dart';

import 'package:integrazoo/globals.dart';


class BovineInfoForm extends StatefulWidget {
  final int earring;
  final Bovine? bovine;
  final VoidCallback postSaved;

  const BovineInfoForm({ super.key, required this.earring, this.bovine, required this.postSaved });

  @override
  BovineInfoFormState createState() {
    return BovineInfoFormState();
  }
}

class BovineInfoFormState extends State<BovineInfoForm> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final sexController = TextEditingController();
  Sex? bovineSex;
  late bool isBreeder;

  late final TextEditingController dateEntryController;

  final weightController = TextEditingController();
  final entryWeightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dateEntryController = TextEditingController(text: null);
    bovineSex = widget.bovine?.sex;
    isBreeder = widget.bovine == null ? false : widget.bovine!.isBreeder;
    sexController.text = widget.bovine?.sex.toString() ?? "";
    nameController.text = widget.bovine?.name ?? "";
    weightController.text = widget.bovine?.weight540.toString() ?? "";
  }

  @override
  Widget build(BuildContext context) {
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

    final sexDropdown = DropdownMenu<Sex?>(
      label: const Text("Sexo"),
      controller: sexController,
      dropdownMenuEntries: Sex.values.map((sex) => DropdownMenuEntry(value: sex, label: sex.toString())).toList(),
      onSelected: (value) => bovineSex = value,
      expandedInsets: EdgeInsets.zero,
    );

    final weight540Field = TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        label: Text("Peso ao Sobreano"),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: "Digite o peso ao sobreano do animal"
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

    final isBreederCheckbox = Row(children: [
      Checkbox(value: isBreeder, onChanged: (value) => (
       setState(() {
          if (value == null) return;

          isBreeder = value;
        })
      )),
      const Text("Reprodutor")
    ]);

    final addButton = TextButton(onPressed: createBovine, child: const Text("SALVAR"));

    const divider = Divider(height: 8, color: Colors.transparent);

    final column = <Widget>[
      nameField,
      divider,
      sexDropdown,
      divider,
      weight540Field,
      divider,
      isBreederCheckbox,
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
        await saveBovine();

        if (entryWeightController.text.isNotEmpty || dateEntryController.text.isNotEmpty) {
          await saveEntry();
        }

        if (context.mounted) {
          SnackBar snackBar = const SnackBar(
            content: Text('Informações salvas com sucesso.'),
            backgroundColor: Colors.green,
            showCloseIcon: true
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          widget.postSaved();
          clearForm();
        }
      });

    }
  }

  Future<int> saveBovine() {
    final bovine = Bovine.fromJson({
      'name': nameController.text.isEmpty ? null : nameController.text,
      'sex': bovineSex!.index,
      'earring': widget.earring,
      'wasDiscarded': false,
      'isReproducing': false,
      'isPregnant': false,
      'hasBeenWeaned': false,
      'isBreeder': isBreeder,
      'weight540': double.tryParse(weightController.text)
    });

    return BovineController.saveBovine(bovine);
  }

  Future<int> saveEntry() {
    final bovineEntry = BovineEntry.fromJson({
      'bovine': widget.earring,
      'weight': double.tryParse(entryWeightController.text),
      'date': DateTime.tryParse(dateEntryController.text),
    });

    return BovineController.saveBovineEntry(bovineEntry);
  }

  String? validateAllFields() {
    if (bovineSex == null) {
      return 'Por favor, selecione o sexo do animal.';
    }

    return null;
  }

  void clearForm() {
    setState(() {
      nameController.clear();
      sexController.clear();
      bovineSex = null;
      entryWeightController.clear();
      dateEntryController.clear();
    });
  }
}
