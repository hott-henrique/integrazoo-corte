import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:integrazoo/view/components/titled_card.dart';

import 'package:integrazoo/view/forms/birth_info_form.dart';

import 'package:integrazoo/control/birth_controller.dart';

import 'package:integrazoo/database/database.dart';


class BirthInfoCard extends StatefulWidget {
  final int earring;

  const BirthInfoCard({ super.key, required this.earring });

  @override
  State<BirthInfoCard> createState() => _BirthInfoCard();
}

class _BirthInfoCard extends State<BirthInfoCard> {
  Future<Birth?> get _birthFuture => BirthController.getBirth(widget.earring);

  @override
  Widget build(BuildContext context) {
    late Birth birth;

    return FutureBuilder<Birth?>(
      future: _birthFuture,
      builder: (context, AsyncSnapshot<Birth?> snapshot) {
        late Widget cardContent;

        if (snapshot.connectionState != ConnectionState.done && !snapshot.hasData) {
          cardContent = const Text("Carregando...", style: TextStyle(fontStyle: FontStyle.italic), textAlign: TextAlign.center);
        } else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasData) {
          cardContent = BirthInfoForm(earring: widget.earring, shouldShowHeader: false);
        } else {
          birth = snapshot.data!;

          cardContent = Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildInfo("Data", DateFormat.yMd("pt_BR").format(birth.date)),
                buildInfo("Peso", '${birth.weight.toString()} Kg'),
                buildInfo("Classificação Corporal", birth.bcs.toString()),
              ]
            ),
          );
        }

        void onAction(String action) {
          if (action == "Editar") {
            showDialog(
              context: context,
              builder: (context) => Dialog(child: BirthInfoForm(birth: birth, shouldPop: true))
            ).then((_) => setState(() => ()));
            return;
          }

          if (action == "Deletar") {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                icon: const Icon(Icons.info),
                title: const Text("Deseja mesmo deletar as informações de nascimento?"),
                actions: [ TextButton(
                  onPressed: () async {
                    await BirthController.deleteBirth(birth.bovine);

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
          title: "Nascimento",
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
