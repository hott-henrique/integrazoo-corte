import 'dart:developer'; // ignore: unused_import

import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

import 'package:integrazoo/backend.dart';

import 'package:integrazoo/ui/forms.dart';


class TreatmentsListView extends StatefulWidget {
  const TreatmentsListView({ super.key });

  @override
  State<TreatmentsListView> createState() => _TreatmentsListView();
}

class _TreatmentsListView extends State<TreatmentsListView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: TreatmentService.countTreatments(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.connectionState == ConnectionState.done && !snapshot.hasData) {
          return const Text("Algo de errado ocorreu! Por favor, contate o suporte.");
        }

        if (snapshot.data! == 0) {
          return const Center(child: Text("Nenhum tratamento registrado até o momento."));
        }

        return PaginateTreatments(numElements: snapshot.data!, postAction: () => setState(() => ()));
      }
    );
  }
}

class PaginateTreatments extends StatefulWidget {
  final int numElements;
  final VoidCallback? postAction;

  const PaginateTreatments({ super.key, required this.numElements, this.postAction });

  @override
  State<PaginateTreatments> createState() => _PaginateTreatments();
}

class _PaginateTreatments extends State<PaginateTreatments> {
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
      future: TreatmentService.getTreatments(pageSize, page),
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

  Widget buildTreatments(List<Treatment> treatments) {
    if (treatments.isEmpty) {
      return const Center(child: Text("Nenhum tratamento registrado no momento."));
    }

    return ListView.separated(
      itemCount: treatments.length + 1,
      itemBuilder: (ctx, idx) {
        if (idx == treatments.length) {
          return const SizedBox.shrink();
        }
        final e = treatments[idx];
        return TreatmentTile(treatment: e, postAction: widget.postAction);
      },
      separatorBuilder: (ctx, idx) {
        return const Divider(color: Colors.black, height: 1);
      },
    );
  }
}

class TreatmentTile extends StatelessWidget {
  final Treatment treatment;

  final VoidCallback? postAction;

  const TreatmentTile({
    super.key,
    required this.treatment,
    this.postAction
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Animal: #${treatment.bovine}'),
      subtitle: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text('Medicamento: ${treatment.medicine}'),
        Text('Motivação: ${treatment.reason}'),
        Text('Início: ${DateFormat.yMd("pt_BR").format(treatment.startingDate)}'),
        Text('Fim: ${DateFormat.yMd("pt_BR").format(treatment.endingDate)}'),
      ]),
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
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(child: TreatmentForm(treatment: widget.treatment, shouldPop: true));
          }
        ).then((_) => widget.postAction?.call());
        break;

      case "Deletar":
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            icon: const Icon(Icons.info),
            title: const Text("Deseja mesmo deletar o tratamento?"),
            actions: [ TextButton(
              onPressed: () async {
                await TreatmentService.delete(widget.treatment.id);

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
