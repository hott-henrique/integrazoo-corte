import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:integrazoo/database/database.dart';

import 'package:integrazoo/control/breeder_controller.dart';
import 'package:integrazoo/view/components/breeder/single_breeder_selector_controller.dart';


class SingleBreederSelector extends StatefulWidget {
  final SingleBreederSelectorController breederController;

  const SingleBreederSelector({ super.key, required this.breederController });

  @override
  State<SingleBreederSelector> createState() => _SingleBreederSelector();
}

class _SingleBreederSelector extends State<SingleBreederSelector> {
  Exception? exception;


  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.breederController,
      builder: (BuildContext context, Widget? child) {
        return buildDropdown();
      }
    );
  }

  void loadMore() async {
    BreederController.searchBreeders(
      widget.breederController.queryController.text,
      widget.breederController.pageSize,
      widget.breederController.page,
    ).then(
      (breeders_) => setState(() {
        widget.breederController.breeders.addAll(breeders_);
        if (breeders_.isEmpty) {
          widget.breederController.queryController.text = "";
        } else {
          widget.breederController.setPage(widget.breederController.page + 1);
        }
        widget.breederController.setHasTriedLoading(true);
      })
    );
  }

  Widget buildDropdown() {
    if (widget.breederController.breeders.isEmpty && !widget.breederController.hasTriedLoading) {
      loadMore();
    }

    final scrollController = ScrollController();

    return ExpansionTile(
      initiallyExpanded: true,
      title: TextFormField(
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(border: OutlineInputBorder(),
                                          label: Text("Reprodutor"),
                                          hintText: "Digite o nome do reprodutor para pesquisar.",
                                          floatingLabelBehavior: FloatingLabelBehavior.always),
        controller: widget.breederController.queryController,
        onEditingComplete: () => setState(() {
          widget.breederController.setHasTriedLoading(false);
        })
      ),
      children: [ Card.outlined(
        shape: const RoundedRectangleBorder(side: BorderSide(width: 1)),
        child: NotificationListener<ScrollNotification>(
          child:  SizedBox(
            height: 100,
            child: Scrollbar(
              thumbVisibility: true,
              controller: scrollController,
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(children: widget.breederController.sorted().map((Breeder b) => buildOption(b)).toList())
              )
            )
          ),
          onNotification: (n) {
            if (n is ScrollEndNotification) {
              loadMore();
            }
            return true;
          }
        )
      ) ]
    );
  }

  Widget buildOption(Breeder b) {
    return Row(children: [
      Checkbox(value: b.name == widget.breederController.breeder, onChanged: (value) => (
        setState(() {
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
        })
      )),
      Text(b.name)
    ]);
  }
}
