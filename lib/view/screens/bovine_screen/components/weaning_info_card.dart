import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:integrazoo/view/components/titled_card.dart';

import 'package:integrazoo/view/forms/update/weaning_info_form.dart';

import 'package:integrazoo/control/weaning_controller.dart';

import 'package:integrazoo/database/database.dart';


class WeaningInfoCard extends StatefulWidget {
  final int earring;

  const WeaningInfoCard({ super.key, required this.earring });

  @override
  State<WeaningInfoCard> createState() => _WeaningInfoCard();
}

class _WeaningInfoCard extends State<WeaningInfoCard> {

  Future<Weaning?> get _weaningFuture => WeaningController.getWeaning(widget.earring);

  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Weaning?>(
      future: _weaningFuture,
      builder: (context, AsyncSnapshot<Weaning?> snapshot) {
        late Widget cardContent;
        if (snapshot.connectionState != ConnectionState.done && !snapshot.hasData) {
          cardContent = const Text("Carregando...", style: TextStyle(fontStyle: FontStyle.italic), textAlign: TextAlign.center);
        } else if (snapshot.connectionState == ConnectionState.done && (!snapshot.hasData || isEditing)) {
          cardContent = WeaningInfoForm(
            earring: widget.earring,
            weaning: snapshot.data,
            postSaved: () => setState(() => isEditing = false)
          );
        } else {
          final weaning = snapshot.data!;

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

        return TitledCard(
          title: "Desmame",
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
          title: const Text('Você deseja mesmo deletar as informações de desmame desse animal?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                WeaningController.deleteWeaning(widget.earring);
                Navigator.of(context).pop();
              },
              child: const Text("Confirmar"),
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
