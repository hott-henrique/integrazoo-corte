import 'dart:developer'; // ignore: unused_import

import 'package:flutter/material.dart';

import 'package:integrazoo/backend.dart';

import 'package:integrazoo/ui/components/breeder/single_breeder_selector_controller.dart';


class SingleBreederSelector extends StatefulWidget {
  final SingleBreederSelectorController breederService;

  const SingleBreederSelector({super.key, required this.breederService});

  @override
  State<SingleBreederSelector> createState() => _SingleBreederSelector();
}

class _SingleBreederSelector extends State<SingleBreederSelector> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: widget.breederService,
        builder: (BuildContext context, Widget? child) {
          return buildDropdown();
        });
  }

  void loadMore() async {
    BreederService.searchBreeders(
      widget.breederService.queryController.text,
      widget.breederService.pageSize,
      widget.breederService.page,
    ).then((breeders_) => setState(() {
          widget.breederService.breeders.addAll(breeders_);
          if (breeders_.isEmpty) {
            widget.breederService.queryController.text = "";
          } else {
            widget.breederService.setPage(widget.breederService.page + 1);
          }
          widget.breederService.setHasTriedLoading(true);
        }));
  }

  Widget buildDropdown() {
    if (widget.breederService.breeders.isEmpty &&
        !widget.breederService.hasTriedLoading) {
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
                                    children: widget.breederService
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
                                        : widget.breederService
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
          value: b.name == widget.breederService.breeder,
          onChanged: (value) => (setState(() {
                if (value == null) return;

                if (value) {
                  setState(() {
                    widget.breederService.setBreeder(b.name);
                  });
                } else {
                  setState(() {
                    widget.breederService.setBreeder(null);
                  });
                }
              }))),
      Text(b.name)
    ]);
  }
}
