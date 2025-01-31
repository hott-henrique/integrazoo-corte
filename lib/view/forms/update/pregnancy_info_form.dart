import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:integrazoo/globals.dart';

import 'package:intl/intl.dart';

import 'package:integrazoo/base.dart';

import 'package:integrazoo/view/components/button.dart';
import 'package:integrazoo/view/components/unexpected_error_alert_dialog.dart';

import 'package:integrazoo/control/pregnancy_controller.dart';

import 'package:integrazoo/database/database.dart';


class PregnancyInfoForm extends StatefulWidget {
  final Pregnancy pregnancy;

  const PregnancyInfoForm({ super.key, required this.pregnancy });

  @override
  State<PregnancyInfoForm> createState() => _PregnancyInfoForm();
}

class _PregnancyInfoForm extends State<PregnancyInfoForm> {
  final _formKey = GlobalKey<FormState>();

  final observationController = TextEditingController();

  late DateTime dateDiagnostic;
  late DateTime dateBirthForecast;

  late final TextEditingController dateDiagnosticController;
  late final TextEditingController dateBirthForecastController;

  final DateFormat formatter = DateFormat('dd/MM/yyyy');

  Exception? exception;

  @override
  void initState() {
    super.initState();

    observationController.text = widget.pregnancy.observation ?? "";

    dateDiagnostic = widget.pregnancy.date;
    dateBirthForecast = widget.pregnancy.birthForecast;

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

    final addButton = Button(text: "Salvar", color: Colors.green, onPressed: savePregnancy);

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
      dateDiagnosticPicker,
      divider,
      dateBirthForecastPicker,
      divider,
      observationField,
      divider,
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

      database.transaction(() async {
        final pregnancy = Pregnancy.fromJson({
          "id": widget.pregnancy.id,
          "cow": widget.pregnancy.cow,
          "date": dateDiagnostic,
          "birthForecast": dateBirthForecast,
          "reproduction": widget.pregnancy.reproduction,
          "observation": observationController.text,
          "hasEnded": widget.pregnancy.hasEnded
        });

        await PregnancyController.savePregnancy(pregnancy);
      }).then((_) {
        if (!mounted) {
          return;
        }

        SnackBar snackBar = const SnackBar(
          content: Text('Gravidez atualizado com sucesso.'),
          backgroundColor: Colors.green,
          showCloseIcon: true
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        Navigator.of(context).pop();
      });
    }
  }
}
