import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:integrazoo/view/forms/update/pregnancy_info_form.dart';

import 'package:intl/intl.dart';

import 'package:integrazoo/database/database.dart';

import 'package:integrazoo/base.dart';

import 'package:integrazoo/control/pregnancy_controller.dart';
import 'package:integrazoo/control/reproduction_controller.dart';
import 'package:integrazoo/control/treatment_controller.dart';

import 'package:integrazoo/view/components/button.dart';
import 'package:integrazoo/view/components/titled_card.dart';

import 'package:integrazoo/view/forms/create/artificial_insemination_form.dart';
import 'package:integrazoo/view/forms/create/natural_mating_form.dart';
import 'package:integrazoo/view/forms/create/treatment_form.dart';


class HerdRelatory extends StatefulWidget {

  final VoidCallback? postBackButtonClick;

  const HerdRelatory({ super.key, this.postBackButtonClick });

  @override
  State<HerdRelatory> createState() => _HerdRelatory();
}

class _HerdRelatory extends State<HerdRelatory> {
  Exception? exception;

  Future<List<(Bovine, Treatment)>> get _treatmentsFuture => TreatmentController.getBovinesInTreatment(5, 0);
  Future<List<(Bovine, Reproduction)>> get _reproductionsFuture => ReproductionController.getBovinesReproducing(5, 0);
  Future<List<(Bovine, Pregnancy)>> get _pregnanciesFuture => PregnancyController.getBovinesPregnant(5, 0);

  bool isAscending = true;
  int previousSortColumnIndex = 0;
  int sortColumnIndex = 1;

  @override
  Widget build(BuildContext context) {
    return IntegrazooBaseApp(
      title: "Resumo Rebanho",
      postBackButtonClick: widget.postBackButtonClick,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          buildTreatments(),
          buildReproductions(),
          buildPregnancies()
        ])
      )
    );
  }

  Widget buildTreatments() {
    final formatter = DateFormat('dd/MM/yyyy');

    Widget content = FutureBuilder<List<(Bovine, Treatment)>>(
      future: _treatmentsFuture,
      builder: (context, AsyncSnapshot<List<(Bovine, Treatment)>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        final bovinesInTreatment = (snapshot.data! as List<dynamic>).cast<(Bovine, Treatment)>();

        if (bovinesInTreatment.isEmpty) {
          return const Center(child: Text("Nenhum animal em tratamento no momento."));
        }

        return Column(children: bovinesInTreatment.map((e) {
          final bovine = e.$1;
          final treatment = e.$2;

          return Padding(padding: const EdgeInsets.only(bottom: 8), child: ListTile(
            title: Text('${bovine.name ?? ""} #${bovine.earring}'),
            subtitle: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Text('${treatment.medicine}: ${treatment.reason}'),
              Text('Iníco: ${formatter.format(treatment.startingDate)} - Fim: ${formatter.format(treatment.endingDate)}')
            ]),
            tileColor: const Color.fromRGBO(216, 216, 216, 1),
            trailing: PopupMenuButton<String>(
              onSelected: (action) {
                switch (action) {
                  case "Editar":
                    Navigator.of(context)
                             .push(MaterialPageRoute(builder: (context) => TreatmentForm(treatment: treatment, shouldPop: true)))
                             .then((value) => setState(() => ()));
                    return;
                  case "Deletar":
                    showDialog(context: context, builder: (context) {
                      return AlertDialog(
                        icon: const Icon(Icons.info),
                        iconColor: Colors.black,
                        title: const Text("Deseja mesmo deletar o tratamento?"),
                        actions: [
                          Center(child: Button(
                            text: "Confirmar",
                            color: Colors.green,
                            onPressed: () {
                              TreatmentController.delete(e.$2.id).then((_) => setState(() => Navigator.of(context).pop()));
                            }
                          )),
                        ],
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2.0)))
                      );
                    });
                    return;
                }
              },
              itemBuilder: (BuildContext context) => [ "Editar", "Deletar" ].map((action) =>
                PopupMenuItem<String>(
                  value: action,
                  child: Text(action),
                ),
              ).toList()
            )
          ));
        }).toList());
      }
    );

    return TitledCard(
      title: "Animais em Tratamento",
      content: Padding(padding: const EdgeInsets.all(12.0), child: content)
    );
  }

  Widget buildReproductions() {
    final formatter = DateFormat('dd/MM/yyyy');

    Widget content = FutureBuilder<List<(Bovine, Reproduction)>>(
      future: _reproductionsFuture,
      builder: (context, AsyncSnapshot<List<(Bovine, Reproduction)>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        final bovinesReproducing = (snapshot.data! as List<dynamic>).cast<(Bovine, Reproduction)>();

        if (bovinesReproducing.isEmpty) {
          return const Center(child: Text("Nenhuma fêmea reproduzindo no momento."));
        }

        return Column(children: bovinesReproducing.map((e) {
          final bovine = e.$1;
          final reproduction = e.$2;

          return Padding(padding: const EdgeInsets.only(bottom: 8), child: ListTile(
            title: Text('${bovine.name ?? ""} #${bovine.earring}'),
            subtitle: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Text('Tipo: ${reproduction.kind.toString()}'),
              Text('Pai: ${reproduction.bull != null  ? "#${reproduction.bull}" : reproduction.breeder}'),
              Text('Data: ${formatter.format(reproduction.date)}'),
              if (reproduction.kind == ReproductionKind.artificialInsemination)
                Text('Pipeta: ${reproduction.strawNumber}'),
            ]),
            tileColor: const Color.fromRGBO(216, 216, 216, 1),
            trailing: PopupMenuButton<String>(
              onSelected: (action) {
                switch (action) {
                  case "Editar":
                    final page = reproduction.kind == ReproductionKind.coverage ?
                                 NaturalMatingForm(reproduction: reproduction, shouldPop: true) :
                                 ArtificialInseminationForm(reproduction: reproduction, shouldPop: true);

                    Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) => page))
                              .then((value) => setState(() => ()));
                    return;
                  case "Deletar":
                    showDialog(context: context, builder: (context) {
                      return AlertDialog(
                        icon: const Icon(Icons.info),
                        iconColor: Colors.black,
                        title: const Text("Deseja mesmo deletar a reprodução?"),
                        actions: [
                          Center(child: Button(
                            text: "Confirmar",
                            color: Colors.green,
                            onPressed: () {
                              ReproductionController.delete(e.$2.id).then((_) => setState(() => Navigator.of(context).pop()));
                            }
                          )),
                        ],
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2.0)))
                      );
                    });
                    return;
                }
              },
              itemBuilder: (BuildContext context) => [ "Editar", "Deletar" ].map((action) =>
                PopupMenuItem<String>(
                  value: action,
                  child: Text(action),
                ),
              ).toList()
            )
          ));
        }).toList());
      }
    );

    return TitledCard(
      title: "Animais em Reprodução",
      content: Padding(padding: const EdgeInsets.all(12.0), child: content)
    );
  }

  Widget buildPregnancies() {
    final formatter = DateFormat('dd/MM/yyyy');

    Widget content = FutureBuilder<List<(Bovine, Pregnancy)>>(
      future: _pregnanciesFuture,
      builder: (context, AsyncSnapshot<List<(Bovine, Pregnancy)>> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const CircularProgressIndicator();
        }

        inspect(snapshot.data);

        final bovinesReproducing = snapshot.data!;

        if (bovinesReproducing.isEmpty) {
          return const Center(child: Text("Nenhuma fêmea gravida no momento."));
        }

        return Column(children: bovinesReproducing.map((e) {
          final bovine = e.$1;
          final pregnancy = e.$2;

          return Padding(padding: const EdgeInsets.only(bottom: 8), child: ListTile(
            title: Text('${bovine.name ?? ""} #${bovine.earring}'),
            subtitle: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Text('Data Diagnóstico: ${formatter.format(pregnancy.date)}'),
              Text('Previsão Parto: ${formatter.format(pregnancy.birthForecast)}')
            ]),
            tileColor: const Color.fromRGBO(216, 216, 216, 1),
            trailing: PopupMenuButton<String>(
              onSelected: (action) {
                switch (action) {
                  case "Editar":
                    Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) => PregnancyInfoForm(pregnancy: pregnancy)))
                              .then((value) => setState(() => ()));
                    return;
                  case "Deletar":
                    showDialog(context: context, builder: (context) {
                      return AlertDialog(
                        icon: const Icon(Icons.info),
                        iconColor: Colors.black,
                        title: const Text("Deseja mesmo deletar o diagnóstico de gravidez?"),
                        actions: [
                          Center(child: Button(
                            text: "Confirmar",
                            color: Colors.green,
                            onPressed: () {
                              PregnancyController.delete(pregnancy.id).then((_) => setState(() => Navigator.of(context).pop()));
                              Navigator.of(context).pop();
                            }
                          )),
                        ],
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2.0)))
                      );
                    });
                    return;
                }
              },
              itemBuilder: (BuildContext context) => [ "Editar", "Deletar" ].map((action) =>
                PopupMenuItem<String>(
                  value: action,
                  child: Text(action),
                ),
              ).toList()
            )
          ));
        }).toList());
      }
    );

    return TitledCard(
      title: "Fêmeas Grávidas",
      content: Padding(padding: const EdgeInsets.all(12.0), child: content)
    );
  }
}
