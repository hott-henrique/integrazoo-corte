import 'dart:developer'; // ignore: unused_import

import 'package:flutter/material.dart';

import 'package:integrazoo/backend.dart';

import 'package:integrazoo/ui/screens.dart';
import 'package:integrazoo/ui/forms.dart';


class BovineTile extends StatelessWidget {
  final Bovine bovine;

  final VoidCallback? postAction;

  const BovineTile({
    super.key,
    required this.bovine,
    this.postAction
  });

  @override
  Widget build(BuildContext context) {
    final breederString = bovine.sex == Sex.female ? "Matriz" : "Reprodutor";
    final suffixString = bovine.sex == Sex.female ? "a" : "o";
    final sexColor = bovine.sex == Sex.female ? Colors.pink : Colors.blue;
    return ListTile(
      title: RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style, // inherit default style
          children: [
            TextSpan(text: bovine.name != null ? "${bovine.name!} " : ""),
            TextSpan(
              text: "#${bovine.earring}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      subtitle: Wrap(spacing: 8, children: [
        Badge(label: Text(bovine.sex.toString()), backgroundColor: sexColor),
        if (bovine.hasBeenWeaned) Badge(label: Text("Desmamad$suffixString"), backgroundColor: Colors.orange),
        if (bovine.isBreeder) Badge(label: Text(breederString), backgroundColor: Colors.amber),
        if (bovine.isReproducing) const Badge(label: Text("Reproduzindo"), backgroundColor: Colors.green),
        if (bovine.isPregnant) const Badge(label: Text("Prenha"), backgroundColor: Colors.purple),
        if (bovine.wasFinished) Badge(label: Text("Finalizad$suffixString"), backgroundColor: Colors.grey),
      ]),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      trailing: _PopupMenuActions(bovine: bovine, postAction: postAction),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(child: BovineScreen(earring: bovine.earring));
          }
        ).then((value) => postAction?.call());
      }
    );
  }
}

class _PopupMenuActions extends StatefulWidget {
  final Bovine bovine;

  final VoidCallback? postAction;

  const _PopupMenuActions({ super.key, required this.bovine, this.postAction });

  @override
  State<_PopupMenuActions> createState() => _PopupMenuActionsState();
}

class _PopupMenuActionsState extends State<_PopupMenuActions> {

  void _handleAction(String action, BuildContext context) {
    switch (action) {
      case "Editar":
        showDialog(
          context: context,
          builder: (context) => Dialog(child: BovineForm(bovine: widget.bovine, shouldPop: true))
        ).then((_) => widget.postAction?.call());
        break;

      case "Deletar":
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            icon: const Icon(Icons.info),
            title: const Text("Deseja mesmo deletar este animal?"),
            actions: [ TextButton(
              onPressed: () async {
                await BovineService.deleteBovine(widget.bovine.earring);

                if (mounted && context.mounted) {
                  Navigator.of(context).pop();
                }

                widget.postAction!();
              },
              child: const Text("CONFIRMAR"),
            ) ],
          )
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (action) => _handleAction(action, context),
      itemBuilder: (BuildContext context) => ["Editar", "Deletar"]
          .map((action) => PopupMenuItem<String>(value: action, child: Text(action)))
          .toList(),
    );
  }
}
