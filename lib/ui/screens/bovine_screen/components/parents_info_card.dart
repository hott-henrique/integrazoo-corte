import 'dart:developer'; // ignore: unused_import

import 'package:flutter/material.dart';

import 'package:integrazoo/backend.dart';

import 'package:integrazoo/ui/components.dart';
import 'package:integrazoo/ui/forms.dart';


class ParentsInfoCard extends StatefulWidget {
  final int earring;

  const ParentsInfoCard({ super.key, required this.earring });

  @override
  State<ParentsInfoCard> createState() => _ParentsInfoCard();
}

class _ParentsInfoCard extends State<ParentsInfoCard> {

  Future<Parents?> get _parentsFuture => ParentsService.getParents(widget.earring);

  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    late Parents parents;

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
            shouldShowHeader: false,
            postSaved: () => setState(() => ())
          );
        } else {
          parents = snapshot.data!;

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

        void onAction(String action) {
          if (action == "Editar") {
            showDialog(
              context: context,
              builder: (context) => Dialog(child: ParentsInfoForm(earring: widget.earring, parents: parents, shouldPop: true))
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
                    await ParentsService.deleteParents(parents.bovine);

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
          title: "Progenitores",
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
