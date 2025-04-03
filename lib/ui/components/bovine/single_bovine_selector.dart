import 'dart:developer'; // ignore: unused_import

import 'package:flutter/material.dart';

import 'package:integrazoo/ui/components/bovine/earring_controller.dart';


class SingleBovineSelector extends StatefulWidget {
  final EarringController earringController;

  const SingleBovineSelector({ super.key, required this.earringController });

  @override
  State<SingleBovineSelector> createState() => _SingleBovineSelector();
}

class _SingleBovineSelector extends State<SingleBovineSelector> {

  @override
  Widget build(BuildContext context) {
    const decoration = InputDecoration(
      border: OutlineInputBorder(),
      label: Text("Brinco"),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      hintText: "Digite o brinco do animal.",
    );

    return ListenableBuilder(
      listenable: widget.earringController,
      builder: (BuildContext context, Widget? child) {
        return Row(children: [
          Expanded(child: TextField(
            controller: widget.earringController.queryController,
            decoration: decoration,
            onChanged: (value) {
              int? e = int.tryParse(value);
              widget.earringController.setEarring(e);
            }
          )),
        ]);
      }
    );
  }
}
