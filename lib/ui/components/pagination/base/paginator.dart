import 'package:flutter/material.dart';

import 'package:integrazoo/ui/components.dart';


class Paginator extends StatefulWidget {
  final DataLoader loader;
  final List<int>? rowsPerPage;
  final Widget? filtersDialog;
  final String? queryHintText;
  final void Function(String)? onQueryChanged;
  final VoidCallback? onQueryEditingComplete;
  final VoidCallback? onSearchButtonPressed;
  final Widget Function(BuildContext) pageBuilder;

  const Paginator({
    super.key,
    required this.loader,
    required this.pageBuilder,
    this.filtersDialog,
    this.queryHintText,
    this.onQueryChanged,
    this.onQueryEditingComplete,
    this.onSearchButtonPressed,
    this.rowsPerPage,
  });

  @override
  State<Paginator> createState() => _Paginator();
}

class _Paginator extends State<Paginator> {

  @override
  void initState() {
    super.initState();
    widget.loader.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.loader,
      builder: (BuildContext context, Widget? child) {
      return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Padding(padding: EdgeInsets.only(top: 2.0, bottom: 2.0), child: Divider(color: Colors.transparent, height: 1)),
          if (widget.rowsPerPage != null && widget.rowsPerPage!.isNotEmpty)
            Card(child: DropdownMenu<int>(
              dropdownMenuEntries: widget.rowsPerPage!.map((value) => DropdownMenuEntry<int>(value: value, label: value.toString()))
                                                      .toList(),
              initialSelection: widget.rowsPerPage![0],
              onSelected: (value) {
                if (value != null) widget.loader.rowsPerPage = value;
              },
            )),
          Card(child: Row(children: [
            IconButton(onPressed: widget.loader.previousPage, icon: const Icon(Icons.arrow_left)),
            Text("${widget.loader.page + 1} / ${widget.loader.maxPages}"),
            IconButton(onPressed: widget.loader.nextPage, icon: const Icon(Icons.arrow_right)),
          ])),
          if (widget.onQueryChanged != null) ...[
            Expanded(child:  TextField(
              onChanged: widget.onQueryChanged,
              onEditingComplete: widget.onQueryEditingComplete,
              decoration: InputDecoration(hintText: widget.queryHintText)
            )),
            Card(child: IconButton(
              icon: const Icon(Icons.search),
              onPressed: widget.onSearchButtonPressed,
            )),
          ] else const Spacer(),
          if (widget.filtersDialog != null)
            Card(child: IconButton(
              icon: const Icon(Icons.filter_alt),
              onPressed: () => showDialog(context: context, builder: (context) => widget.filtersDialog!, barrierDismissible: false)
            )),
        ]),
        const Padding(padding: EdgeInsets.only(top: 2.0, bottom: 2.0), child: Divider(color: Colors.black, height: 1)),
        Expanded(child: widget.pageBuilder(context))
      ]);
    });
  }
}
