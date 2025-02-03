import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:integrazoo/base.dart';
import 'package:integrazoo/control/finish_controller.dart';

import 'package:integrazoo/view/components/unexpected_error_alert_dialog.dart';

import 'package:integrazoo/view/components/button.dart';

import 'package:integrazoo/control/bovine_controller.dart';

import 'package:integrazoo/database/database.dart';

class FinishesScreen extends StatefulWidget {
  const FinishesScreen({ super.key });

  @override
  State<FinishesScreen> createState() => _FinishesScreen();
}

class _FinishesScreen extends State<FinishesScreen> {
  Exception? exception;

  List<Bovine> bovines = List.empty(growable: true);

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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: NotificationListener<ScrollNotification>(
          child: buildBovineListView(),
          onNotification: (n) {
            if (n is ScrollEndNotification) {
              if (page < maxPages) {
                loadMore();
              }
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
      null,
      true,
      null,
      null,
      null
    ).then(
      (cattle) => setState(() { bovines.addAll(cattle); page = page + 1; })
    );
  }

  void redoSearch() {
    bovines.clear();
    page = 0;
    loadMore();
  }

  Widget buildBovineListView() {
    if (bovines.isEmpty) {
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

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0), // or any custom padding
          child: searchBar,
        ),
        const Divider(color: Colors.transparent),
        ...bovines.map((Bovine b) => buildCancelDiscardView(b))
      ]
    );
  }

  Widget buildCancelDiscardView(Bovine b) {
    return FutureBuilder<Finish?>(
      future: FinishController.getByEarring(b.earring),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Text("Loading...");
        }

        if (snapshot.connectionState == ConnectionState.done && !snapshot.hasData) {
          return Text("Erro: Não foi possível carregar dados de descarte do animal: ${b.earring}");
        }

        const ImageIcon cowHead = ImageIcon(AssetImage("assets/icons/cow-head.png"));
        const ImageIcon bullHead = ImageIcon(AssetImage("assets/icons/bull-head.png"));

        final discard = snapshot.data!;

        return Container(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: ListTile(
            title: Text("${b.name ?? ''} #${b.earring}"),
            subtitle: Text(discard.reason.toString()),
            leading: b.sex == Sex.male ? bullHead : cowHead,
            trailing: Button(
              color: Colors.red,
              text: "Cancelar",
              onPressed: () => showCancelDiscardDialog(b.earring)
            ),
            shape: const RoundedRectangleBorder(side: BorderSide(width: 1.0), borderRadius: BorderRadius.all(Radius.circular(6.0)))
          )
        );
      }
    );
  }

  void showCancelDiscardDialog(int earring) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Cancelar discarte do animal #$earring?"),
          actions: [
            Button(color: Colors.red, text: "Confirmar", onPressed: (){
              cancelDiscard(earring).then((_) {
                setState(() => bovines.removeWhere((element) => element.earring == earring));
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              });
            }),
          ]
        );
      }
    );
  }

  Future<void> cancelDiscard(int earring) {
    return FinishController.delete(earring);
  }
}
