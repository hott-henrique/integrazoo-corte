import 'dart:developer'; // ignore: unused_import

import 'package:flutter/material.dart';
import 'package:integrazoo/styles/app_text_styles.dart';

import 'package:intl/intl.dart';

import 'package:integrazoo/backend.dart';

import 'package:integrazoo/ui/components.dart';


class FinishForm extends StatefulWidget {
  final int? earring;
  final Finish? finish;

  final bool shouldPop;
  final bool shouldShowHeader;
  final VoidCallback? postSaved;

  const FinishForm({ super.key, this.earring, this.finish, this.shouldPop = false, this.postSaved, this.shouldShowHeader = true });

  @override
  State<FinishForm> createState() => _FinishForm();
}

class _FinishForm extends State<FinishForm> {
  final _formKey = GlobalKey<FormState>();

  final earringController = EarringController();

  FinishingReason? reason;

  final reasonController = TextEditingController();
  final weightController = TextEditingController();
  final hotCarcassWeightController = TextEditingController();

  final observationController = TextEditingController();

  late final TextEditingController dateController;
  DateTime date = DateTime.now();

  @override
  void initState() {
    super.initState();

    earringController.setEarring(widget.earring);

    if (widget.finish != null) {
      date = widget.finish!.date;
      reason = widget.finish!.reason;
      reasonController.text = widget.finish!.reason.toString();
      weightController.text = widget.finish!.weight?.toString() ?? "";
      hotCarcassWeightController.text = widget.finish!.hotCarcassWeight?.toString() ?? "";
      observationController.text = widget.finish!.observation ?? "";

      earringController.setEarring(widget.finish!.bovine);
    }

    dateController = TextEditingController(text: DateFormat.yMd("pt_BR").format(date));
  }

  @override
  Widget build(BuildContext context) {
    final bovineSelector = SingleBovineSelector(earringController: earringController, wasFinished: false);

    final reasonDropdown = DropdownMenu<FinishingReason>(
      initialSelection: reason,
      dropdownMenuEntries: FinishingReason.values.map((r) => DropdownMenuEntry(value: r, label: r.toString())).toList(),
      onSelected: (value) => setState(() => reason = value!),
      label: const Text('Motivação'),
      expandedInsets: EdgeInsets.zero,
      controller:  reasonController
    );

    final weightField = TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(border: OutlineInputBorder(),
                                        label: Text("Peso - Kilogramas"),
                                        floatingLabelBehavior: FloatingLabelBehavior.auto),
      controller: weightController,
      validator: (String? value) {
        if (reason == FinishingReason.slaughter) {
          if (weightController.text.isEmpty) {
            return 'Por favor, digite o peso vivo do animal ao abate.';
          }
        }

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
        if (reason == FinishingReason.slaughter) {
          if (hotCarcassWeightController.text.isEmpty) {
            return 'Por favor, digite o peso da carcaça quente do animal.';
          }
        }

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
            dateController.text = DateFormat.yMd("pt_BR").format(pickedDate);
          });
        }
      },
    );

    final header = Text(
      widget.earring == null && widget.finish == null ?
      "REGISTRANDO FINALIZAÇÃO" :
      (widget.earring != null ?
       "REGISTRANDO FINALIZAÇÃO DO ANIMAL #${widget.earring!}" :
       "EDITANDO FINALIZAÇÃO DO ANIMAL #${widget.finish!.bovine}"),
      textAlign: TextAlign.center,
      style: AppTextStyles.pageHeading,
    );

    final addButton = TextButton(onPressed: discardBovine, child: const Text("SALVAR"));

    Divider divider = const Divider(color: Colors.transparent);

    final column = <Widget>[
      if (widget.shouldShowHeader) header,
      if (widget.finish == null && widget.earring == null) ...[
        bovineSelector,
        divider,
      ],
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

    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: column)
      )
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

      final finish = Finish.fromJson({
        'bovine': earring,
        'date': date,
        'reason': reason!.index,
        'observation': observationController.text.isEmpty ? null : observationController.text,
        'weight': reason == FinishingReason.slaughter ? double.parse(weightController.text) : null,
        'hotCarcassWeight': reason == FinishingReason.slaughter ? double.parse(hotCarcassWeightController.text) : null
      });

      FinishService.save(earring, finish).then(
        (_) {
          if (mounted) {
            SnackBar snackBar = const SnackBar(
              content: Text('Finalização salva com sucesso.'),
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
      );
    }
  }

  void updateBovineStatus() {
    BovineService.getBovine(earringController.earring!).then(
      (bovine) {
        if (bovine == null) {
          // TODO: RAISE ERROR.
          return;
        }

        final bovineUpdate = bovine.copyWith(wasFinished: true);

        BovineService.saveBovine(bovineUpdate);
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
      reasonController.clear();
      reason = null;
      date = DateTime.now();
      dateController.text = DateFormat.yMd("pt_BR").format(date);
    });
  }
}
