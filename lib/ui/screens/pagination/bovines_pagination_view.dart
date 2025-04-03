import 'dart:developer'; // ignore: unused_import

import 'package:flutter/material.dart';

import 'package:integrazoo/backend.dart';
import 'package:integrazoo/ui/components.dart';


class BovinesPaginationView extends StatefulWidget {
  const BovinesPaginationView({ super.key });

  @override
  State<BovinesPaginationView> createState() => _BovinesPaginationView();
}

class _BovinesPaginationView extends State<BovinesPaginationView> {
  late BovinesDataLoader _dataSource;

  final search = BovinesSearchNotifier();

  @override
  void initState() {
    super.initState();

    _dataSource = BovinesDataLoader();
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
      rowsPerPage: const [ 5, 10, 15, 20, 25],
      pageBuilder: buildAnimals,
    );
  }

  Widget buildAnimals(BuildContext context) {
    return SingleChildScrollView(child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: List.generate(_dataSource.availableRows, buildIthElement),
    ));
  }

  Widget buildIthElement(int i) {
    if (_dataSource.isLoading) {
      return const ListTile(leading: CircularProgressIndicator());
    }
    final s = _dataSource.getElement(i);

    return BovineTile(bovine: s, postAction: _dataSource.reload);
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
                value: search.search.filter?.wasDiscarded,
                onChanged: search.setWasDiscarded,
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
