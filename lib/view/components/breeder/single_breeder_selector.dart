import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:integrazoo/database/database.dart';

import 'package:integrazoo/control/breeder_controller.dart';
import 'package:integrazoo/view/components/breeder/single_breeder_selector_controller.dart';

class SingleBreederSelector extends StatefulWidget {
  final SingleBreederSelectorController breederController;

  const SingleBreederSelector({super.key, required this.breederController});

  @override
  State<SingleBreederSelector> createState() => _SingleBreederSelector();
}

class _SingleBreederSelector extends State<SingleBreederSelector> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: widget.breederController,
        builder: (BuildContext context, Widget? child) {
          return buildDropdown();
        });
  }

  void loadMore() async {
    BreederController.searchBreeders(
      widget.breederController.queryController.text,
      widget.breederController.pageSize,
      widget.breederController.page,
    ).then((breeders_) => setState(() {
          widget.breederController.breeders.addAll(breeders_);
          if (breeders_.isEmpty) {
            widget.breederController.queryController.text = "";
          } else {
            widget.breederController.setPage(widget.breederController.page + 1);
          }
          widget.breederController.setHasTriedLoading(true);
        }));
  }

  Widget buildDropdown() {
    if (widget.breederController.breeders.isEmpty &&
        !widget.breederController.hasTriedLoading) {
      loadMore();
    }

    final scrollController = ScrollController();

    return Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: Column(
          spacing: 0,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Selecione o Reprodutor",
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
                    floatingLabelBehavior: FloatingLabelBehavior.always)),
            Card.outlined(
                elevation: 3,
                margin: EdgeInsets.zero,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
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
                                    children: widget.breederController
                                            .sorted()
                                            .isEmpty
                                        ? [
                                            const Padding(
                                              padding: EdgeInsets.all(16.0),
                                              child: SizedBox(
                                                width: double.infinity,
                                                child: Text(
                                                  "Nenhum reprodutor encontrado.",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.grey),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ]
                                        : widget.breederController
                                            .sorted()
                                            .map((Breeder b) => buildOption(b))
                                            .toList())))),
                    onNotification: (n) {
                      if (n is ScrollEndNotification) {
                        loadMore();
                      }
                      return true;
                    })),
          ],
        ));
  }

  Widget buildOption(Breeder b) {
    return Row(children: [
      Checkbox(
          value: b.name == widget.breederController.breeder,
          onChanged: (value) => (setState(() {
                if (value == null) return;

                if (value) {
                  setState(() {
                    widget.breederController.setBreeder(b.name);
                  });
                } else {
                  setState(() {
                    widget.breederController.setBreeder(null);
                  });
                }
              }))),
      Text(b.name)
    ]);
  }
}
