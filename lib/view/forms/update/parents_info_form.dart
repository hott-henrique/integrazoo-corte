import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:integrazoo/view/components/button.dart';

import 'package:integrazoo/control/bovine_controller.dart';
import 'package:integrazoo/control/breeder_controller.dart';
import 'package:integrazoo/control/parents_controller.dart';

import 'package:integrazoo/database/database.dart';


class ParentsInfoForm extends StatefulWidget {
  final int earring;
  final Parents? parents;
  final VoidCallback postSaved;

  const ParentsInfoForm({ super.key, required this.earring, this.parents, required this.postSaved });

  @override
  State<ParentsInfoForm> createState() => _ParentsInfoForm();
}

class _ParentsInfoForm extends State<ParentsInfoForm> {
  final _formKey = GlobalKey<FormState>();

  final fatherController = TextEditingController();
  final motherController = TextEditingController();

  String? fatherError;
  String? motherError;

  @override
  void initState() {
    super.initState();
    fatherController.text = ((widget.parents?.bull ?? widget.parents?.breeder) ?? "").toString();
    motherController.text = (widget.parents?.cow ?? "").toString();
  }

  @override
  Widget build(BuildContext context) {
    final fatherField = TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        label: const Text("Pai"),
        hintText: "Digite o nome do progenitor ou brinco do pai.",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        errorText: fatherError,
      ),
      controller: fatherController,
      onChanged: (value) => _validateFather(value),
    );

    final motherField = TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        label: const Text("Mãe"),
        hintText: "Digite o brinco da mãe.",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        errorText: motherError,
      ),
      controller: motherController,
      onChanged: (value) => _validateMother(value),
    );

    final addButton = Button(
      text: "SALVAR",
      color: Colors.green,
      onPressed: saveParents,
    );

    final column = <Widget>[
      fatherField,
      const Divider(color: Colors.transparent),
      motherField,
      const Divider(color: Colors.transparent),
      addButton,
    ];

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: column,
          ),
        ),
      ),
    );
  }

  Future<void> _validateFather(String value) async {
    if (value.isEmpty) {
      setState(() {
        fatherError = "Por favor, digite o nome do pai.";
      });
      return;
    }

    bool exists = await _checkIfFatherExists(value);

    setState(() {
      fatherError = exists ? null : "O pai não foi encontrado no banco de dados.";
    });
  }

  Future<void> _validateMother(String value) async {
    if (value.isEmpty) {
      setState(() {
        motherError = "Por favor, digite o brinco da mãe.";
      });
      return;
    }

    bool exists = await _checkIfMotherExists(value);

    setState(() {
      motherError = exists ? null : "A mãe não foi encontrada no banco de dados.";
    });
  }

  Future<bool> _checkIfFatherExists(String value) async {
    final bovine = await BovineController.getBovine(int.tryParse(value) ?? 0);
    final breeder = await BreederController.getBreeder(value);

    return bovine == null || breeder == null;
  }

  Future<bool> _checkIfMotherExists(String value) async {
    final bovine = await BovineController.getBovine(int.tryParse(value) ?? 0);

    return bovine != null && bovine.sex == Sex.female && bovine.earring != widget.earring;
  }

  void saveParents() async {
    if (fatherError == null && motherError == null && _formKey.currentState!.validate()) {
      final fatherBovine = await BovineController.getBovine(int.tryParse(fatherController.text) ?? 0);

      if (fatherBovine != null) {
        createParents(int.parse(motherController.text), fatherBovine.earring, null);
      } else {
        final fatherBreeder = await BreederController.getBreeder(fatherController.text);

        if (fatherBreeder != null) {
          createParents(int.parse(motherController.text), null, fatherController.text);
        } else {
          SnackBar snackBar = const SnackBar(
            content: Text("Por favor, defina o pai do animal."),
            backgroundColor: Colors.red,
            showCloseIcon: true
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          return;
        }
      }

      SnackBar snackBar = const SnackBar(
        content: Text("Informações salvas com sucesso."),
        backgroundColor: Colors.green,
        showCloseIcon: true
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      clearForm();

      widget.postSaved();
    }
  }

  Future<int> createParents(int cow, int? bull, String? breeder) {
    final parents = Parents.fromJson({
      'bovine': widget.earring,
      'cow': cow,
      'bull': bull,
      'breeder': breeder
    });

    return ParentsController.saveParents(parents).then(
      (value) => Future.value(value),
      onError: (err) {
        throw err;
      }
    );
  }

  void clearForm() {
    setState(() {
      fatherController.clear();
      motherController.clear();
    });
  }
}
