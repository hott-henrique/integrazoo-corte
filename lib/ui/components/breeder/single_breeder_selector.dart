import 'dart:developer'; // ignore: unused_import

import 'package:flutter/material.dart';

import 'package:integrazoo/backend.dart';

import 'package:integrazoo/ui/components/breeder/single_breeder_selector_controller.dart';


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
        return Autocomplete(
          initialValue: TextEditingValue(text: widget.breederController.breeder ?? ""),
          fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) =>
            TextFormField(
              controller: textEditingController,
              focusNode: focusNode,
              onFieldSubmitted: (value) {
                BreederService.getBreeder(value).then(
                  (e) {
                    if (e == null) {
                      textEditingController.clear();
                    } else {
                      onFieldSubmitted();
                    }
                  }
                );
              },
              onTapOutside: (_) {
                BreederService.getBreeder(textEditingController.text).then(
                  (e) {
                    if (e == null) {
                      textEditingController.clear();
                    } else {
                      onFieldSubmitted();
                    }
                  }
                );
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Reprodutor"),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintText: "Digite o nome do reprodutor.",
              ),
            ),
          optionsBuilder: (TextEditingValue textEditingValue) async {
            if (textEditingValue.text.isEmpty) {
              return const Iterable<String>.empty();
            }

            final breeders = await BreederService.searchBreeders(textEditingValue.text);

            return breeders.map((e) => e.name);
          },
          onSelected: widget.breederController.setBreeder
        );
      }
    );
  }
}
