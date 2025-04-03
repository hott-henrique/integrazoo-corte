import 'dart:developer'; // ignore: unused_import

import 'package:flutter/material.dart';

import 'package:integrazoo/backend.dart';
import 'package:integrazoo/ui/components.dart';


class BovinesStatisticsPaginationView extends StatefulWidget {
  const BovinesStatisticsPaginationView({ super.key });

  @override
  State<BovinesStatisticsPaginationView> createState() => _BovinesStatisticsPaginationView();
}

class _BovinesStatisticsPaginationView extends State<BovinesStatisticsPaginationView> {
  late BovinesStatisticsDataLoader _dataSource;

  final search = BovinesSearchNotifier();

  @override
  void initState() {
    super.initState();

    _dataSource = BovinesStatisticsDataLoader();
  }

  @override
  Widget build(BuildContext context) {
    return Paginator(
      loader: _dataSource,
      filtersDialog: _buildFiltersDialog(),
      queryHintText: "Digite aqui para filtrar por nome ou brinco.",
      onQueryChanged: _dataSource.setQuery,
      onQueryEditingComplete: () => _dataSource.search.filter = search.search.filter,
      onSearchButtonPressed: () => _dataSource.search.filter = search.search.filter,
      rowsPerPage: const [ 5, 10, 15, 20],
      pageBuilder: buildTable,
    );
  }

  Widget buildTable(BuildContext context) {
    final columns = <DataColumn>[
      DataColumn(
        label: const Expanded(child: Text('Animal')),
        onSort: (idx, asc) => _dataSource.setOrderField(BovinesOrderField.earring, asc)
      ),
      DataColumn(
        label: const Expanded(child: Text('Peso ao Nascer (Kg)')),
        onSort: (idx, asc) => _dataSource.setOrderField(BovinesOrderField.birthWeight, asc)
      ),
      DataColumn(
        label: const Expanded(child: Text('Peso a Desmama (Kg)')),
        onSort: (idx, asc) => _dataSource.setOrderField(BovinesOrderField.weaningWeight, asc)
      ),
      DataColumn(
        label: const Expanded(child: Text('Peso ao Sobreano (Kg)')),
        onSort: (idx, asc) => _dataSource.setOrderField(BovinesOrderField.yearlingWeight, asc)
      ),
      DataColumn(
        label: const Expanded(child: Text('IPP (Meses)')),
        onSort: (idx, asc) => _dataSource.setOrderField(BovinesOrderField.ageFirstBirth, asc)
      ),
      DataColumn(
        label: const Expanded(child: Text('# Tentativas')),
        onSort: (idx, asc) => _dataSource.setOrderField(BovinesOrderField.recentFailedReproductionAttempts, asc)
      )
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

    return buildElement(s, showOffSring: true);
  }

  DataRow buildElement(BovineStatistics s, { bool showOffSring = false }) {
    return DataRow(
      cells: [
        DataCell(Text("${s.name ?? ''} #${s.earring.toString()}")),
        DataCell(Text((s.weightBirth?.toStringAsFixed(2) ?? "-"))),
        DataCell(Text((s.weightWeaning?.toStringAsFixed(2) ?? "-"))),
        DataCell(Text((s.weightYearling?.toStringAsFixed(2) ?? "-"))),
        DataCell(Text((s.monthsAfterFirstBirth?.toString() ?? "-"))),
        DataCell(Text(s.countFailedReproductions.toString()))
      ],
      onLongPress: () {
        if (showOffSring) {
          showDialog(
            context: context,
            builder: (context) => Dialog(child: buildOffspringInfo(s.earring))
          );
        }
      },
    );
  }

  Widget buildOffspringInfo(int earring) {
    final columns = <DataColumn>[
      const DataColumn(label: Expanded(child: Text('Animal'))),
      const DataColumn(label: Expanded(child: Text('Peso ao Sobreano (Kg)'))),
      const DataColumn(label: Expanded(child: Text('Peso ao Nascer (Kg)'))),
      const DataColumn(label: Expanded(child: Text('Peso a Desmama (Kg)'))),
      const DataColumn(label: Expanded(child: Text('IPP (Meses)'))),
      const DataColumn(label: Expanded(child: Text('# Tentativas')))
    ];

    return FutureBuilder<List<BovineStatistics>>(
      future: RelatoryService.getOffspringStatistics(earring),
      builder: (context, AsyncSnapshot<List<BovineStatistics>> snapshot) {
        late List<DataRow> rows;

        if (snapshot.connectionState != ConnectionState.done && !snapshot.hasData) {
          rows = [];
        } else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasData) {
          rows = [];
        } else {
          rows = snapshot.data!.map((el) => buildElement(el)).toList();
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DataTable(rows: rows, columns: columns),
            if (rows.isEmpty) const Text("Nenhum animal para mostrar.")
          ]
        );
      }
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

  Widget _buildFiltersDialog() {
    return ListenableBuilder(
      listenable: search,
      builder: (BuildContext context, Widget? child) {
        return Dialog(
          child: Padding(padding: const EdgeInsets.all(40.0), child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.end, children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    search.setFilterCopy(_dataSource.search.filter ?? BovinesFilter());
                    Navigator.of(context).pop();
                  }
                ),
              ]),
              buildFilterSelector<Sex?>(
                name: "Sexo",
                values: [ null, Sex.male, Sex.female ],
                labels: [ "Todos", "Apenas machos.", "Apenas fêmeas." ],
                value: search.search.filter?.sex,
                onChanged: search.setSex,
              ),
              buildFilterSelector<bool?>(
                name: "Reprodutor / Matriz",
                values: [ null, true, false ],
                labels: [ "Todos", "Apenas reprodutores/matrizes.", "Apenas não reprodutores/matrizes." ],
                value: search.search.filter?.isBreeder,
                onChanged: search.setIsBreeder,
              ),
              buildFilterSelector<bool?>(
                name: "Desmame",
                values: [ null, true, false ],
                labels: [ "Todos", "Apenas desmamados.", "Apenas não desmamados." ],
                value: search.search.filter?.hasBeenWeaned,
                onChanged: search.setHasBeenWeaned,
              ),
              if (search.search.filter?.sex == Sex.female) ...[
                buildFilterSelector<bool?>(
                  name: "Reprodução",
                  values: [ null, true, false ],
                  labels: [ "Todos", "Apenas reproduzindo.", "Apenas não reproduzindo." ],
                  value: search.search.filter?.isReproducing,
                  onChanged: search.setIsReproducing,
                ),
                buildFilterSelector<bool?>(
                  name: "Prenhes",
                  values: [ null, true, false ],
                  labels: [ "Todos", "Apenas prenhas.", "Apenas não prenhas." ],
                  value: search.search.filter?.isPregnant,
                  onChanged: search.setIsPregnant,
                ),
              ],
              buildFilterSelector<bool?>(
                name: "Descarte",
                values: [ null, true, false ],
                labels: [ "Todos", "Apenas descartados.", "Apenas não descartados." ],
                value: search.search.filter?.wasFinished,
                onChanged: search.setwasFinished,
              ),
              const Divider(height: 50, color: Colors.black),
              Row(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.end, children: [
                TextButton(
                  child: const Text("Aplicar"),
                  onPressed: () {
                    _dataSource.search = search.search;
                    Navigator.of(context).pop();
                  }
                ),
              ]),
            ])
          )
        );
      }
    );
  }
}
