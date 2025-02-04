import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:integrazoo/view/components/titled_card.dart';

import 'package:integrazoo/view/forms/update/bovine_info_form.dart';

import 'package:integrazoo/control/bovine_controller.dart';

import 'package:integrazoo/database/database.dart';


class BovineInfoCard extends StatefulWidget {
  final int earring;

  const BovineInfoCard({ super.key, required this.earring });

  @override
  State<BovineInfoCard> createState() => _BovineInfoCard();
}

class _BovineInfoCard extends State<BovineInfoCard> {

  Future<Bovine?> get _bovineFuture => BovineController.getBovine(widget.earring);

  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Bovine?>(
      future: _bovineFuture,
      builder: (context, AsyncSnapshot<Bovine?> snapshot) {
        late Widget cardContent;

        if (snapshot.connectionState != ConnectionState.done && !snapshot.hasData) {
          cardContent = const Text("Carregando...", style: TextStyle(fontStyle: FontStyle.italic), textAlign: TextAlign.center);
        } else if (snapshot.connectionState == ConnectionState.done && (!snapshot.hasData || isEditing)) {
          cardContent = BovineInfoForm(
            earring: widget.earring,
            bovine: snapshot.data,
            postSaved: () => setState(() => isEditing = false)
          );
        } else {
          final bovine = snapshot.data!;

          final column = [
            buildInfo("Nome:", bovine.name == null ? "--" : bovine.name!),
            buildInfo("Brinco:", '#${bovine.earring}'),
            buildInfo("Sexo:", bovine.sex.toString()),
            buildInfo("Peso ao Sobreano:", (bovine.weight540 ?? "--").toString()),
          ];

          if (bovine.sex == Sex.female) {
            column.addAll([
              buildInfo("Reproduzindo:", bovine.isReproducing ? "Positivo" : "Negativo"),
              buildInfo("Grávidez:", bovine.isPregnant ? "Positivo" : "Negativo"),
              buildInfo("Matriz:", bovine.isBreeder ? "Positivo" : "Negativo")
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

        return TitledCard(
          title: "Animal",
          content: cardContent,
          actions: [
            if (!isEditing)
              "Editar",
            if (isEditing)
              "Cancelar"
          ],
          onAction: onAction
        );
      }
    );
  }

  void onAction(String action) {
    if (action == "Cancelar") {
      setState(() => isEditing = false);
      return;
    }

    if (action == "Deletar") {
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: const Text('Você deseja mesmo deletar esse animal?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                BovineController.deleteBovine(widget.earring);
                Navigator.of(context).popUntil((page) => page.isFirst);
              },
              child: const Text("Confirmar")
            ),
            TextButton(onPressed: Navigator.of(context).pop, child: const Text("Cancelar"))
          ]
        );
      }).then((_) => setState(() => Navigator.of(context).pop()));
      return;
    }

    if (action == "Editar") {
      setState(() => isEditing = true);
      return;
    }
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
