import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';


import 'package:integrazoo/control/pregnancy_controller.dart';

import 'package:integrazoo/view/forms/update/pregnancy_info_form.dart';

import 'package:integrazoo/database/database.dart';


class BovinesPregnantListView extends StatefulWidget {
  const BovinesPregnantListView({ super.key });

  @override
  State<BovinesPregnantListView> createState() => _BovinesPregnantListView();
}

class _BovinesPregnantListView extends State<BovinesPregnantListView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: PregnancyController.countBovinesPregnant(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.connectionState == ConnectionState.done && !snapshot.hasData) {
          return const Text("Algo de errado ocorreu! Por favor, contate o suporte.");
        }

        if (snapshot.data! == 0) {
          return const Center(child: Text("Nenhuma fêmea prenhe no momento."));
        }

        return PaginateBovinesPregnant(numElements: snapshot.data!, postAction: () => setState(() => ()));
      }
    );
  }
}

class PaginateBovinesPregnant extends StatefulWidget {
  final int numElements;
  final VoidCallback? postAction;

  const PaginateBovinesPregnant({ super.key, required this.numElements, this.postAction });

  @override
  State<PaginateBovinesPregnant> createState() => _PaginateBovinesPregnant();
}

class _PaginateBovinesPregnant extends State<PaginateBovinesPregnant> {
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
      future: PregnancyController.getBovinesPregnant(pageSize, page),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.connectionState == ConnectionState.done && !snapshot.hasData) {
          return const Text("Algo de errado ocorreu! Por favor, contate o suporte.");
        }

        return buildTreatments(snapshot.data!);
      }
    );
  }

  Widget buildTreatments(List<(Bovine, Pregnancy)> bovinesPregnant) {
    if (bovinesPregnant.isEmpty) {
      return const Center(child: Text("Nenhuma fêmea prenhe no momento."));
    }

    return ListView.separated(
      itemCount: bovinesPregnant.length + 1,
      itemBuilder: (ctx, idx) {
        if (idx == bovinesPregnant.length) {
          return const SizedBox.shrink();
        }
        final e = bovinesPregnant[idx];
        return BovinePregnancyTile(bovine: e.$1, pregnancy: e.$2, postAction: widget.postAction);
      },
      separatorBuilder: (ctx, idx) {
        return const Divider(color: Colors.black, height: 1);
      },
    );
  }
}

class BovinePregnancyTile extends StatelessWidget {
  final Bovine bovine;
  final Pregnancy pregnancy;

  final VoidCallback? postAction;

  const BovinePregnancyTile({
    super.key,
    required this.bovine,
    required this.pregnancy,
    this.postAction
  });

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('dd/MM/yyyy');

    return ListTile(
      title: Text('${bovine.name ?? ""} #${bovine.earring}'),
      subtitle: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text('Data Diagnóstico: ${formatter.format(pregnancy.date)}'),
        Text('Previsão Parto: ${formatter.format(pregnancy.birthForecast)}')
      ]),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      trailing: _PopupMenuActions(pregnancy: pregnancy, postAction: postAction),
    );
  }
}

class _PopupMenuActions extends StatefulWidget {
  final Pregnancy pregnancy;

  final VoidCallback? postAction;

  const _PopupMenuActions({ super.key, required this.pregnancy, this.postAction });

  @override
  State<_PopupMenuActions> createState() => _PopupMenuActionsState();
}

class _PopupMenuActionsState extends State<_PopupMenuActions> {

  void _handleAction(String action, BuildContext context) {
    switch (action) {
      case "Editar":
        Navigator.of(context)
                 .push(MaterialPageRoute(builder: (context) => PregnancyInfoForm(pregnancy: widget.pregnancy)))
                 .then((value) => widget.postAction!());
        break;

      case "Deletar":
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              icon: const Icon(Icons.info),
              title: const Text("Deseja mesmo deletar este diagnóstico?"),
              actions: [ TextButton(
                onPressed: () async {
                  await PregnancyController.delete(widget.pregnancy.id);

                  if (mounted && context.mounted) {
                    Navigator.of(context).pop();
                    widget.postAction!();
                  }
                },
                child: const Text("Confirmar"),
              ) ]
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
