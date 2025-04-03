import 'package:flutter/material.dart';

import 'package:integrazoo/ui/components/bovine/multi_earring_controller.dart';


class MultiBovineSelector extends StatefulWidget {
  final MultiEarringController earringsController;

  const MultiBovineSelector({ super.key, required this.earringsController });

  @override
  State<MultiBovineSelector> createState() => _MultiBovineSelector();
}

class _MultiBovineSelector extends State<MultiBovineSelector> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return ListenableBuilder(
      listenable: widget.earringsController,
      builder: (BuildContext context, Widget? child) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          buildInputField(),
          Wrap(children: buildEarrings())
        ]);
      }
    );
  }

  List<Widget> buildEarrings() {
    return widget.earringsController.earrings.map((e) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Text(e.toString()),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => widget.earringsController.removeEarring(e)
            ),
          ])
        )
      );
    }).toList();
  }

  Widget buildInputField() {
    const decoration = InputDecoration(
      border: OutlineInputBorder(),
      label: Text("Brinco"),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      hintText: "Digite o brinco do animal.",
    );

    return Row(children: [
      Expanded(child: TextField(
        controller: widget.earringsController.queryController,
        decoration: decoration,
        focusNode: _focusNode,
        onSubmitted: (value) {
          int? e = int.tryParse(value);

          if (e != null) {
            widget.earringsController.addEarring(e);
          }

          widget.earringsController.queryController.clear();

          _focusNode.requestFocus();
        }
      )),
    ]);
  }
}
