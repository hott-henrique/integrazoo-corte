import 'dart:developer'; // ignore: unused_import

import 'package:flutter/material.dart';

import 'package:integrazoo/domain/enumerations.dart';

import 'package:integrazoo/backend/database/database.dart';

import 'package:integrazoo/backend/services/bovine_service.dart';

import 'package:integrazoo/ui/components/titled_card.dart';

import 'package:integrazoo/ui/forms/bovine_form.dart';


class BovineInfoCard extends StatefulWidget {
  final int earring;

  const BovineInfoCard({ super.key, required this.earring });

  @override
  State<BovineInfoCard> createState() => _BovineInfoCard();
}

class _BovineInfoCard extends State<BovineInfoCard> {
  Future<Bovine?> get _bovineFuture => BovineService.getBovine(widget.earring);

  @override
  Widget build(BuildContext context) {
    late Bovine bovine;

    return FutureBuilder<Bovine?>(
      future: _bovineFuture,
      builder: (context, AsyncSnapshot<Bovine?> snapshot) {
        late Widget cardContent;

        if (snapshot.connectionState != ConnectionState.done && !snapshot.hasData) {
          cardContent = const Text("Carregando...", style: TextStyle(fontStyle: FontStyle.italic), textAlign: TextAlign.center);
        } else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasData) {
          cardContent = BovineForm(bovine: snapshot.data, postSaved: () => setState(() => ()));
        } else {
          bovine = snapshot.data!;

          final column = [
            buildInfo("Nome:", bovine.name == null ? "--" : bovine.name!),
            buildInfo("Brinco:", '#${bovine.earring}'),
            buildInfo("Sexo:", bovine.sex.toString()),
            buildInfo("${bovine.sex == Sex.female ? "Matriz" : "Reprodutor"}:", bovine.isBreeder ? "Positivo" : "Negativo"),
          ];

          if (bovine.sex == Sex.female) {
            column.addAll([
              buildInfo("Reproduzindo:", bovine.isReproducing ? "Positivo" : "Negativo"),
              buildInfo("Gravidez:", bovine.isPregnant ? "Positivo" : "Negativo")
            ]);
          }

          cardContent = Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: column
            ),
          );
        }

        void onAction(String action) {
          if (action == "Editar") {
            showDialog(
              context: context,
              builder: (context) => Dialog(child: BovineForm(bovine: bovine, shouldPop: true))
            ).then((_) => setState(() => ()));
            return;
          }

          if (action == "Deletar") {
            showDialog(context: context, builder: (context) {
              return AlertDialog(
                title: const Text('Você deseja mesmo deletar esse animal?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      BovineService.deleteBovine(widget.earring);
                      Navigator.of(context).pop(true);
                    },
                    child: const Text("Confirmar")
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text("Cancelar")
                  )
                ]
              );
            }).then((shouldPop) {
              if (shouldPop as bool) {
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              }
            });
            return;
          }
        }

        return TitledCard(
          title: "Animal",
          content: cardContent,
          actions: const [ "Deletar", "Editar" ],
          onAction: onAction
        );
      }
    );
  }

  Widget buildInfo(String label, String info) {
    const textScaler = TextScaler.linear(1.125);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, textScaler: textScaler),
        Text(info, textScaler: textScaler),
      ]
    );
  }
}
