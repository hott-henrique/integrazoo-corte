import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:integrazoo/view/screens/bovines_in_treatment_list_view.dart';
import 'package:integrazoo/view/screens/bovines_pregnant_list_view.dart';
import 'package:integrazoo/view/screens/bovines_reproducing_list_view.dart';

import 'package:integrazoo/base.dart';


class HerdRelatory extends StatefulWidget {

  final VoidCallback? postBackButtonClick;

  const HerdRelatory({ super.key, this.postBackButtonClick });

  @override
  State<HerdRelatory> createState() => _HerdRelatory();
}

class _HerdRelatory extends State<HerdRelatory> {
  Exception? exception;

  @override
  Widget build(BuildContext context) {
    const tabs = DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(tabs: [ Tab(text: "Em Tratamento"), Tab(text: "Fêmeas Reproduzindo"), Tab(text: "Fêmeas Prenhas") ]),
          Expanded(child: TabBarView(children: [ BovinesInTreatmentListView(), BovinesReproducingListView(), BovinesPregnantListView() ])),
        ],
      ),
    );

    return IntegrazooBaseApp(
      title: "RESUMO REBANHO",
      postBackButtonClick: widget.postBackButtonClick,
      body: tabs
    );
  }
}
