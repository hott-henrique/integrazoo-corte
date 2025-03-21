import 'dart:developer'; // ignore: unused_import

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:integrazoo/backend.dart';

import 'package:integrazoo/ui/components.dart';
import 'package:integrazoo/ui/forms.dart';


class WeaningInfoCard extends StatefulWidget {
  final int earring;

  const WeaningInfoCard({ super.key, required this.earring });

  @override
  State<WeaningInfoCard> createState() => _WeaningInfoCard();
}

class _WeaningInfoCard extends State<WeaningInfoCard> {
  Future<Weaning?> get _weaningFuture => WeaningService.getWeaning(widget.earring);

  @override
  Widget build(BuildContext context) {
    late Weaning weaning;

    return FutureBuilder<Weaning?>(
      future: _weaningFuture,
      builder: (context, AsyncSnapshot<Weaning?> snapshot) {
        late Widget cardContent;

        if (snapshot.connectionState != ConnectionState.done && !snapshot.hasData) {
          cardContent = const Text("Carregando...", style: TextStyle(fontStyle: FontStyle.italic), textAlign: TextAlign.center);
        } else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasData) {
          cardContent = WeaningForm(
            earring: widget.earring,
            weaning: snapshot.data,
            postSaved: () => setState(() => ()),
            shouldShowHeader: false
          );
        } else {
          weaning = snapshot.data!;

          cardContent = Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildInfo("Data", DateFormat.yMd("pt_BR").format(weaning.date)),
                buildInfo("Peso", '${weaning.weight.toString()} Kg'),
              ]
            ),
          );
        }

        void onAction(String action) {
          if (action == "Editar") {
            showDialog(
              context: context,
              builder: (context) => Dialog(child: WeaningForm(weaning: weaning, shouldPop: true))
            ).then((_) => setState(() => ()));
            return;
          }

          if (action == "Deletar") {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                icon: const Icon(Icons.info),
                title: const Text("Deseja mesmo deletar as informações sobre o desame?"),
                actions: [ TextButton(
                  onPressed: () async {
                    await WeaningService.deleteWeaning(weaning.bovine);

                    if (context.mounted) {
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
          title: "Desmame",
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
