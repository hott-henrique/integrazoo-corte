import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:integrazoo/globals.dart';

import 'package:intl/intl.dart';

import 'package:integrazoo/base.dart';

import 'package:integrazoo/view/components/button.dart';
import 'package:integrazoo/view/components/unexpected_error_alert_dialog.dart';

import 'package:integrazoo/view/components/bovine/single_bovine_selector.dart';
import 'package:integrazoo/view/components/bovine/earring_controller.dart';

import 'package:integrazoo/control/bovine_controller.dart';
import 'package:integrazoo/control/reproduction_controller.dart';
import 'package:integrazoo/control/pregnancy_controller.dart';

import 'package:integrazoo/database/database.dart';


class PregnancyForm extends StatefulWidget {
  const PregnancyForm({ super.key });

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

  final DateFormat formatter = DateFormat('dd/MM/yyyy');

  Exception? exception;

  @override
  void initState() {
    super.initState();
    dateDiagnosticController = TextEditingController(text: formatter.format(dateDiagnostic));
    dateBirthForecastController = TextEditingController(text: formatter.format(dateBirthForecast));
  }

  @override
  Widget build(BuildContext context) {
    if (exception != null) {
      return UnexpectedErrorAlertDialog(title: 'Erro Inesperado',
                                        message: 'Algo de inespearado aconteceu durante a execução do aplicativo.',
                                        onPressed: () => setState(() => exception = null));
    }

    final addButton = Button(text: "Confirmar", color: Colors.green, onPressed: savePregnancy);

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
            dateDiagnosticController.text = formatter.format(pickedDate);
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
            dateBirthForecastController.text = formatter.format(pickedDate);
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

    Divider divider = const Divider(color: Colors.transparent);

    final column = <Widget>[
      cowSelector,
      divider,
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

    return IntegrazooBaseApp(
      title: "REGISTRAR PRENHEZ",
      body: SingleChildScrollView(child:
        Form(
          autovalidateMode: AutovalidateMode.always,
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: column)
          )
        )
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

      database.transaction(() async {
        updateCowStatus(isPregnant: diagnostic);
        final reproduction = await ReproductionController.getActiveReproduction(earringController.earring!);

        if (reproduction != null) {
          final d = diagnostic ? ReproductionDiagonostic.positive : ReproductionDiagonostic.negative;

          final updateReproduction = reproduction.copyWith(diagnostic: d);

          await ReproductionController.saveReproduction(updateReproduction);
        }

        if (diagnostic) {
          final pregnancy = Pregnancy.fromJson({
            "id": 0,
            "cow": earringController.earring!,
            "date": dateDiagnostic,
            "birthForecast": dateBirthForecast,
            "reproduction": reproduction?.id,
            "observation": observationController.text,
            "hasEnded": false
          });

          await PregnancyController.savePregnancy(pregnancy);
        }
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

        clearForm();
      });
    }
  }

  void updateCowStatus({ required bool isPregnant }) async {
    final cowEarring = earringController.earring!;

    final cow = await BovineController.getBovine(cowEarring);

    if (cow == null) {
      throw Exception("Não foi possível encontrar a seguinte vaca: $cowEarring");
    }

    final cowUpdate = cow.copyWith(isReproducing: false, isPregnant: isPregnant);

    await BovineController.saveBovine(cowUpdate);
  }

  void clearForm() {
    setState(() {
      dateDiagnostic = DateTime.now();
      dateDiagnosticController.text = formatter.format(dateDiagnostic);

      dateBirthForecast = DateTime.now().add(const Duration(days: 9 * 30));
      dateBirthForecastController.text = formatter.format(dateBirthForecast);

      observationController.text = "";

      earringController.clear();
    });
  }
}
