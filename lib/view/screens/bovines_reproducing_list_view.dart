import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:integrazoo/view/components/button.dart';

import 'package:integrazoo/control/reproduction_controller.dart';

import 'package:integrazoo/view/forms/create/artificial_insemination_form.dart';
import 'package:integrazoo/view/forms/create/natural_mating_form.dart';

import 'package:integrazoo/database/database.dart';


class BovinesReproducingListView extends StatefulWidget {
  const BovinesReproducingListView({ super.key });

  @override
  State<BovinesReproducingListView> createState() => _BovinesReproducingListView();
}

class _BovinesReproducingListView extends State<BovinesReproducingListView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ReproductionController.countBovinesReproducing(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.connectionState == ConnectionState.done && !snapshot.hasData) {
          return const Text("Algo de errado ocorreu! Por favor, contate o suporte.");
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
      Expanded(child: buildReproductions_())
    ]);
  }

  Widget buildReproductions_() {
    return FutureBuilder(
      future: ReproductionController.getBovinesReproducing(pageSize, page),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.connectionState == ConnectionState.done && !snapshot.hasData) {
          return const Text("Algo de errado ocorreu! Por favor, contate o suporte.");
        }

        return buildReproductions(snapshot.data!);
      }
    );
  }

  Widget buildReproductions(List<(Bovine, Reproduction)> bovinesReproducing) {
    if (bovinesReproducing.isEmpty) {
      return const Center(child: Text("Nenhuma fêmea reproduzindo no momento."));
    }

    return ListView.separated(
      itemCount: bovinesReproducing.length + 1,
      itemBuilder: (ctx, idx) {
        if (idx == bovinesReproducing.length) {
          return const SizedBox.shrink();
        }
        final e = bovinesReproducing[idx];
        return BovineReproductionTile(bovine: e.$1, reproduction: e.$2, postAction: widget.postAction);
      },
      separatorBuilder: (ctx, idx) {
        return const Divider(color: Colors.black, height: 1);
      },
    );
  }
}

class BovineReproductionTile extends StatelessWidget {
  final Bovine bovine;
  final Reproduction reproduction;

  final VoidCallback? postAction;

  const BovineReproductionTile({
    super.key,
    required this.bovine,
    required this.reproduction,
    this.postAction
  });

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('dd/MM/yyyy');

    return ListTile(
      title: Text('${bovine.name ?? ""} #${bovine.earring}'),
      subtitle: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text('Tipo: ${reproduction.kind.toString()}'),
        Text('Pai: ${reproduction.bull != null  ? "#${reproduction.bull}" : reproduction.breeder}'),
        Text('Data: ${formatter.format(reproduction.date)}'),
        if (reproduction.kind == ReproductionKind.artificialInsemination)
          Text('Pipeta: ${reproduction.strawNumber}'),
      ]),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      trailing: _PopupMenuActions(reproduction: reproduction, postAction: postAction),
    );
  }
}

class _PopupMenuActions extends StatefulWidget {
  final Reproduction reproduction;

  final VoidCallback? postAction;

  const _PopupMenuActions({ super.key, required this.reproduction, this.postAction });

  @override
  State<_PopupMenuActions> createState() => _PopupMenuActionsState();
}

class _PopupMenuActionsState extends State<_PopupMenuActions> {

  void _handleAction(String action, BuildContext context) {
    switch (action) {
      case "Editar":
        final page = widget.reproduction.kind == ReproductionKind.coverage ?
                     NaturalMatingForm(reproduction: widget.reproduction, shouldPop: true) :
                     ArtificialInseminationForm(reproduction: widget.reproduction, shouldPop: true);

        Navigator.of(context)
                 .push(MaterialPageRoute(builder: (context) => page))
                 .then((_) => widget.postAction!());
        break;

      case "Deletar":
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              icon: const Icon(Icons.info),
              iconColor: Colors.black,
              title: const Text("Deseja mesmo deletar o tratamento?"),
              actions: [
                Center(
                  child: Button(
                    text: "Confirmar",
                    color: Colors.green,
                    onPressed: () =>
                      ReproductionController.delete(widget.reproduction.id).then(
                        (_) {
                          if (mounted) {
                            Navigator.of(context).pop();
                          }
                          widget.postAction!();
                        }
                      )
                  ),
                ),
              ],
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2.0))),
            );
          },
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
