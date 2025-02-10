import 'dart:developer';

import 'package:flutter/material.dart';



import 'package:integrazoo/control/breeder_controller.dart';
import 'package:integrazoo/database/database.dart';


class BreederForm extends StatefulWidget {
  final Breeder? breeder;
  final bool shoudPop;

  const BreederForm({ super.key, this.breeder, this.shoudPop = false });

  @override
  BreederFormState createState() {
    return BreederFormState();
  }
}

class BreederFormState extends State<BreederForm> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();

  final fatherNameController = TextEditingController();
  final motherNameController = TextEditingController();

  final paternalGrandfatherNameController = TextEditingController();
  final paternalGrandmotherNameController = TextEditingController();

  final maternalGrandfatherNameController = TextEditingController();
  final maternalGrandmotherNameController = TextEditingController();

  final epdBirthWeightController = TextEditingController();
  final epdWeaningWeightController = TextEditingController();
  final epdYearlingWeightController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.breeder != null) {
      nameController.text = widget.breeder!.name;

      fatherNameController.text = widget.breeder!.father ?? "";
      motherNameController.text = widget.breeder!.mother ?? "";

      paternalGrandfatherNameController.text = widget.breeder!.paternalGrandfather ?? "";
      paternalGrandmotherNameController.text = widget.breeder!.paternalGrandmother ?? "";
      maternalGrandfatherNameController.text = widget.breeder!.maternalGrandfather ?? "";
      maternalGrandmotherNameController.text = widget.breeder!.maternalGrandfather ?? "";

      epdBirthWeightController.text = widget.breeder?.epdBirthWeight?.toString() ?? "";
      epdWeaningWeightController.text = widget.breeder?.epdWeaningWeight?.toString() ?? "";
      epdYearlingWeightController.text = widget.breeder?.epdYearlingWeight?.toString() ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final nameField = TextFormField(
      keyboardType: TextInputType.text,
      controller: nameController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        label: Text("Nome do Animal"),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: "Digite o nome do reprodutor"
      )
    );

    final fatherNameField = TextFormField(
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        label: Text("Nome do Pai (Opcional)"),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: "Digite o nome do pai"
      ),
      controller: fatherNameController
    );

    final motherNameField = TextFormField(
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        label: Text("Nome da Mãe (Opcional)"),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: "Digite o nome da avó paterna"
      ),
      controller: motherNameController,
    );

    final paternalGrandfatherNameField = TextFormField(
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        label: Text("Nome do Avô"),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: "Digite o nome do avô paterno"
      ),
      controller: paternalGrandfatherNameController,
    );

    final paternalGrandmotherNameField = TextFormField(
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        label: Text("Nome da Avó"),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: "Digite o nome da avó paterna"
      ),
      controller: paternalGrandmotherNameController,
    );

    final maternalGrandfatherNameField = TextFormField(
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        label: Text("Nome do Avô"),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: "Digite o nome do avô materno"
      ),
      controller: maternalGrandfatherNameController,
    );

    final maternalGrandmotherNameField = TextFormField(
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        label: Text("Nome da Avó"),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: "Digite o nome da avó materna"
      ),
      controller: maternalGrandmotherNameController,
    );

    final epdBirthWeightField = TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(border: OutlineInputBorder(),
                                        label: Text("Peso ao Nascimento - PN"),
                                        hintText: "Digite o peso ao nascimento do animal.",
                                        floatingLabelBehavior: FloatingLabelBehavior.always),
      controller: epdBirthWeightController,
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

    final epdWeaningWeightField = TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(border: OutlineInputBorder(),
                                        label: Text("Peso a Desmama - PD"),
                                        hintText: "Digite o peso a desmama do animal.",
                                        floatingLabelBehavior: FloatingLabelBehavior.always),
      controller: epdWeaningWeightController,
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

    final epdYearlingWeightField = TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(border: OutlineInputBorder(),
                                        label: Text("Peso ao Sobreano - PA"),
                                        hintText: "Digite o peso do animal ao entrar.",
                                        floatingLabelBehavior: FloatingLabelBehavior.always),
      controller: epdYearlingWeightController,
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

    final addButton = TextButton(onPressed: createBovine, child: const Text("SALVAR"));

    const divider = Divider(height: 16, color: Colors.transparent);

    final column = <Widget>[
      if (widget.breeder != null) ...[
        nameField,
        divider,
      ],
      fatherNameField,
      divider,
      motherNameField,
      const Divider(height: 16, color: Colors.black),
      ExpansionTile(
        title: const Text("Avós Paternos (Opcional)"),
        children: [
          divider,
          paternalGrandfatherNameField,
          divider,
          paternalGrandmotherNameField,
          divider,
        ],
      ),
      ExpansionTile(
        title: const Text("Avós Maternos (Opcional)"),
        children: [
          divider,
          maternalGrandfatherNameField,
          divider,
          maternalGrandmotherNameField,
          divider,
        ]
      ),
      ExpansionTile(
        title: const Text("Diferença Esperada na Progênie - DEP (Opcional)"),
        children: [
          divider,
          epdBirthWeightField,
          divider,
          epdWeaningWeightField,
          divider,
          epdYearlingWeightField,
          divider,
        ]
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
    // return IntegrazooBaseApp(
    //   title: "REGISTRAR REPRODUTOR",
    //   body: SingleChildScrollView(child: Form(
    //     autovalidateMode: AutovalidateMode.always,
    //     key: _formKey,
    //     child: Container(
    //       padding: const EdgeInsets.all(8.0),
    //       child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: column)
    //     )
    //   ))
    // );
  }

  void createBovine() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

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

      final breeder = Breeder.fromJson({
        'id': 0,
        'name': nameController.text,
        'father': fatherNameController.text.isEmpty ? null : fatherNameController.text,
        'mother': motherNameController.text.isEmpty ? null : motherNameController.text,
        'paternalGrandfather': paternalGrandfatherNameController.text.isEmpty ? null : paternalGrandfatherNameController.text,
        'paternalGrandmother': paternalGrandmotherNameController.text.isEmpty ? null : paternalGrandmotherNameController.text,
        'maternalGrandfather': maternalGrandfatherNameController.text.isEmpty ? null : maternalGrandfatherNameController.text,
        'maternalGrandmother': maternalGrandmotherNameController.text.isEmpty ? null : maternalGrandmotherNameController.text,
        'epdBirthWeight': epdBirthWeightController.text.isEmpty ? null : double.parse(epdBirthWeightController.text),
        'epdWeaningWeight': epdWeaningWeightController.text.isEmpty ? null : double.parse(epdWeaningWeightController.text),
        'epdYearlingWeight': epdYearlingWeightController.text.isEmpty ? null : double.parse(epdYearlingWeightController.text),
      });

      BreederController.saveBreeder(breeder).then(
        (_) {
          if (context.mounted) {
            SnackBar snackBar = const SnackBar(
              content: Text('Reprodutor adicionado com sucesso.'),
              backgroundColor: Colors.green,
              showCloseIcon: true
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            clearForm();
          }
        },
      );
    }
  }

  String? validateAllFields() {
    if (nameController.text.isEmpty) {
      return "Por favor, digite o nome do reprodutor.";
    }

    return null;
  }

  void clearForm() {
    setState(() {
      nameController.clear();
      fatherNameController.clear();
      motherNameController.clear();
      paternalGrandfatherNameController.clear();
      paternalGrandmotherNameController.clear();
      maternalGrandfatherNameController.clear();
      maternalGrandmotherNameController.clear();
      epdBirthWeightController.clear();
      epdWeaningWeightController.clear();
      epdYearlingWeightController.clear();
    });
  }
}
