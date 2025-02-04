import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:integrazoo/view/components/titled_card.dart';

import 'package:integrazoo/view/forms/update/birth_info_form.dart';

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

  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Birth?>(
      future: _birthFuture,
      builder: (context, AsyncSnapshot<Birth?> snapshot) {
        late Widget cardContent;

        if (snapshot.connectionState != ConnectionState.done && !snapshot.hasData) {
          cardContent = const Text("Carregando...", style: TextStyle(fontStyle: FontStyle.italic), textAlign: TextAlign.center);
        } else if (snapshot.connectionState == ConnectionState.done && (!snapshot.hasData || isEditing)) {
          cardContent = BirthInfoForm(
            earring: widget.earring,
            birth: snapshot.data,
            postSaved: () => setState(() => isEditing = false)
          );
        } else {
          final birth = snapshot.data;

          cardContent = Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildInfo("Data", DateFormat.yMd("pt_BR").format(birth!.date)),
                buildInfo("Peso", '${birth.weight.toString()} Kg'),
                buildInfo("Classificação Corporal", birth.bcs.toString()),
              ]
            ),
          );
        }

        return TitledCard(
          title: "Nascimento",
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
          title: const Text('Você deseja mesmo deletar as informações do nascimento do animal?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                BirthController.deleteBirth(widget.earring);
                Navigator.of(context).pop();
              },
              child: const Text("CONFIRMAR")
            ),
            TextButton(onPressed: Navigator.of(context).pop,  child: const Text("Cancelar"))
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
