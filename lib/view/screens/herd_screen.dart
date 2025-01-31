import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:integrazoo/base.dart';

import 'package:integrazoo/view/components/bovine/bovine_expansion_tile.dart';
import 'package:integrazoo/view/components/unexpected_error_alert_dialog.dart';

import 'package:integrazoo/view/components/button.dart';

import 'package:integrazoo/control/bovine_controller.dart';

import 'package:integrazoo/database/database.dart';

enum DiscardFiltering {
  ignore, wasDiscarded, wasNotDiscarded;

  @override
  String toString() {
    switch (this) {
      case DiscardFiltering.wasDiscarded:
        return "Descartados";

      case DiscardFiltering.wasNotDiscarded:
        return "Não Descartados";

      case DiscardFiltering.ignore:
        return "Todos";
    }
  }

  bool? asBoolean() {
    switch (this) {
      case DiscardFiltering.wasDiscarded:
        return true;

      case DiscardFiltering.wasNotDiscarded:
        return false;

      case DiscardFiltering.ignore:
        return null;
    }
  }
}

class HerdScreen extends StatefulWidget {
  const HerdScreen({ super.key });

  @override
  State<HerdScreen> createState() => _HerdScreen();
}

class _HerdScreen extends State<HerdScreen> {
  Exception? exception;

  List<Bovine> bovines = List.empty(growable: true);

  bool hasTriedLoading = false;
  Sex? sex;
  SearchSorting sortingMethod = SearchSorting.sortByEarring;
  DiscardFiltering discardFiltering = DiscardFiltering.ignore;
  final queryController = TextEditingController();
  int page = 0, pageSize = 100, maxPages = 1;

  @override
  Widget build(BuildContext context) {
    if (exception != null) {
      return UnexpectedErrorAlertDialog(title: 'Erro Inesperado',
                                        message: 'Algo de inespearado aconteceu durante a execução do aplicativo.',
                                        onPressed: () => setState(() => exception = null));
    }

    return IntegrazooBaseApp(
      title: "REBANHO",
      showBackButton: false,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: NotificationListener<ScrollNotification>(
          child: buildBovineListView(),
          onNotification: (n) {
            if (n is ScrollEndNotification && page < maxPages) {
              loadMore();
            }
            return true;
          }
        )
      )
    );
  }

  void loadMore() {
    BovineController.searchHerd(
      queryController.text,
      pageSize, page,
      sex,
      discardFiltering.asBoolean(),
      null,
      null,
      null,
      sortingOrder: sortingMethod
    ).then(
      (cattle) => setState(() {
        bovines.addAll(cattle);
        page = page + 1;
        hasTriedLoading = true;
      })
    );
  }

  void redoSearch() {
    bovines.clear();
    page = 0;
    loadMore();
  }

  Widget buildBovineListView() {
    if (bovines.isEmpty && !hasTriedLoading) {
      loadMore();
    }

    final searchBar = TextFormField(
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(border: OutlineInputBorder(),
                                        label: Text("Pesquisar"),
                                        floatingLabelBehavior: FloatingLabelBehavior.auto),
      controller: queryController,
      onEditingComplete: () => setState(() => redoSearch())
    );

    final settingsIcon = IconButton(
      icon: const Icon(Icons.more_vert),
      onPressed: () => (
        showDialog(context: context, builder: (context) {
          return AlertDialog(
            title: const Text('Configurações de Pesquisa'),
            content: buildFiltersSelection(),
            actions: <Widget>[
              Button(color: Colors.blue, text: "Confirmar", onPressed: () => Navigator.of(context).pop())
            ],
            actionsAlignment: MainAxisAlignment.center
          );
        }).then((_) => redoSearch())
      )
    );

    return ListView(children: [
      Row(children: [
        Flexible(flex: 390, child: searchBar),
        const Spacer(),
        Flexible(flex: 10, child: settingsIcon)
      ]),
      const Divider(color: Colors.transparent),
      ...(
        bovines.map((Bovine b) => BovineExpansionTile(
          earring: b.earring,
          postDelete: redoSearch,
          postBackButtonClick: redoSearch,
        )).toList()
      )
    ]);
  }

  Widget buildFiltersSelection() {
    final sexDropdown = DropdownMenu<Sex?>(
      label: const Text("Sexo"),
      initialSelection: sex,
      dropdownMenuEntries: [
        const DropdownMenuEntry(value: null, label: "Todos"),
        ...Sex.values.map((sex) => DropdownMenuEntry(value: sex, label: sex.toString())),
      ],
      onSelected: (value) => sex = value,
      expandedInsets: EdgeInsets.zero,
      enableSearch: false
    );

    final sortingDropdown = DropdownMenu<SearchSorting?>(
      label: const Text("Ordenação"),
      initialSelection: sortingMethod,
      dropdownMenuEntries: SearchSorting.values.map((sm) => DropdownMenuEntry(value: sm, label: sm.toString())).toList(),
      onSelected: (value) => sortingMethod = value!,
      expandedInsets: EdgeInsets.zero,
      enableSearch: false
    );

    final discardDropdown = DropdownMenu<DiscardFiltering>(
      label: const Text("Descarte"),
      initialSelection: discardFiltering,
      dropdownMenuEntries: DiscardFiltering.values.map((sm) => DropdownMenuEntry(value: sm, label: sm.toString())).toList(),
      onSelected: (value) {
        if (value == null) {
          return;
        }
        discardFiltering = value;
      },
      expandedInsets: EdgeInsets.zero,
      enableSearch: false
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text("Filtros", textAlign: TextAlign.left, textScaler: TextScaler.linear(1.5)),
        sexDropdown,
        const Divider(color: Colors.transparent),
        discardDropdown,
        const Text("Ordenação", textAlign: TextAlign.left, textScaler: TextScaler.linear(1.5)),
        sortingDropdown,
      ]
    );
  }
}
