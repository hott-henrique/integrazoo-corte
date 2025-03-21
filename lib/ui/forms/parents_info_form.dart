import 'dart:developer'; // ignore: unused_import

import 'package:flutter/material.dart';

import 'package:integrazoo/domain/enumerations.dart';

import 'package:integrazoo/backend/database/database.dart';

import 'package:integrazoo/backend/services/bovine_service.dart';
import 'package:integrazoo/backend/services/breeder_service.dart';
import 'package:integrazoo/backend/services/parents_service.dart';



class ParentsInfoForm extends StatefulWidget {
  final int? earring;
  final Parents? parents;
  final bool shouldPop;
  final bool shouldShowHeader;
  final VoidCallback? postSaved;

  const ParentsInfoForm({
    super.key,
    this.earring,
    this.parents,
    this.shouldPop = false,
    this.shouldShowHeader = true,
    this.postSaved
  });

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

    final header = Text(
      widget.earring != null ?
      "REGISTRANDO PROGENITORES DO ANIMAL #${widget.earring!}" :
      "EDITANDO PROGENITORES DO ANIMAL #${widget.parents!.bovine}",
      textAlign: TextAlign.center,
      textScaler: const TextScaler.linear(1.5)
    );

    final addButton = TextButton(
      onPressed: saveParents,
      child: const Text("SALVAR"),
    );

    final column = <Widget>[
      if (widget.shouldShowHeader) header,
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

    if ((int.tryParse(value) ?? 0) == widget.earring) {
      setState(() {
        fatherError = "Não é possível registrar o mesmo animal como pai.";
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

    if ((int.tryParse(value) ?? 0) == widget.earring) {
      setState(() {
        motherError = "Não é possível registrar o mesmo animal como mãe.";
      });
      return;
    }

    bool exists = await _checkIfMotherExists(value);

    setState(() {
      motherError = exists ? null : "A mãe não foi encontrada no banco de dados.";
    });
  }

  Future<bool> _checkIfFatherExists(String value) async {
    final bovine = await BovineService.getBovine(int.tryParse(value) ?? 0);
    final breeder = await BreederService.getBreeder(value);

    return bovine == null || breeder == null;
  }

  Future<bool> _checkIfMotherExists(String value) async {
    final bovine = await BovineService.getBovine(int.tryParse(value) ?? 0);

    return bovine != null && bovine.sex == Sex.female && bovine.earring != widget.earring;
  }

  void saveParents() async {
    if (fatherError == null && motherError == null && _formKey.currentState!.validate()) {
      final fatherBovine = await BovineService.getBovine(int.tryParse(fatherController.text) ?? 0);

      if (fatherBovine != null) {
        createParents(int.parse(motherController.text), fatherBovine.earring, null);
      } else {
        final fatherBreeder = await BreederService.getBreeder(fatherController.text);

        if (fatherBreeder != null) {
          createParents(int.parse(motherController.text), null, fatherController.text);
        } else {
          if (mounted) {
            SnackBar snackBar = const SnackBar(
              content: Text("Por favor, defina o pai do animal."),
              backgroundColor: Colors.red,
              showCloseIcon: true
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          return;
        }
      }

      if (mounted) {
        SnackBar snackBar = const SnackBar(
          content: Text("Informações salvas com sucesso."),
          backgroundColor: Colors.green,
          showCloseIcon: true
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        clearForm();

        if (widget.shouldPop) {
          Navigator.of(context).pop();
        }

        widget.postSaved?.call();
      }
    }
  }

  Future<int> createParents(int cow, int? bull, String? breeder) {
    final parents = Parents.fromJson({
      'bovine': widget.earring,
      'cow': cow,
      'bull': bull,
      'breeder': breeder
    });

    return ParentsService.saveParents(parents).then(
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
