import 'dart:developer'; // ignore: unused_import

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:integrazoo/backend/database/database.dart';

import 'package:integrazoo/backend/services/bovine_service.dart';
import 'package:integrazoo/backend/services/weaning_service.dart';

import 'package:integrazoo/ui/components/bovine/single_bovine_selector.dart';
import 'package:integrazoo/ui/components/bovine/earring_controller.dart';


class WeaningForm extends StatefulWidget {
  final int? earring;
  final Weaning? weaning;
  final bool shouldPop;
  final VoidCallback? postSaved;
  final bool shouldShowHeader;

  const WeaningForm({ super.key, this.earring, this.weaning, this.shouldPop = false, this.postSaved, this.shouldShowHeader = true });

  @override
  State<WeaningForm> createState() => _WeaningForm();
}

class _WeaningForm extends State<WeaningForm> {
  final _formKey = GlobalKey<FormState>();

  final earringController = EarringController();
  final weightService = TextEditingController();

  DateTime date= DateTime.now();
  late final TextEditingController dateController;

  @override
  void initState() {
    super.initState();

    earringController.setEarring(widget.earring);

    if (widget.weaning != null) {
      earringController.setEarring(widget.weaning!.bovine);
      weightService.text = widget.weaning!.weight.toString();
      date = widget.weaning!.date;
    }

    dateController = TextEditingController(text: DateFormat.yMd("pt_BR").format(date));
  }

  @override
  Widget build(BuildContext context) {
    final addButton = TextButton(onPressed: saveWeaning, child: const Text("SALVAR"));

    final datePicker = InputDatePickerFormField(
      initialDate: date,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
      keyboardType: TextInputType.text,
      fieldLabelText: "Data do Desmame",
      onDateSubmitted: (value) => date = value,
      onDateSaved: (value) => date = value,
    );

    final cowSelector = SingleBovineSelector(
      hasBeenWeaned: false,
      label: "Animais",
      earringController: earringController,
    );

    final weightField = TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        label: Text("Peso"),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: "Digite o peso do animal"
      ),
      controller: weightService,
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

    Divider divider = const Divider(color: Colors.transparent);

    final header = Text(
      widget.earring == null && widget.weaning == null ?
      "REGISTRANDO DESMAME" :
      (widget.earring != null ?
       "REGISTRANDO DESMAME DO ANIMAL #${widget.earring!}" :
       "EDITANDO DESMAME DO ANIMAL #${widget.weaning!.bovine}"),
      textAlign: TextAlign.center,
      textScaler: const TextScaler.linear(1.5)
    );

    final column = <Widget>[
      if (widget.shouldShowHeader) header,
      if (widget.weaning == null && widget.earring == null) ...[
        cowSelector,
        divider,
      ],
      datePicker,
      divider,
      weightField,
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

  void saveWeaning() {
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

    final earring = earringController.earring!;

    final weaning = Weaning.fromJson({
      'bovine': earring,
      'date': date,
      'weight': double.parse(weightService.text)
    });

    updateStatus();

    WeaningService.saveWeaning(weaning).then(
      (_) {
        SnackBar snackBar = const SnackBar(
          content: Text("Desmame registrado com sucesso"),
          backgroundColor: Colors.green,
          showCloseIcon: true
        );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

          clear();

          if (widget.shouldPop) {
            Navigator.of(context).pop();
          }
        }

        widget.postSaved?.call();
      }
    );
  }

  void updateStatus() {
    final earring = earringController.earring!;

    BovineService.getBovine(earring).then(
      (cow) {
        if (cow == null) {
          // TODO: RAISE ERROR.
          return;
        }

        final cowUpdate = cow.copyWith(hasBeenWeaned: true);

        BovineService.saveBovine(cowUpdate);
      }
    );
  }

  String? validateAllFields() {
    if (earringController.earring == null) {
      return "Por favor, selecione o animal.";
    }

    if (weightService.text.isEmpty) {
      return "Por favor, digite o peso do animal.";
    }

    return null;
  }

  void clear() {
    setState(() {
      earringController.clear();
      weightService.clear();
      date = DateTime.now();
      dateController.text = DateFormat.yMd("pt_BR").format(date);
    });
  }
}
