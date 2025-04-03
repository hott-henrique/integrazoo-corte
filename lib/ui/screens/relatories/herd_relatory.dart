import 'dart:developer'; // ignore: unused_import

import 'package:flutter/material.dart';

import 'package:integrazoo/ui/screens.dart';


class HerdRelatory extends StatefulWidget {

  final VoidCallback? postBackButtonClick;

  const HerdRelatory({ super.key, this.postBackButtonClick });

  @override
  State<HerdRelatory> createState() => _HerdRelatory();
}

class _HerdRelatory extends State<HerdRelatory> {

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(tabs: [ Tab(text: "Em Tratamento") ]),
          Expanded(child: TabBarView(children: [ BovinesInTreatmentListView() ])),
        ],
      ),
    );
  }
}
