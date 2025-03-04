import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:integrazoo/view/components/titled_card.dart';

import 'package:integrazoo/view/forms/finish_form.dart';

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

  @override
  Widget build(BuildContext context) {
    late Finish finish;

    return FutureBuilder<Finish?>(
      future: _finishFuture,
      builder: (context, AsyncSnapshot<Finish?> snapshot) {
        late Widget cardContent;
        if (snapshot.connectionState != ConnectionState.done && !snapshot.hasData) {
          cardContent = const Text("Carregando...", style: TextStyle(fontStyle: FontStyle.italic), textAlign: TextAlign.center);
        } else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasData) {
          cardContent = FinishForm(
            earring: widget.earring,
            shouldPop: false,
            postSaved: () => setState(() => ())
          );
        } else {
          finish = snapshot.data!;

          cardContent = Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildInfo("Data", DateFormat.yMd("pt_BR").format(finish.date)),
                buildInfo("Razão", finish.reason.toString()),
                if (finish.reason == FinishingReason.slaughter) ...[
                  buildInfo("Peso Animal", '${finish.weight.toString()} Kg'),
                  buildInfo("Peso Carcaça Quente", '${finish.hotCarcassWeight.toString()} Kg'),
                ],
                if (finish.observation != null)
                  buildInfo("Observação", finish.observation!),
              ]
            ),
          );
        }

        void onAction(String action) {
          if (action == "Editar") {
            showDialog(
              context: context,
              builder: (context) => Dialog(child: FinishForm(finish: finish, shouldPop: true))
            ).then((_) => setState(() => ()));
            return;
          }

          if (action == "Deletar") {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                icon: const Icon(Icons.info),
                title: const Text("Deseja mesmo deletar a finalização?"),
                actions: [ TextButton(
                  onPressed: () async {
                    await FinishController.delete(finish.bovine);

                    if (mounted && context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text("CONFIRMAR"),
                ) ],
              )
            ).then((_) => setState(() => ()));
            return;
          }
        }

        return TitledCard(
          title: "Finalização",
          content: cardContent,
          actions: [
            if (snapshot.hasData)
              "Deletar",
            if (snapshot.hasData)
              "Editar",
          ],
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
