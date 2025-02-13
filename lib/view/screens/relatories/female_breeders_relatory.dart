import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:integrazoo/control/relatory_controller.dart';
import 'package:integrazoo/persistence/relatory_persistence.dart';


class FemaleBreedersRelatoryListView extends StatefulWidget {
  const FemaleBreedersRelatoryListView({ super.key });

  @override
  State<FemaleBreedersRelatoryListView> createState() => _FemaleBreedersRelatoryListView();
}

class _FemaleBreedersRelatoryListView extends State<FemaleBreedersRelatoryListView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: RelatoryPersistence.countNonDiscardedFemaleBreeders(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.connectionState == ConnectionState.done && !snapshot.hasData) {
          return const Text("Algo de errado ocorreu! Por favor, contate o suporte.");
        }

        if (snapshot.data! == 0) {
          return const Center(child: Text("Nenhum matriz disponível para analise no momento."));
        }

        return PaginateFemaleBreedersRelatory(numElements: snapshot.data!, postAction: () => setState(() => ()));
      }
    );
  }
}

class PaginateFemaleBreedersRelatory extends StatefulWidget {
  final int numElements;
  final VoidCallback? postAction;

  const PaginateFemaleBreedersRelatory({ super.key, required this.numElements, this.postAction });

  @override
  State<PaginateFemaleBreedersRelatory> createState() => _PaginateFemaleBreedersRelatory();
}

class _PaginateFemaleBreedersRelatory extends State<PaginateFemaleBreedersRelatory> {
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
      Expanded(child: FemaleBreedersRelatory(page: page, pageSize: pageSize))
    ]
    );
  }
}

class FemaleBreedersRelatory extends StatefulWidget {
  final int page, pageSize;

  const FemaleBreedersRelatory({ super.key, required this.page, required this.pageSize });

  @override
  State<FemaleBreedersRelatory> createState() => _FemaleBreedersRelatory();
}

class _FemaleBreedersRelatory extends State<FemaleBreedersRelatory> {
  bool isAscending = true;
  int previousSortColumnIndex = 0;
  int sortColumnIndex = 1;

  @override
  Widget build(BuildContext context) {
    return buildTable();
  }

  List<DataRow> _buildRows(List<(String, double?, double?, double?, int?, int)> data) {
    int index = 0;
    return data.map((rowData) {
      Color? c = (index % 2) == 0 ? const Color.fromRGBO(201, 201, 201, 1.0) : null;
      index = index + 1;
      return DataRow(
        cells: [
          DataCell(Text(rowData.$1)),
          DataCell(Text((rowData.$2?.toStringAsFixed(2) ?? "-"))),
          DataCell(Text((rowData.$3?.toStringAsFixed(2)?? "-"))),
          DataCell(Text((rowData.$4?.toStringAsFixed(2)?? "-"))),
          DataCell(Text((rowData.$5?.toString()?? "-"))),
          DataCell(Text(rowData.$6.toString()))
        ],
        color: WidgetStatePropertyAll<Color?>(c)
      );
    }).toList();
  }

  DataCell buildCell(String content) {
    return DataCell(Text(content));
  }

  Widget buildTable() {
    void onSort(idx, asc) {
      setState(() {
        previousSortColumnIndex = sortColumnIndex;
        sortColumnIndex = idx;

        if (previousSortColumnIndex == sortColumnIndex) {
          isAscending = !isAscending;
        } else {
          isAscending = true;
        }
      });
    }

    final columns = <DataColumn>[
      const DataColumn(label: Expanded(child: Text('Animal'))),
      DataColumn(label: const Expanded(child: Text('Peso ao Sobreano (Kg)')), onSort: onSort),
      DataColumn(label: const Expanded(child: Text('Peso ao Nascer (Kg)')), onSort: onSort),
      DataColumn(label: const Expanded(child: Text('Peso a Desmama (Kg)')), onSort: onSort),
      DataColumn(label: const Expanded(child: Text('IPP (Meses)')), onSort: onSort),
      DataColumn(label: const Expanded(child: Text('# Tentativas')), onSort: onSort)
    ];

    return FutureBuilder<List<dynamic>>(
      future: RelatoryController.getFemaleBreedersStatistics(widget.pageSize, widget.page),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        late List<DataRow> rows;

        if (snapshot.connectionState != ConnectionState.done && !snapshot.hasData) {
          rows = [];
        } else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasData) {
          rows = [];
        } else {
          final data = snapshot.data as List<(String, double?, double?, double?, int?, int)>;

          rows = _buildRows(data);
        }

        rows.sort((a, b) {
          final valueA = double.tryParse((a.cells[sortColumnIndex].child as Text).data!) ?? 0.0;
          final valueB = double.tryParse((b.cells[sortColumnIndex].child as Text).data!) ?? 0.0;

          return isAscending ? valueA.compareTo(valueB) : valueB.compareTo(valueA);
        });

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SingleChildScrollView(
              child: DataTable(
                rows: rows,
                columns: columns,
                sortAscending: isAscending,
                sortColumnIndex: sortColumnIndex,
              )
            )
          ]
        );
      }
    );
  }
}
