import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:integrazoo/base.dart';

import 'package:integrazoo/view/components/breeder/breeder_expansion_tile.dart';
import 'package:integrazoo/view/components/unexpected_error_alert_dialog.dart';

import 'package:integrazoo/control/breeder_controller.dart';

import 'package:integrazoo/database/database.dart';


class BreedersScreen extends StatefulWidget {
  const BreedersScreen({ super.key });

  @override
  State<BreedersScreen> createState() => _BreedersScreen();
}

class _BreedersScreen extends State<BreedersScreen> {
  Exception? exception;

  List<Widget> widgets = List.empty(growable: true);

  final queryController = TextEditingController();
  int page = 0, pageSize = 10;

  @override
  Widget build(BuildContext context) {
    if (exception != null) {
      return UnexpectedErrorAlertDialog(title: 'Erro Inesperado',
                                        message: 'Algo de inespearado aconteceu durante a execução do aplicativo.',
                                        onPressed: () => setState(() => exception = null));
    }
    return IntegrazooBaseApp(
      title: "REPRODUTORES",
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: NotificationListener<ScrollNotification>(
          child: buildBreederListView(),
          onNotification: (n) {
            if (n is ScrollEndNotification) {
              setState(() => ( page = page + 1 ));
            }
            return true;
          }
        )
      )
    );
  }

  void loadMore() {
    BreederController.searchBreeders(queryController.text, pageSize, page).then(
      (breeders) {
        if (breeders.isNotEmpty) {
          setState(() => widgets.addAll(breeders.map((Breeder b) => BreederExpansionTile(breeder: b)).toList()));
        }
      }
    );

    page = page + 1;
  }

  Widget buildBreederListView() {
    if (widgets.isEmpty) {
      loadMore();
    }

    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          keyboardType: TextInputType.text,
          controller: queryController,
          decoration: const InputDecoration(border: OutlineInputBorder(),
                                            label: Text("Pesquisar"),
                                            floatingLabelBehavior: FloatingLabelBehavior.auto),
          onEditingComplete: () => setState(() {
            widgets.clear();
            page = 0;
          })
        ),
      ),
      ...widgets,
      const Expanded(child: Divider(height: 8, color: Colors.transparent)),
    ]);
  }
  /* Icons:
   *   Cow <a href="https://www.flaticon.com/free-icons/cow" title="cow icons">Cow icons created by kerismaker - Flaticon</a>
   *   Bull <a href="https://www.flaticon.com/free-icons/thorn" title="thorn icons">Thorn icons created by berkahicon - Flaticon</a>
   */
}
