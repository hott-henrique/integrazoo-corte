import 'dart:developer'; // ignore: unused_import

import 'package:flutter/material.dart';

import 'package:integrazoo/domain/enumerations.dart';

import 'package:integrazoo/backend/database/database.dart';

import 'package:integrazoo/backend/services/bovine_service.dart';

import 'package:integrazoo/ui/forms/bovine_form.dart';

import 'package:integrazoo/ui/screens/bovine_screen/bovine_screen.dart';


class BovinesListView extends StatefulWidget {
  const BovinesListView({ super.key });

  @override
  State<BovinesListView> createState() => _BovinesListView();
}

class _BovinesListView extends State<BovinesListView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: BovineService.countBovines(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.connectionState == ConnectionState.done && !snapshot.hasData) {
          return const Text("Algo de errado ocorreu! Por favor, contate o suporte.");
        }

        if (snapshot.data! == 0) {
          return const Center(child: Text("Nenhum animal registrado até o momento."));
        }

        return PaginateBovinesReproducing(numElements: snapshot.data!, postAction: () => setState(() => ()));
      }
    );
  }
}

class PaginateBovinesReproducing extends StatefulWidget {
  final int numElements;
  final VoidCallback? postAction;

  const PaginateBovinesReproducing({ super.key, required this.numElements, this.postAction });

  @override
  State<PaginateBovinesReproducing> createState() => _PaginateBovinesReproducing();
}

class _PaginateBovinesReproducing extends State<PaginateBovinesReproducing> {
  int page = 0, pageSize = 25;

  int get maxPages => (widget.numElements / pageSize).ceil();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        IconButton(
          onPressed: () {
            if (page > 0) {
              setState(() => page = page - 1);
            }
          },
          icon: const Icon(Icons.arrow_left)
        ),
        Text("${page + 1} / $maxPages"),
        IconButton(
          onPressed: () {
            if (page < maxPages - 1) {
              setState(() => page = page + 1);
            }
          },
          icon: const Icon(Icons.arrow_right)
        ),
      ]),
      const Divider(color: Colors.black, height: 1),
      Expanded(child: buildBovines_())
    ]);
  }

  Widget buildBovines_() {
    return FutureBuilder(
      future: BovineService.getBovines(pageSize, page),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.connectionState == ConnectionState.done && !snapshot.hasData) {
          return const Text("Algo de errado ocorreu! Por favor, contate o suporte.");
        }

        return buildBovines(snapshot.data!);
      }
    );
  }

  Widget buildBovines(List<Bovine> bovines) {
    if (bovines.isEmpty) {
      return const Center(child: Text("Nenhum desmame registrado no momento."));
    }

    return ListView.separated(
      itemCount: bovines.length + 1,
      itemBuilder: (ctx, idx) {
        if (idx == bovines.length) {
          return const SizedBox.shrink();
        }
        final e = bovines[idx];
        return BovineTile(bovine: e, postAction: widget.postAction);
      },
      separatorBuilder: (ctx, idx) {
        return const Divider(color: Colors.black, height: 1);
      },
    );
  }
}

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
