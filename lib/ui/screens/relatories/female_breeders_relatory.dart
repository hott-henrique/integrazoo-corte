import 'dart:developer'; // ignore: unused_import

import 'package:flutter/material.dart';

import 'package:integrazoo/backend.dart';


class FemaleBreedersRelatoryListView extends StatefulWidget {
  const FemaleBreedersRelatoryListView({ super.key });

  @override
  State<FemaleBreedersRelatoryListView> createState() => _FemaleBreedersRelatoryListView();
}

class _FemaleBreedersRelatoryListView extends State<FemaleBreedersRelatoryListView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: RelatoryService.countNonDiscardedFemaleBreeders(),
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

  Widget buildTable() {
    final columns = <DataColumn>[
      const DataColumn(label: Expanded(child: Text('Animal'))),
      const DataColumn(label: Expanded(child: Text('Peso ao Sobreano (Kg)'))),
      const DataColumn(label: Expanded(child: Text('Peso ao Nascer (Kg)'))),
      const DataColumn(label: Expanded(child: Text('Peso a Desmama (Kg)'))),
      const DataColumn(label: Expanded(child: Text('IPP (Meses)'))),
      const DataColumn(label: Expanded(child: Text('# Tentativas')))
    ];

    return FutureBuilder<List<FemaleBreederStatistics>>(
      future: RelatoryService.getFemaleBreedersStatistics(widget.pageSize, widget.page),
      builder: (context, AsyncSnapshot<List<FemaleBreederStatistics>> snapshot) {
        late List<DataRow> rows;

        if (snapshot.connectionState != ConnectionState.done && !snapshot.hasData) {
          inspect("S1");
          rows = [];
        } else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasData) {
          inspect("S2");
          rows = [];
          inspect(snapshot.data);
        } else {
          inspect("S3");
          rows = _buildRows(snapshot.data!);
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SingleChildScrollView(child: DataTable(
              rows: rows,
              columns: columns,
              sortAscending: isAscending,
              sortColumnIndex: sortColumnIndex,
            ))
          ]
        );
      }
    );
  }

  List<DataRow> _buildRows(List<FemaleBreederStatistics> data) {
    int index = 0;
    return data.map((rowData) {
      Color? c = (index % 2) == 0 ? const Color.fromRGBO(201, 201, 201, 1.0) : null;
      index = index + 1;
      return DataRow(
        cells: [
          DataCell(Text(rowData.earring.toString())),
          DataCell(Text((rowData.weightBirth?.toStringAsFixed(2) ?? "-"))),
          DataCell(Text((rowData.weightWeaning?.toStringAsFixed(2) ?? "-"))),
          DataCell(Text((rowData.weightYearling?.toStringAsFixed(2) ?? "-"))),
          DataCell(Text((rowData.monthsAfterFirstBirth?.toString() ?? "-"))),
          DataCell(Text(rowData.countFailedReproductions?.toString() ?? "-"))
        ],
        color: WidgetStatePropertyAll<Color?>(c)
      );
    }).toList();
  }

  DataCell buildCell(String content) {
    return DataCell(Text(content));
  }
}
