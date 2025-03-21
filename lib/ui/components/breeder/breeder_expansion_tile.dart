import 'dart:developer'; // ignore: unused_import

import 'package:flutter/material.dart';

import 'package:integrazoo/backend.dart';


class BreederExpansionTile extends StatefulWidget {
  final Breeder breeder;

  const BreederExpansionTile({ super.key, required this.breeder });

  @override
  BreederExpansionTileState createState() {
    return BreederExpansionTileState();
  }
}

class BreederExpansionTileState extends State<BreederExpansionTile> {
  bool wasOpen = false;

  Future<List<dynamic>> get _childrenCountBySexFutures => Future.wait([
    BreederService.countChildrenOfSex(widget.breeder.name, Sex.female),
    BreederService.countChildrenOfSex(widget.breeder.name, Sex.male),
  ]);

  Future<List<dynamic>> get _weigthInfo => Future.wait([
    BreederService.getAverageBirthWeight(widget.breeder.name),
    BreederService.getAverageWeaningWeight(widget.breeder.name),
  ]);

  @override
  Widget build(BuildContext context) {
    const ImageIcon bullHead = ImageIcon(AssetImage("assets/icons/bull-head.png"));

    return ExpansionTile(
      title: Text(widget.breeder.name),
      leading: bullHead,
      onExpansionChanged: (value) => setState(() => wasOpen = value),
      expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
      children: [ Padding(padding: const EdgeInsets.all(4.0), child: buildResume()) ]
    );
  }

  Widget buildResume() {
    if (!wasOpen) {
      return Container();
    }

    List<Widget> info = [
      Row(children: [
        const Expanded(child: Text("Mãe:")),
        Text(widget.breeder.mother ?? "--")
      ]),
      Row(children: [
        const Expanded(child: Text("Pai:")),
        Text(widget.breeder.father ?? "--")
      ]),
      const Divider(),
      buildParentingInfo(),
      buildWeightInfo()
    ];

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: info);
  }

  Widget buildParentingInfo() {
    int? countMales, countFemales;
    return FutureBuilder<List<dynamic>>(
      future: _childrenCountBySexFutures,
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState != ConnectionState.done && !snapshot.hasData) {
          countMales = null;
          countFemales = null;
        } else {
          countFemales = snapshot.data![0] as int;
          countMales = snapshot.data![1] as int;
        }

        int? total;

        if (countMales != null && countFemales != null) {
          total = countMales! + countFemales!;
        }

        return Column(children: [
          Row(children: [
            const Expanded(child: Text("Quantidade Total de Crias:")),
            Text(countMales == null ? "--" : total.toString())
          ]),
          Row(children: [
            const Expanded(child: Text("\t\tMachos:")),
            Text(countMales == null ? "--" : countMales.toString())
          ]),
          Row(children: [
            const Expanded(child: Text("\t\tFemeas:")),
            Text(countFemales == null ? "--" : countFemales.toString())
          ]),
        ]);
      }
    );
  }

  Widget buildWeightInfo() {
    double? avgBirthWeight, avgWeaningWeight;
    return FutureBuilder<List<dynamic>>(
      future: _weigthInfo,
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState != ConnectionState.done && !snapshot.hasData) {
          avgBirthWeight = null;
          avgWeaningWeight = null;
        } else {
          avgBirthWeight = snapshot.data![0] as double;
          avgWeaningWeight = snapshot.data![1] as double;
        }

        return Column(children: [
          Row(children: [
            const Expanded(child: Text("\t\tPeso Médio ao Nascimento:")),
            Text("${avgBirthWeight == null ? "--" : avgBirthWeight.toString()} Kg")
          ]),
          Row(children: [
            const Expanded(child: Text("\t\tPeso Médio a Desmama:")),
            Text("${avgWeaningWeight == null ? "--" : avgWeaningWeight.toString()} Kg")
          ]),
        ]);
      }
    );
  }
}
