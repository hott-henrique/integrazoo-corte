import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:integrazoo/view/components/button.dart';
import 'package:integrazoo/view/components/titled_card.dart';

import 'package:integrazoo/view/forms/update/discard_info_form.dart';

import 'package:integrazoo/control/bovine_controller.dart';

import 'package:integrazoo/database/database.dart';


class DiscardInfoCard extends StatefulWidget {
  final int earring;

  const DiscardInfoCard({ super.key, required this.earring });

  @override
  State<DiscardInfoCard> createState() => _DiscardInfoCard();
}

class _DiscardInfoCard extends State<DiscardInfoCard> {
  Exception? exception;

  Future<Discard?> get _discardFuture => BovineController.getDiscard(widget.earring);

  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Discard?>(
      future: _discardFuture,
      builder: (context, AsyncSnapshot<Discard?> snapshot) {
        late Widget cardContent;
        if (snapshot.connectionState != ConnectionState.done && !snapshot.hasData) {
          cardContent = const Text("Carregando...", style: TextStyle(fontStyle: FontStyle.italic), textAlign: TextAlign.center);
        } else if (snapshot.connectionState == ConnectionState.done && (!snapshot.hasData || isEditing)) {
          cardContent = DiscardInfoForm(
            earring: widget.earring,
            discard: snapshot.data,
            postSaved: () => setState(() => isEditing = false)
          );
        } else {
          final discard = snapshot.data!;
          final DateFormat formatter = DateFormat('dd/MM/yyyy');

          cardContent = Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildInfo("Data", formatter.format(discard.date)),
                buildInfo("Razão", discard.reason.toString()),
                buildInfo("Peso", '${discard.weight.toString()} Kg'),
                buildInfo("Observação", discard.observation ?? "--"),
              ]
            ),
          );
        }

        return TitledCard(
          title: "Descarte",
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
            Button(color: Colors.red, text: "Confirmar", onPressed: () {
              BovineController.cancelDiscard(widget.earring);
              Navigator.of(context).pop();
            }),
            Button(color: Colors.blue, text: "Cancelar", onPressed: () => Navigator.of(context).pop())
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
