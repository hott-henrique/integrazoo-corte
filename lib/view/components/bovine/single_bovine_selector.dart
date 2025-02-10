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
      }
    );
  }

  void loadMore() async {
    BovineController.searchHerd(
      widget.earringController.queryController.text,
      widget.earringController.pageSize, widget.earringController.page,
      widget.sex,
      widget.wasDiscarded,
      widget.isReproducing,
      widget.isPregnant,
      widget.hasBeenWeaned,
    ).then(
      (cattle) => setState(() {
        widget.earringController.bovines.addAll(cattle);
        widget.earringController.setPage(widget.earringController.page + 1);
        widget.earringController.setHasTriedLoading(true);
      })
    );
  }

  Widget buildDropdown() {
    if (widget.earringController.bovines.isEmpty && !widget.earringController.hasTriedLoading) {
      loadMore();
    }

    final scrollController = ScrollController();

    return ExpansionTile(
      initiallyExpanded: true,
      title: TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(border: const OutlineInputBorder(),
                                    label: Text(widget.label ?? "Pesquisar"),
                                    hintText: "Digite nome ou brinco do animal para pesquisar.",
                                    floatingLabelBehavior: FloatingLabelBehavior.always),
        controller: widget.earringController.queryController,
        onEditingComplete: () => setState(() {
          widget.earringController.setHasTriedLoading(false);
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
                child: Column(children: widget.earringController.sorted().map((Bovine b) => buildOption(b)).toList())
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

  Widget buildOption(Bovine b) {
    return Row(children: [
      Checkbox(
        value: b.earring == widget.earringController.earring,
        onChanged: (value) {
          setState(() {
            if (value == true) {
              widget.earringController.queryController.text = b.earring.toString();
              widget.earringController.setEarring(b.earring);
            } else if (value == false) {
              widget.earringController.queryController.text = "";
              widget.earringController.setEarring(null);
            }
          });
        }
      ),
      Text("${b.name ?? 'Sem Nome'} #${b.earring}")
    ]);
  }
}
