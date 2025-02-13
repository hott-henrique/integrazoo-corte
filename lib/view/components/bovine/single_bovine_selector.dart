import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:integrazoo/database/database.dart';

import 'package:integrazoo/control/bovine_controller.dart';

import 'package:integrazoo/view/components/bovine/earring_controller.dart';

class SingleBovineSelector extends StatefulWidget {
  final EarringController earringController;

  // final TextEditingController earringController;
  final Sex? sex;
  final bool? wasDiscarded;
  final bool? isReproducing;
  final bool? isPregnant;
  final bool? hasBeenWeaned;
  final String? label;

  const SingleBovineSelector({
    super.key,
    required this.earringController,
    this.sex,
    this.wasDiscarded,
    this.isReproducing,
    this.isPregnant,
    this.hasBeenWeaned,
    this.label,
  });

  @override
  State<SingleBovineSelector> createState() => _SingleBovineSelector();
}

class _SingleBovineSelector extends State<SingleBovineSelector> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: widget.earringController,
        builder: (BuildContext context, Widget? child) {
          return buildDropdown();
        });
  }

  void loadMore() async {
    BovineController.searchHerd(
      widget.earringController.queryController.text,
      widget.earringController.pageSize,
      widget.earringController.page,
      widget.sex,
      widget.wasDiscarded,
      widget.isReproducing,
      widget.isPregnant,
      widget.hasBeenWeaned,
    ).then((cattle) => setState(() {
          widget.earringController.bovines.addAll(cattle);
          widget.earringController.setPage(widget.earringController.page + 1);
          widget.earringController.setHasTriedLoading(true);
        }));
  }

  Widget buildDropdown() {
    if (widget.earringController.bovines.isEmpty &&
        !widget.earringController.hasTriedLoading) {
      loadMore();
    }

    final scrollController = ScrollController();

    return Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: Column(
        // spacing: 0,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Selecione o animal",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            TextFormField(
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.search, color: Colors.green),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 38, 109, 40), width: 2),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        )),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green, width: 1),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        )),
                    hintText:
                        "Digite o nome ou brinco do animal para pesquisar.",
                    floatingLabelBehavior: FloatingLabelBehavior.always),
                controller: widget.earringController.queryController,
                onEditingComplete: () => setState(() {
                      widget.earringController.setHasTriedLoading(false);
                    })),
            Card.outlined(
                elevation: 3,
                margin: EdgeInsets.zero,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                    ),
                    side: BorderSide(color: Colors.green, width: 1)),
                child: NotificationListener<ScrollNotification>(
                    child: SizedBox(
                        height: 120,
                        child: Scrollbar(
                            thumbVisibility: true,
                            controller: scrollController,
                            child: SingleChildScrollView(
                                controller: scrollController,
                                child: Column(
                                  children:
                                      widget.earringController.sorted().isEmpty
                                          ? [
                                              const Padding(
                                                padding: EdgeInsets.all(16.0),
                                                child: SizedBox(
                                                  width: double.infinity,
                                                  child: Text(
                                                    "Nenhum animal encontrado.",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.grey),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                            ]
                                          : widget.earringController
                                              .sorted()
                                              .map((Bovine b) => buildOption(b))
                                              .toList(),
                                )))),
                    onNotification: (n) {
                      if (n is ScrollEndNotification) {
                        loadMore();
                      }
                      return true;
                    })),
          ],
        ));
  }

  Widget buildOption(Bovine b) {
    return Row(children: [
      Checkbox(
          value: b.earring == widget.earringController.earring,
          onChanged: (value) {
            setState(() {
              if (value == true) {
                widget.earringController.queryController.text =
                    b.earring.toString();
                widget.earringController.setEarring(b.earring);
              } else if (value == false) {
                widget.earringController.queryController.text = "";
                widget.earringController.setEarring(null);
              }
            });
          }),
      Text("${b.name ?? 'Sem Nome'} #${b.earring}")
    ]);
  }
}
