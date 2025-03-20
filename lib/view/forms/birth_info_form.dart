import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';


import 'package:integrazoo/control/birth_controller.dart';

import 'package:integrazoo/database/database.dart';

import 'package:integrazoo/globals.dart';


class BirthInfoForm extends StatefulWidget {
  final int? earring;
  final Birth? birth;
  final bool shouldPop;
  final bool shouldShowHeader;

  const BirthInfoForm({ super.key, this.earring, this.birth, this.shouldPop = false, this.shouldShowHeader = true });

  @override
  State<BirthInfoForm> createState() => _BirthInfoForm();
}

class _BirthInfoForm extends State<BirthInfoForm> {
  final _formKey = GlobalKey<FormState>();

  final newBornWeightController = TextEditingController();

  final newBornBCSController = TextEditingController();
  BodyConditionScore? newBornBCS;

  final observationController = TextEditingController();

  late final TextEditingController dateBirthController;
  DateTime dateBirth = DateTime.now();

  @override
  void initState() {
    super.initState();
    dateBirthController = TextEditingController(text: DateFormat.yMd("pt_BR").format(widget.birth?.date ?? dateBirth));

    newBornWeightController.text = (widget.birth?.weight ?? "").toString();
    newBornBCSController.text = (widget.birth?.bcs ?? "").toString();
    newBornBCS = widget.birth?.bcs;
  }

  @override
  Widget build(BuildContext context) {
    final addButton = TextButton(onPressed: saveBirth, child: const Text("SALVAR"));

    final dateBirthPicker = TextFormField(
      controller: dateBirthController,
      decoration: const InputDecoration(border: OutlineInputBorder(),
                                        label: Text("Data do Parto"),
                                        floatingLabelBehavior: FloatingLabelBehavior.always),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: dateBirth,
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
        );
        if (pickedDate != null) {
          setState(() {
            dateBirth = pickedDate;
            dateBirthController.text = DateFormat.yMd("pt_BR").format(pickedDate);
          });
        }
      },
    );

    final newBornWeightField = TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(border: OutlineInputBorder(),
                                        label: Text("Peso ao Nascer do Novo Animal"),
                                        hintText: "Digite o peso do animal que nasceu.",
                                        floatingLabelBehavior: FloatingLabelBehavior.always),
      controller: newBornWeightController,
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

    final newBornBCSDropdown = DropdownMenu<BodyConditionScore>(
      label: const Text("Avaliação Corporal"),
      dropdownMenuEntries: BodyConditionScore.values.map((bcs) => DropdownMenuEntry(value: bcs, label: bcs.toString())).toList(),
      onSelected: (value) => newBornBCS = value!,
      expandedInsets: EdgeInsets.zero,
      controller: newBornBCSController
    );

    final header = Text(
      widget.earring != null ?
      "REGISTRANDO NASCIMENTO DO ANIMAL #${widget.earring!}" :
      "EDITANDO NASCIMENTO DO ANIMAL #${widget.birth!.bovine}",
      textAlign: TextAlign.center,
      textScaler: const TextScaler.linear(1.5)
    );

    Divider divider = const Divider(color: Colors.transparent);

    final column = <Widget>[
      if (widget.shouldShowHeader) header,
      dateBirthPicker,
      divider,
      newBornWeightField,
      divider,
      newBornBCSDropdown,
      divider,
      addButton
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: column)
      )
    );
  }

  void saveBirth() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();

      String? error = validateAllFields();

      if (error != null) {
        if (context.mounted) {
          SnackBar snackBar = SnackBar(
            content: Text(error),
            backgroundColor: Colors.red,
            showCloseIcon: true
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        return;
      }

      await database.transaction(() async {
        await saveBirthInfo();

        SnackBar snackBar = const SnackBar(
          content: Text("Informações salvas com sucesso."),
          backgroundColor: Colors.green,
          showCloseIcon: true
        );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

          clearForm();

          if (widget.shouldPop) {
            Navigator.of(context).pop();
          }
        }
      });
    }
  }


  Future<int> saveBirthInfo() {
    final newBornWeight = double.parse(newBornWeightController.text);

    // TODO: Check/Find pregnancy that generated this animal.

    final birth = Birth.fromJson({
      'date': dateBirth,
      'weight': newBornWeight,
      'bcs': newBornBCS!.index,
      'bovine': widget.earring,
      'pregnancy': null
    });

    return BirthController.saveBirth(birth);
  }

  String? validateAllFields() {
    if (newBornWeightController.text.isEmpty) {
      return "Por favor, digite o peso do novo animal";
    }

    if (newBornBCS == null) {
      return "Por favor, selecione a avaliação corporal do novo animal.";
    }

    return null;
  }

  void clearForm() {
    setState(() {
      newBornWeightController.clear();
      newBornBCSController.clear();
      newBornBCS = null;

      observationController.clear();
    });
  }
}
