import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:integrazoo/view/forms/finish_form.dart';

import 'package:integrazoo/control/finish_controller.dart';

import 'package:integrazoo/database/database.dart';


class FinishesListView extends StatefulWidget {
  const FinishesListView({ super.key });

  @override
  State<FinishesListView> createState() => _FinishesListView();
}

class _FinishesListView extends State<FinishesListView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FinishController.countFinishes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.connectionState == ConnectionState.done && !snapshot.hasData) {
          return const Text("Algo de errado ocorreu! Por favor, contate o suporte.");
        }

        if (snapshot.data! == 0) {
          return const Center(child: Text("Nenhuma finalização registrado até o momento."));
        }

        return PaginateFinishes(numElements: snapshot.data!, postAction: () => setState(() => ()));
      }
    );
  }
}

class PaginateFinishes extends StatefulWidget {
  final int numElements;
  final VoidCallback? postAction;

  const PaginateFinishes({ super.key, required this.numElements, this.postAction });

  @override
  State<PaginateFinishes> createState() => _PaginateFinishes();
}

class _PaginateFinishes extends State<PaginateFinishes> {
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
      Expanded(child: buildFinishes_())
    ]);
  }

  Widget buildFinishes_() {
    return FutureBuilder(
      future: FinishController.getFinishes(pageSize, page),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.connectionState == ConnectionState.done && !snapshot.hasData) {
          return const Text("Algo de errado ocorreu! Por favor, contate o suporte.");
        }

        return buildFinishes(snapshot.data!);
      }
    );
  }

  Widget buildFinishes(List<Finish> finishes) {
    if (finishes.isEmpty) {
      return const Center(child: Text("Nenhuma finalização registrado no momento."));
    }

    return ListView.separated(
      itemCount: finishes.length + 1,
      itemBuilder: (ctx, idx) {
        if (idx == finishes.length) {
          return const SizedBox.shrink();
        }
        final e = finishes[idx];
        return FinishTile(finish: e, postAction: widget.postAction);
      },
      separatorBuilder: (ctx, idx) {
        return const Divider(color: Colors.black, height: 1);
      },
    );
  }
}

class FinishTile extends StatelessWidget {
  final Finish finish;

  final VoidCallback? postAction;

  const FinishTile({
    super.key,
    required this.finish,
    this.postAction
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Animal: #${finish.bovine}'),
      subtitle: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text('Data: ${DateFormat.yMd("pt_BR").format(finish.date)}'),
        Text('Motivação: ${finish.reason.toString()}'),
        if (finish.reason == FinishingReason.slaughter) ...[
          Text('Peso Animal: ${finish.weight}'),
          Text('Peso da Carcaça Quente: ${finish.hotCarcassWeight}'),
        ]
      ]),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      trailing: _PopupMenuActions(finish: finish, postAction: postAction),
    );
  }
}

class _PopupMenuActions extends StatefulWidget {
  final Finish finish;

  final VoidCallback? postAction;

  const _PopupMenuActions({ super.key, required this.finish, this.postAction });

  @override
  State<_PopupMenuActions> createState() => _PopupMenuActionsState();
}

class _PopupMenuActionsState extends State<_PopupMenuActions> {

  void _handleAction(String action, BuildContext context) {
    switch (action) {
      case "Editar":
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(child: FinishForm(finish: widget.finish, shouldPop: true));
          }
        ).then((_) => widget.postAction?.call());
        break;

      case "Deletar":
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            icon: const Icon(Icons.info),
            title: const Text("Deseja mesmo deletar a finalização?"),
            actions: [ TextButton(
              onPressed: () async {
                await FinishController.delete(widget.finish.bovine);

                if (mounted && context.mounted) {
                  Navigator.of(context).pop();
                  widget.postAction!();
                }
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
