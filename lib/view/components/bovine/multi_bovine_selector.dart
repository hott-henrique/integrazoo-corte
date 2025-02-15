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
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.earringsController,
      builder: (BuildContext context, Widget? child) {
        return buildDropdown();
      });
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
      widget.hasBeenWeaned)
    .then((cattle) {
      widget.earringsController.bovines.addAll(cattle);
      if (cattle.isNotEmpty) {
        widget.earringsController.setPage(widget.earringsController.page + 1);
      }
      widget.earringsController.setHasTriedLoading(true);
    });
  }

  Widget buildDropdown() {
    if (widget.earringsController.bovines.isEmpty && !widget.earringsController.hasTriedLoading) {
      loadMore();
    }

    const emptyMessage = Padding(
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
    );

    final searchBar = TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        suffixIcon: const Icon(Icons.search, color: Colors.green),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 38, 109, 40), width: 2),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          )
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green, width: 1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          )
        ),
        hintText: widget.hintText ?? "Digite o nome ou brinco do animal para pesquisar.",
        floatingLabelBehavior: FloatingLabelBehavior.always
      ),
      controller: widget.earringsController.queryController,
      onEditingComplete: () {
        widget.earringsController.clear(shouldClearQuery: false);
        widget.earringsController.setHasTriedLoading(false);
      }
    );

    final scrollController = ScrollController();

    final bovinesCard = Card.outlined(
      elevation: 3,
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
        side: BorderSide(color: Colors.green, width: 1)
      ),
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
                widget.earringsController.bovines.isEmpty
                ? [ emptyMessage ]
                : widget.earringsController.sorted()
                .map((Bovine b) => buildOption(b))
                .toList(),
              )
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
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Selecione as vacas", style: Theme.of(context).textTheme.titleMedium),
          searchBar,
          bovinesCard,
        ],
      ));
  }

  Widget buildOption(Bovine b) {
    return Row(children: [
      Checkbox(
        value: widget.earringsController.earrings.contains(b.earring),
        onChanged: (value) => (setState(() {
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
        }))),
      Text("${b.name ?? 'Sem Nome'} #${b.earring}")
    ]);
  }
}
