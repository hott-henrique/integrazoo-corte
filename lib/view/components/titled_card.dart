import 'dart:developer';

import 'package:flutter/material.dart';


class TitledCard extends StatelessWidget {
  final String title;
  final Widget content;
  final List<String>? actions;
  final void Function(String)? onAction;
  final VoidCallback? onTitleClick;

  const TitledCard({ super.key, required this.title, required this.content, this.actions, this.onAction, this.onTitleClick });

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      shape: const RoundedRectangleBorder(side: BorderSide(width: 1)),
      child: Column(children: [
        Row(
          children: [
          Expanded(child: InkWell(
            onTap: onTitleClick,
            child: Text(title, textScaler: const TextScaler.linear(1.5), textAlign: TextAlign.center),
          )),
          if (actions != null && actions!.isNotEmpty)
            PopupMenuButton<String>(
              onSelected: onAction,
              itemBuilder: (BuildContext context) => actions!.map((action) =>
                PopupMenuItem<String>(
                  value: action,
                  child: Text(action),
                ),
              ).toList()
            ),
        ]),
        content,
      ])
    );
  }

}
