import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:integrazoo/view/forms/weaning_form.dart';

import 'package:integrazoo/control/weaning_controller.dart';

import 'package:integrazoo/database/database.dart';


class WeaningsListView extends StatefulWidget {
  const WeaningsListView({ super.key });

  @override
  State<WeaningsListView> createState() => _WeaningsListView();
}

class _WeaningsListView extends State<WeaningsListView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: WeaningController.countWeanings(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.connectionState == ConnectionState.done && !snapshot.hasData) {
          return const Text("Algo de errado ocorreu! Por favor, contate o suporte.");
        }

        if (snapshot.data! == 0) {
          return const Center(child: Text("Nenhum desmame registrado até o momento."));
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
      Expanded(child: buildWeanings_())
    ]);
  }

  Widget buildWeanings_() {
    return FutureBuilder(
      future: WeaningController.getWeanings(pageSize, page),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.connectionState == ConnectionState.done && !snapshot.hasData) {
          return const Text("Algo de errado ocorreu! Por favor, contate o suporte.");
        }

        return buildWeanings(snapshot.data!);
      }
    );
  }

  Widget buildWeanings(List<Weaning> weanings) {
    if (weanings.isEmpty) {
      return const Center(child: Text("Nenhum desmame registrado no momento."));
    }

    return ListView.separated(
      itemCount: weanings.length + 1,
      itemBuilder: (ctx, idx) {
        if (idx == weanings.length) {
          return const SizedBox.shrink();
        }
        final e = weanings[idx];
        return WeaningTile(weaning: e, postAction: widget.postAction);
      },
      separatorBuilder: (ctx, idx) {
        return const Divider(color: Colors.black, height: 1);
      },
    );
  }
}

class WeaningTile extends StatelessWidget {
  final Weaning weaning;

  final VoidCallback? postAction;

  const WeaningTile({
    super.key,
    required this.weaning,
    this.postAction
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Animal: #${weaning.bovine}'),
      subtitle: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text('Data: ${DateFormat.yMd("pt_BR").format(weaning.date)}'),
        Text('Peso: ${weaning.weight}'),
      ]),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      trailing: _PopupMenuActions(weaning: weaning, postAction: postAction),
    );
  }
}

class _PopupMenuActions extends StatefulWidget {
  final Weaning weaning;

  final VoidCallback? postAction;

  const _PopupMenuActions({ super.key, required this.weaning, this.postAction });

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
            return Dialog(child: WeaningForm(earring: widget.weaning.bovine, weaning: widget.weaning));
          }
        ).then((value) => widget.postAction?.call());
        break;

      case "Deletar":
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            icon: const Icon(Icons.info),
            title: const Text("Deseja mesmo deletar o desmame?"),
            actions: [
                TextButton(
                onPressed: () async {
                  await WeaningController.deleteWeaning(widget.weaning.bovine);

                  if (mounted) {
                    Navigator.of(context).pop();
                  }

                  widget.postAction!();
                },
                child: const Text("CONFIRMAR"),
              )
            ],
          )
        ).then((value) => widget.postAction?.call());
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
