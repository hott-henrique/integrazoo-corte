import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:integrazoo/base.dart';

import 'package:integrazoo/view/screens/bovine_screen/components/birth_info_card.dart';
import 'package:integrazoo/view/screens/bovine_screen/components/bovine_info_card.dart';
import 'package:integrazoo/view/screens/bovine_screen/components/discard_info_card.dart';
import 'package:integrazoo/view/screens/bovine_screen/components/parents_info_card.dart';
import 'package:integrazoo/view/screens/bovine_screen/components/weaning_info_card.dart';


class BovineScreen extends StatefulWidget {
  final int earring;

  final VoidCallback? postBackButtonClick;

  const BovineScreen({ super.key, required this.earring, this.postBackButtonClick });

  @override
  State<BovineScreen> createState() => _BovineScreen();
}

class _BovineScreen extends State<BovineScreen> {
  Exception? exception;

  @override
  Widget build(BuildContext context) {
    List<Widget> columnBody = List.empty(growable: true);

    columnBody.add(BovineInfoCard(earring: widget.earring));
    columnBody.add(ParentsInfoCard(earring: widget.earring));
    columnBody.add(BirthInfoCard(earring: widget.earring));
    columnBody.add(WeaningInfoCard(earring: widget.earring));
    columnBody.add(DiscardInfoCard(earring: widget.earring));

    return IntegrazooBaseApp(
      title: "ANIMAL #${widget.earring}",
      postBackButtonClick: widget.postBackButtonClick,
      body: ListView(children: columnBody),
    );
  }
}
