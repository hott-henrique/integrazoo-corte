import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:integrazoo/base.dart';
import 'package:integrazoo/control/relatory_controller.dart';


class FemaleBreedersRelatory extends StatefulWidget {
  final VoidCallback? postBackButtonClick;

  const FemaleBreedersRelatory({ super.key, this.postBackButtonClick });

  @override
  State<FemaleBreedersRelatory> createState() => _FemaleBreedersRelatory();
}

class _FemaleBreedersRelatory extends State<FemaleBreedersRelatory> {

  bool isAscending = true;
  int previousSortColumnIndex = 0;
  int sortColumnIndex = 1;

  @override
  Widget build(BuildContext context) {
    return IntegrazooBaseApp(
      title: "Matrizes",
      postBackButtonClick: widget.postBackButtonClick,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: buildTable()
      )
    );
  }

  List<DataRow> _buildRows(List<(String, double?, double?, double?, int?)> data) {
    return data.map((rowData) {
      return DataRow(
        cells: [
          DataCell(Text(rowData.$1)),
          DataCell(Text((rowData.$2?.toStringAsFixed(2) ?? "-"))),
          DataCell(Text((rowData.$3?.toStringAsFixed(2)?? "-"))),
          DataCell(Text((rowData.$4?.toStringAsFixed(2)?? "-"))),
          DataCell(Text((rowData.$5?.toString()?? "-")))
        ],
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
      DataColumn(label: const Expanded(child: Text('IPP (Meses)')), onSort: onSort)
    ];

    return FutureBuilder<List<dynamic>>(
      future: RelatoryController.getFemaleBreedersStatistics(10, 0),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        late List<DataRow> rows;

        if (snapshot.connectionState != ConnectionState.done && !snapshot.hasData) {
          rows = [];
        } else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasData) {
          rows = [];
        } else {
          final data = snapshot.data as List<(String, double?, double?, double?, int?)>;

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
            DataTable(rows: const [], columns: columns),
            Expanded(
              child: SingleChildScrollView(
                child: DataTable(
                  rows: rows,
                  sortAscending: isAscending,
                  sortColumnIndex: sortColumnIndex,
                  columns: List.generate(columns.length, (index) => const DataColumn(label: Text(''))),
                  headingRowHeight: 0
                )
              )
            )
          ]
        );
      }
    );
  }
}
