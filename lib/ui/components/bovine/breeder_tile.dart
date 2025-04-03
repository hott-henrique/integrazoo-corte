import 'dart:developer'; // ignore: unused_import

import 'package:flutter/material.dart';

import 'package:integrazoo/backend.dart';

import 'package:integrazoo/ui/forms.dart';


class BreederTile extends StatelessWidget {
  final Breeder breeder;

  final VoidCallback? postAction;

  const BreederTile({
    super.key,
    required this.breeder,
    this.postAction
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(breeder.name),
      subtitle: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        if (breeder.father == null &&
            breeder.mother == null &&
            breeder.paternalGrandfather == null &&
            breeder.paternalGrandmother == null &&
            breeder.maternalGrandfather == null &&
            breeder.maternalGrandmother == null &&
            breeder.epdBirthWeight == null &&
            breeder.epdWeaningWeight == null &&
            breeder.epdYearlingWeight == null) ...[
          const Text('Nenhuma outra informação registrada.'),
        ],

        if (breeder.father != null) Text('Pai: ${breeder.father}'),
        if (breeder.mother != null) Text('Mãe: ${breeder.mother}'),

        if (breeder.paternalGrandfather != null) Text('Avô Paterno: ${breeder.paternalGrandfather}'),
        if (breeder.paternalGrandmother != null) Text('Avó Paterna: ${breeder.paternalGrandmother}'),
        if (breeder.maternalGrandfather != null) Text('Avô Materno: ${breeder.maternalGrandfather}'),
        if (breeder.maternalGrandmother != null) Text('Avó Materna: ${breeder.maternalGrandmother}'),

        if (breeder.epdBirthWeight != null) Text('PN: ${breeder.epdBirthWeight!.toStringAsFixed(2)}'),
        if (breeder.epdWeaningWeight != null) Text('PD: ${breeder.epdWeaningWeight!.toStringAsFixed(2)}'),
        if (breeder.epdYearlingWeight != null) Text('PA: ${breeder.epdYearlingWeight!.toStringAsFixed(2)}'),
      ]),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      trailing: _PopupMenuActions(breeder: breeder, postAction: postAction),
    );
  }
}

class _PopupMenuActions extends StatefulWidget {
  final Breeder breeder;

  final VoidCallback? postAction;

  const _PopupMenuActions({ super.key, required this.breeder, this.postAction });

  @override
  State<_PopupMenuActions> createState() => _PopupMenuActionsState();
}

class _PopupMenuActionsState extends State<_PopupMenuActions> {

  void _handleAction(String action, BuildContext context) {
    switch (action) {
      case "Editar":
        showDialog(
          context: context,
          builder: (context) => Dialog(child: BreederForm(breeder: widget.breeder, shoudPop: true))
        ).then((_) => setState(() => widget.postAction?.call()));
        break;

      case "Deletar":
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            icon: const Icon(Icons.info),
            title: const Text("Deseja mesmo deletar o desmame?"),
            actions: [ TextButton(
              onPressed: () async {
                await BreederService.deleteBreeder(widget.breeder.name);

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
