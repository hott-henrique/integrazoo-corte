import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:integrazoo/view/components/titled_card.dart';

import 'package:integrazoo/view/forms/update/parents_info_form.dart';

import 'package:integrazoo/control/parents_controller.dart';

import 'package:integrazoo/database/database.dart';


class ParentsInfoCard extends StatefulWidget {
  final int earring;

  const ParentsInfoCard({ super.key, required this.earring });

  @override
  State<ParentsInfoCard> createState() => _ParentsInfoCard();
}

class _ParentsInfoCard extends State<ParentsInfoCard> {

  Future<Parents?> get _parentsFuture => ParentsController.getParents(widget.earring);

  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Parents?>(
      future: _parentsFuture,
      builder: (context, AsyncSnapshot<Parents?> snapshot) {
        late Widget cardContent;
        if (snapshot.connectionState != ConnectionState.done && !snapshot.hasData) {
          cardContent = const Text("Carregando...", style: TextStyle(fontStyle: FontStyle.italic), textAlign: TextAlign.center);
        } else if (snapshot.connectionState == ConnectionState.done && (!snapshot.hasData || isEditing)) {
          cardContent = ParentsInfoForm(
            earring: widget.earring,
            parents: snapshot.data,
            postSaved: () => setState(() => isEditing = false)
          );
        } else {
          final parents = snapshot.data!;

          cardContent = Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildInfo("Pai:", parents.breeder ?? '#${parents.bull ?? "DESCONHECIDO"}'),
                buildInfo("Mãe:", '#${parents.cow}'),
              ]
            ),
          );
        }

        return TitledCard(
          title: "Progenitores",
          content: cardContent,
          actions: [
            if (snapshot.hasData && !isEditing)
              "Deletar",
            if (snapshot.hasData && !isEditing)
              "Editar",
            if (snapshot.hasData && isEditing)
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
          title: const Text('Você deseja mesmo deletar as informações de descarte desse animal?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                ParentsController.deleteParents(widget.earring);
                Navigator.of(context).pop();
              },
              child: const Text("Confirmar")
            ),
            TextButton(onPressed: Navigator.of(context).pop, child: const Text("Cancelar"))
          ]
        );
      }).then((_) => setState(() => ()));
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
