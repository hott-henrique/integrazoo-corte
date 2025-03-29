import 'dart:developer'; // ignore: unused_import

import 'package:flutter/material.dart';
import 'package:integrazoo/styles/app_text_styles.dart';

import 'package:intl/intl.dart';

import 'package:integrazoo/backend.dart';

import 'package:integrazoo/ui/components.dart';


class PregnancyForm extends StatefulWidget {
  final int? earring;
  final Pregnancy? pregnancy;
  final bool shouldPop;

  const PregnancyForm({ super.key, this.earring, this.pregnancy, this.shouldPop = false });

  @override
  State<PregnancyForm> createState() => _PregnancyForm();
}

class _PregnancyForm extends State<PregnancyForm> {
  final _formKey = GlobalKey<FormState>();

  bool diagnostic = true;

  final earringController = EarringController();

  final observationController = TextEditingController();

  DateTime dateDiagnostic = DateTime.now();
  DateTime dateBirthForecast = DateTime.now().add(const Duration(days: 9 * 30));

  late final TextEditingController dateDiagnosticController;
  late final TextEditingController dateBirthForecastController;

  @override
  void initState() {
    super.initState();

    if (widget.earring != null) {
      earringController.setEarring(widget.earring);
    }

    if (widget.pregnancy != null) {
      earringController.setEarring(widget.pregnancy!.cow);
      dateDiagnostic = widget.pregnancy!.date;
      dateBirthForecast = widget.pregnancy!.birthForecast;
      observationController.text = widget.pregnancy!.observation ?? "";
    }

    dateDiagnosticController = TextEditingController(text: DateFormat.yMd("pt_BR").format(dateDiagnostic));
    dateBirthForecastController = TextEditingController(text: DateFormat.yMd("pt_BR").format(dateBirthForecast));
  }

  @override
  Widget build(BuildContext context) {
    final addButton = TextButton(onPressed: savePregnancy, child: const Text("Confirmar"));

    final diagnosticCheckbox = Row(children: [
      Checkbox(
        value: diagnostic,
        onChanged: (value) => setState(() => diagnostic = value!)
      ),
      const Text("Sucesso")
    ]);

    final dateDiagnosticPicker = TextFormField(
      controller: dateDiagnosticController,
      decoration: const InputDecoration(border: OutlineInputBorder(),
                                        label: Text("Data do Diagnóstico"),
                                        floatingLabelBehavior: FloatingLabelBehavior.auto),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: dateDiagnostic,
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
        );
        if (pickedDate != null) {
          setState(() {
            dateDiagnostic = pickedDate;
            dateDiagnosticController.text = DateFormat.yMd("pt_BR").format(pickedDate);
          });
        }
      },
    );

    final dateBirthForecastPicker = TextFormField(
      controller: dateBirthForecastController,
      decoration: const InputDecoration(border: OutlineInputBorder(),
                                        label: Text("Data de Previsão do Parto"),
                                        floatingLabelBehavior: FloatingLabelBehavior.auto),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: dateBirthForecast,
          firstDate: DateTime(2000),
          lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
        );
        if (pickedDate != null) {
          setState(() {
            dateBirthForecast = pickedDate;
            dateBirthForecastController.text = DateFormat.yMd("pt_BR").format(pickedDate);
          });
        }
      },
    );

    final cowSelector = SingleBovineSelector(
      sex: Sex.female,
      wasDiscarded: false,
      isReproducing: true,
      isPregnant: false,
      label: "Vacas",
      earringController: earringController,
    );

    final observationField = TextFormField(
      keyboardType: TextInputType.text,
      controller: observationController,
      decoration: const InputDecoration(hintText: 'Exemplo: Veterinario indicou riscos na prenhez.',
                                        border: OutlineInputBorder(),
                                        label: Text("Observação"),
                                        floatingLabelBehavior: FloatingLabelBehavior.always),
    );

    final header = Text(
      widget.pregnancy == null ? "REGISTRANDO DIAGNÓSTICO" : "EDITANDO PRENHE DO ANIMAL #${widget.pregnancy!.cow}",
      textAlign: TextAlign.center,
      style: AppTextStyles.pageHeading,
    );

    Divider divider = const Divider(color: Colors.transparent);

    final column = <Widget>[
      header,
      if (widget.pregnancy == null && widget.earring == null) ...[
        cowSelector,
        divider
      ],
      diagnosticCheckbox,
      divider,
      dateDiagnosticPicker,
      divider,
      if (diagnostic) ...[
        dateBirthForecastPicker,
        divider,
        observationField,
        divider
      ],
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

  void savePregnancy() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();

      if (earringController.earring == null) {
        SnackBar snackBar = const SnackBar(
          content: Text('Por favor, escolha a vaca.'),
          backgroundColor: Colors.red,
          showCloseIcon: true
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
      }

      transaction(() async {
        if (widget.pregnancy != null) {
          final pregnancy = Pregnancy.fromJson({
            "id": widget.pregnancy?.id ?? 0,
            "cow": earringController.earring!,
            "date": dateDiagnostic,
            "birthForecast": dateBirthForecast,
            "reproduction": widget.pregnancy!.reproduction,
            "observation": observationController.text,
            "hasEnded": !diagnostic
          });

          await PregnancyService.savePregnancy(pregnancy);

          return;
        }

        updateCowStatus(isPregnant: diagnostic);

        final reproduction = await ReproductionService.getActiveReproduction(earringController.earring!);

        if (reproduction == null) {
          throw Exception("Não foi possivel reprodução ativa relacionada a esse animal!");
        }

        final d = diagnostic ? ReproductionDiagonostic.positive : ReproductionDiagonostic.negative;

        final updateReproduction = reproduction.copyWith(diagnostic: d);

        await ReproductionService.saveReproduction(updateReproduction);

        if (diagnostic) {
          final pregnancy = Pregnancy.fromJson({
            "id": widget.pregnancy?.id ?? 0,
            "cow": earringController.earring!,
            "date": dateDiagnostic,
            "birthForecast": dateBirthForecast,
            "reproduction": reproduction.id,
            "observation": observationController.text,
            "hasEnded": !diagnostic
          });

          await PregnancyService.savePregnancy(pregnancy);
        }

        throw Exception("Testing");
      }).then((_) {
        if (!mounted) {
          return;
        }

        SnackBar snackBar = const SnackBar(
          content: Text('Diagnóstico registrado com sucesso.'),
          backgroundColor: Colors.green,
          showCloseIcon: true
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        if (widget.shouldPop) {
          Navigator.of(context).pop();
          return;
        }

        clearForm();
      });
    }
  }

  void updateCowStatus({ required bool isPregnant }) async {
    final cowEarring = earringController.earring!;

    final cow = await BovineService.getBovine(cowEarring);

    if (cow == null) {
      throw Exception("Não foi possível encontrar a seguinte vaca: $cowEarring");
    }

    final cowUpdate = cow.copyWith(isReproducing: false, isPregnant: isPregnant);

    await BovineService.saveBovine(cowUpdate);
  }

  void clearForm() {
    setState(() {
      dateDiagnostic = DateTime.now();
      dateDiagnosticController.text = DateFormat.yMd("pt_BR").format(dateDiagnostic);

      dateBirthForecast = DateTime.now().add(const Duration(days: 9 * 30));
      dateBirthForecastController.text = DateFormat.yMd("pt_BR").format(dateBirthForecast);

      observationController.text = "";

      earringController.clear();
    });
  }
}
