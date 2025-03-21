import 'dart:developer'; // ignore: unused_import

import 'package:flutter/material.dart';

import 'package:integrazoo/backend.dart';

import 'package:integrazoo/ui/forms.dart';


class BreedersListView extends StatefulWidget {
  const BreedersListView({ super.key });

  @override
  State<BreedersListView> createState() => _BreedersListView();
}

class _BreedersListView extends State<BreedersListView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: BreederService.countBreeders(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.connectionState == ConnectionState.done && !snapshot.hasData) {
          return const Text("Algo de errado ocorreu! Por favor, contate o suporte.");
        }

        return PaginateBreeders(numElements: snapshot.data!, postAction: () => setState(() => ()));
      }
    );
  }
}

class PaginateBreeders extends StatefulWidget {
  final int numElements;
  final VoidCallback? postAction;

  const PaginateBreeders({ super.key, required this.numElements, this.postAction });

  @override
  State<PaginateBreeders> createState() => _PaginateBreeders();
}

class _PaginateBreeders extends State<PaginateBreeders> {
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
      Expanded(child: buildBreeders_())
    ]);
  }

  Widget buildBreeders_() {
    return FutureBuilder(
      future: BreederService.getBreeders(pageSize, page),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.connectionState == ConnectionState.done && !snapshot.hasData) {
          return const Text("Algo de errado ocorreu! Por favor, contate o suporte.");
        }

        return buildBreeders(snapshot.data!);
      }
    );
  }

  Widget buildBreeders(List<Breeder> breeders) {
    if (breeders.isEmpty) {
      return const Center(child: Text("Nenhum desmame registrado no momento."));
    }

    return ListView.separated(
      itemCount: breeders.length + 1,
      itemBuilder: (ctx, idx) {
        if (idx == breeders.length) {
          return const SizedBox.shrink();
        }
        final e = breeders[idx];
        return BreederTile(breeder: e, postAction: widget.postAction);
      },
      separatorBuilder: (ctx, idx) {
        return const Divider(color: Colors.black, height: 1);
      },
    );
  }
}

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
