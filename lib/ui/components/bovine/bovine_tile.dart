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
    return ListTile(
      title: Text('${bovine.name != null ? "${bovine.name!} "  : ""}#${bovine.earring}'),
      subtitle: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text('Sexo: ${bovine.sex.toString()}'),
        Text('$breederString: ${bovine.isBreeder ? "Sim" : "Não"}'),
        Text('Finalizado: ${bovine.wasDiscarded ? "Sim" : "Não"}'),
        if (!bovine.wasDiscarded) ...[
          if (bovine.isReproducing) ...[
            Text('Reproduzindo: ${bovine.isReproducing ? "Sim" : "Não"}')
          ],
          if (bovine.isPregnant) ...[
            Text('Reproduzindo: ${bovine.isPregnant ? "Sim" : "Não"}')
          ]
        ],
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
