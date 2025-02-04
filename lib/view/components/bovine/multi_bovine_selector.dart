import 'package:flutter/material.dart';

import 'package:integrazoo/database/database.dart';

import 'package:integrazoo/control/bovine_controller.dart';
import 'package:integrazoo/view/components/bovine/multi_earring_controller.dart';


class MultiBovineSelector extends StatefulWidget {
  final MultiEarringController earringsController;

  final Sex? sex;
  final bool? wasDiscarded;
  final bool? isReproducing;
  final bool? isPregnant;
  final bool? hasBeenWeaned;
  final String? label;
  final String? hintText;

  const MultiBovineSelector({
    super.key,
    required this.earringsController,
    this.sex,
    this.wasDiscarded,
    this.isReproducing,
    this.isPregnant,
    this.hasBeenWeaned,
    this.label,
    this.hintText,
  });

  @override
  State<MultiBovineSelector> createState() => _MultiBovineSelector();
}

class _MultiBovineSelector extends State<MultiBovineSelector> {
  int pageSize = 5, page = 0;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.earringsController,
      builder: (BuildContext context, Widget? child) {
        return buildDropdown();
      }
    );
  }

  void loadMore() async {
    BovineController.searchHerd(
      widget.earringsController.queryController.text,
      widget.earringsController.pageSize,
      widget.earringsController.page,
      widget.sex,
      widget.wasDiscarded,
      widget.isReproducing,
      widget.isPregnant,
      widget.hasBeenWeaned
    ).then(
      (cattle) => setState(() {
        widget.earringsController.bovines.addAll(cattle);
        if (cattle.isNotEmpty) {
          widget.earringsController.setPage(widget.earringsController.page + 1);
        }
        widget.earringsController.setHasTriedLoading(true);
      })
    );
  }

  Widget buildDropdown() {
    if (widget.earringsController.bovines.isEmpty && !widget.earringsController.hasTriedLoading) {
      loadMore();
    }

    final scrollController = ScrollController();

    return ExpansionTile(
      title: TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(border: const OutlineInputBorder(),
                                    label: Text(widget.label ?? "Pesquisar"),
                                    hintText: widget.hintText ?? "Digite o nome ou brinco do animal para pesquisar.",
                                    floatingLabelBehavior: FloatingLabelBehavior.always),
        controller: widget.earringsController.queryController,
        onEditingComplete: () => setState(() {
          widget.earringsController.setHasTriedLoading(false);
        })
      ),
      initiallyExpanded: true,
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
                child: Column(children: widget.earringsController.sorted().map((Bovine b) => buildOption(b)).toList())
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
      Checkbox(value: widget.earringsController.earrings.contains(b.earring), onChanged: (value) => (
        setState(() {
          if (value == null) return;

          if (value) {
            setState(() {
              widget.earringsController.addEarring(b.earring);
            });
          } else {
            setState(() {
              widget.earringsController.removeEarring(b.earring);
            });
          }
        })
      )),
      Text("${b.name ?? 'Sem Nome'} #${b.earring}")
    ]);
  }
}
