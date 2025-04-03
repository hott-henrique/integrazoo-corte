import 'dart:developer'; // ignore: unused_import

import 'package:flutter/material.dart';

import 'package:integrazoo/backend.dart';
import 'package:integrazoo/ui/components.dart';
import 'package:integrazoo/ui/forms/finish_form.dart';
import 'package:intl/intl.dart';


class FinishesPaginationView extends StatefulWidget {
  const FinishesPaginationView({ super.key });

  @override
  State<FinishesPaginationView> createState() => _FinishesPaginationView();
}

class _FinishesPaginationView extends State<FinishesPaginationView> {
  late FinishesDataLoader _dataSource;

  final search = BovinesSearchNotifier();

  @override
  void initState() {
    super.initState();

    _dataSource = FinishesDataLoader();
  }

  @override
  Widget build(BuildContext context) {
    return Paginator(
      loader: _dataSource,
      rowsPerPage: const [ 5, 10, 15, 20],
      pageBuilder: buildTable,
    );
  }

  Widget buildTable(BuildContext context) {
    final columns = <DataColumn>[
      DataColumn(
        label: const Expanded(child: Text('Animal')),
        onSort: (idx, asc) => _dataSource.setOrderField(FinishesOrderField.earring, asc)
      ),
      DataColumn(
        label: const Expanded(child: Text('Motivação')),
        onSort: (idx, asc) => _dataSource.setOrderField(FinishesOrderField.reason, asc)
      ),
      const DataColumn(label: Expanded(child: Text('Observação'))),
      DataColumn(
        label: const Expanded(child: Text('Peso do Animal (Kg)')),
        onSort: (idx, asc) => _dataSource.setOrderField(FinishesOrderField.weight, asc)
      ),
      DataColumn(
        label: const Expanded(child: Text('Peso da Carcaça Quente (Kg)')),
        onSort: (idx, asc) => _dataSource.setOrderField(FinishesOrderField.hotCarcassWeight, asc)
      ),
      DataColumn(
        label: const Expanded(child: Text('Data')),
        onSort: (idx, asc) => _dataSource.setOrderField(FinishesOrderField.date, asc)
      ),
      const DataColumn(label: Expanded(child: Text('Ação')))
    ];

    return SingleChildScrollView(child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DataTable(
          rows: List.generate(_dataSource.availableRows, buildIthElement),
          columns: columns,
          sortColumnIndex: _dataSource.orderFieldIndex,
          sortAscending: _dataSource.orderAscending,
        )
      ]
    ));
  }

  DataRow buildIthElement(int i) {
    if (_dataSource.isLoading) {
      return const DataRow(
        cells: [
          DataCell(CircularProgressIndicator()),
          DataCell(CircularProgressIndicator()),
          DataCell(CircularProgressIndicator()),
          DataCell(CircularProgressIndicator()),
          DataCell(CircularProgressIndicator()),
          DataCell(CircularProgressIndicator()),
        ],
      );
    }

    final s = _dataSource.getElement(i);

    return buildElement(s);
  }

  DataRow buildElement(Finish s) {
    return DataRow(
      cells: [
        DataCell(Text("#${s.bovine.toString()}")),
        DataCell(Text(s.reason.toString())),
        DataCell(SizedBox(width: 300,
          child: Tooltip(
            message: s.observation,
            child: Text(s.observation ?? "-", overflow: TextOverflow.ellipsis, maxLines: 1)
          )
        )),
        DataCell(Text((s.weight?.toStringAsFixed(2) ?? "-"))),
        DataCell(Text((s.hotCarcassWeight?.toStringAsFixed(2) ?? "-"))),
        DataCell(Text((DateFormat.yMd("pt_BR").format(s.date)))),
        DataCell(_PopupMenuActions(finish: s, postAction: _dataSource.reload))
      ]
    );
  }

  Widget buildFilterSelector<T>({
    required String name,
    required List<T> values,
    required List<String> labels,
    required T value,
    required void Function(T? value) onChanged
  }) {
    return Row(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.start, children: [
      Text(name),
      const Spacer(),
      DropdownButton<T>(
        value: value,
        hint: const Text('Selecionar'),
        onChanged: onChanged,
        items: List.generate(values.length, (i) => DropdownMenuItem<T>(
          value: values[i],
          child: Text(labels[i]),
        )))
    ]);
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
                await FinishService.delete(widget.finish.bovine);

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
