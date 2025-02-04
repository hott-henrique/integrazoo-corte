import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';


import 'package:integrazoo/control/treatment_controller.dart';

import 'package:integrazoo/view/forms/create/treatment_form.dart';

import 'package:integrazoo/database/database.dart';


class BovinesInTreatmentListView extends StatefulWidget {
  const BovinesInTreatmentListView({ super.key });

  @override
  State<BovinesInTreatmentListView> createState() => _BovinesInTreatmentListView();
}

class _BovinesInTreatmentListView extends State<BovinesInTreatmentListView> {
  bool hasTriedLoading = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: TreatmentController.countActiveTreatments(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.connectionState == ConnectionState.done && !snapshot.hasData) {
          return const Text("Algo de errado ocorreu! Por favor, contate o suporte.");
        }

        return PaginateBovinesInTreatment(numElements: snapshot.data!, postAction: () => setState(() => ()));
      }
    );
  }
}

class PaginateBovinesInTreatment extends StatefulWidget {
  final int numElements;
  final VoidCallback? postAction;

  const PaginateBovinesInTreatment({ super.key, required this.numElements, this.postAction });

  @override
  State<PaginateBovinesInTreatment> createState() => _PaginateBovinesInTreatment();
}

class _PaginateBovinesInTreatment extends State<PaginateBovinesInTreatment> {
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
      Expanded(child: buildTreatments_())
    ]);
  }

  Widget buildTreatments_() {
    return FutureBuilder(
      future: TreatmentController.getBovinesInTreatment(pageSize, page),
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

  Widget buildTreatments(List<(Bovine, Treatment)> bovinesInTreatment) {
    if (bovinesInTreatment.isEmpty) {
      return const Center(child: Text("Nenhum animal em tratamento no momento."));
    }

    return ListView.separated(
      itemCount: bovinesInTreatment.length + 1,
      itemBuilder: (ctx, idx) {
        if (idx == bovinesInTreatment.length) {
          return const SizedBox.shrink();
        }
        final e = bovinesInTreatment[idx];
        return BovineTreatmentTile(bovine: e.$1, treatment: e.$2, postAction: widget.postAction);
      },
      separatorBuilder: (ctx, idx) {
        return const Divider(color: Colors.black, height: 1);
      },
    );
  }
}

class BovineTreatmentTile extends StatelessWidget {
  final Bovine bovine;
  final Treatment treatment;

  final VoidCallback? postAction;

  const BovineTreatmentTile({
    super.key,
    required this.bovine,
    required this.treatment,
    this.postAction
  });

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('dd/MM/yyyy');

    return ListTile(
      title: Text('${bovine.name ?? ""} #${bovine.earring}'),
      subtitle: Text('${treatment.medicine}: ${treatment.reason}\n'
                     'Início: ${formatter.format(treatment.startingDate)} - Fim: ${formatter.format(treatment.endingDate)}'),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      trailing: _PopupMenuActions(treatment: treatment, postAction: postAction),
    );
  }
}

class _PopupMenuActions extends StatefulWidget {
  final Treatment treatment;

  final VoidCallback? postAction;

  const _PopupMenuActions({ super.key, required this.treatment, this.postAction });

  @override
  State<_PopupMenuActions> createState() => _PopupMenuActionsState();
}

class _PopupMenuActionsState extends State<_PopupMenuActions> {

  void _handleAction(String action, BuildContext context) {
    switch (action) {
      case "Editar":
        Navigator.of(context)
                 .push(MaterialPageRoute(builder: (context) => TreatmentForm(treatment: widget.treatment, shouldPop: true)))
                 .then((_) => widget.postAction!());
        break;

      case "Deletar":
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              icon: const Icon(Icons.info),
              title: const Text("Deseja mesmo deletar o tratamento?"),
              actions: [ TextButton(
                onPressed: () async {
                  await TreatmentController.delete(widget.treatment.id);

                  if (mounted && context.mounted) {
                    Navigator.of(context).pop();
                    widget.postAction!();
                  }
                },
                child: const Text("Confirmar")
              ) ]
            );
          }
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
