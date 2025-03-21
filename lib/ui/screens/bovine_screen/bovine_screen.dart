import 'dart:developer'; // ignore: unused_import

import 'package:flutter/material.dart';

import 'package:integrazoo/ui/screens/bovine_screen/components/birth_info_card.dart';
import 'package:integrazoo/ui/screens/bovine_screen/components/bovine_info_card.dart';
import 'package:integrazoo/ui/screens/bovine_screen/components/finish_info_card.dart';
import 'package:integrazoo/ui/screens/bovine_screen/components/parents_info_card.dart';
import 'package:integrazoo/ui/screens/bovine_screen/components/weaning_info_card.dart';


class BovineScreen extends StatefulWidget {
  final int earring;

  final VoidCallback? postBackButtonClick;

  const BovineScreen({ super.key, required this.earring, this.postBackButtonClick });

  @override
  State<BovineScreen> createState() => _BovineScreen();
}

class _BovineScreen extends State<BovineScreen> {

  @override
  Widget build(BuildContext context) {
    List<Widget> columnBody = List.empty(growable: true);

    columnBody.add(BovineInfoCard(earring: widget.earring));
    columnBody.add(ParentsInfoCard(earring: widget.earring));
    columnBody.add(BirthInfoCard(earring: widget.earring));
    columnBody.add(WeaningInfoCard(earring: widget.earring));
    columnBody.add(FinishInfoCard(earring: widget.earring));

    return ListView(children: columnBody);
  }
}
