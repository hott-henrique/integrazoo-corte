import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:integrazoo/view/components/titled_card.dart';

import 'package:integrazoo/view/forms/update/finish_info_form.dart';

import 'package:integrazoo/control/finish_controller.dart';

import 'package:integrazoo/database/database.dart';


class FinishInfoCard extends StatefulWidget {
  final int earring;

  const FinishInfoCard({ super.key, required this.earring });

  @override
  State<FinishInfoCard> createState() => _FinishInfoCard();
}

class _FinishInfoCard extends State<FinishInfoCard> {

  Future<Finish?> get _finishFuture => FinishController.getByEarring(widget.earring);

  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Finish?>(
      future: _finishFuture,
      builder: (context, AsyncSnapshot<Finish?> snapshot) {
        late Widget cardContent;
        if (snapshot.connectionState != ConnectionState.done && !snapshot.hasData) {
          cardContent = const Text("Carregando...", style: TextStyle(fontStyle: FontStyle.italic), textAlign: TextAlign.center);
        } else if (snapshot.connectionState == ConnectionState.done && (!snapshot.hasData || isEditing)) {
          cardContent = FinishInfoForm(
            earring: widget.earring,
            finish: snapshot.data,
            postSaved: () => setState(() => isEditing = false)
          );
        } else {
          final finish = snapshot.data!;

          cardContent = Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildInfo("Data", DateFormat.yMd("pt_BR").format(finish.date)),
                buildInfo("Razão", finish.reason.toString()),
                if (finish.reason == FinishingReason.slaughter) ...[
                  buildInfo("Peso", '${finish.weight.toString()} Kg'),
                  buildInfo("Peso Carcaça Quente", '${finish.hotCarcassWeight.toString()} Kg'),
                  buildInfo("Observação", finish.observation ?? "--"),
                ]
              ]
            ),
          );
        }

        return TitledCard(
          title: "Finalização",
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
          title: const Text('Você deseja mesmo deletar as informações de finalização desse animal?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                FinishController.delete(widget.earring);
                Navigator.of(context).pop();
              },
              child: const Text("Confirmar")
            ),
            TextButton(onPressed: Navigator.of(context).pop, child: const Text("CANCELAR"))
          ],
          actionsAlignment: MainAxisAlignment.center
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
