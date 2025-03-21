import 'dart:developer'; // ignore: unused_import

import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

import 'package:integrazoo/backend.dart';

import 'package:integrazoo/ui/screens/bovine_screen/bovine_screen.dart';


class BovineExpansionTile extends StatefulWidget {
  final int earring;
  final VoidCallback? postDelete;
  final VoidCallback? postBackButtonClick;

  const BovineExpansionTile({ super.key, required this.earring, this.postDelete, this.postBackButtonClick });

  @override
  BovineExpansionTileState createState() {
    return BovineExpansionTileState();
  }
}

class BovineExpansionTileState extends State<BovineExpansionTile> {
  Future<Bovine?> get _bovineFuture => BovineService.getBovine(widget.earring);
  Future<Birth?> get _birthFuture => BirthService.getBirth(widget.earring);
  Future<Weaning?> get _weaningFuture => WeaningService.getWeaning(widget.earring);
  Future<Finish?> get _finishFuture => FinishService.getByEarring(widget.earring);
  Future<Reproduction?> get _reproductionFuture => ReproductionService.getReproductionThatGeneratedAnimal(widget.earring);
  Future<Pregnancy?> get _firstPregnancy => BirthService.getCowFirstBirth(widget.earring);

  Future<List<dynamic>> get _childrenCountBySexFutures => Future.wait([
    BovineService.countChildrenOfSex(widget.earring, Sex.female),
    BovineService.countChildrenOfSex(widget.earring, Sex.male),
  ]);

  @override
  Widget build(BuildContext context) {
    const ImageIcon cowHead = ImageIcon(AssetImage("assets/icons/cow-head.png"));
    const ImageIcon bullHead = ImageIcon(AssetImage("assets/icons/bull-head.png"));

    return FutureBuilder<Bovine?>(
      future: _bovineFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const ExpansionTile(title: Text("Carregando...", style: TextStyle(fontStyle: FontStyle.italic)));
        }

        if (snapshot.connectionState == ConnectionState.done && !snapshot.hasData) {
          return const ExpansionTile(title: Text("Falha ao carrega animal.", style: TextStyle(fontStyle: FontStyle.italic)));
        }

        Bovine bovine = snapshot.data!;

        late String visibleName;

        if (bovine.name == null || (bovine.name != null && bovine.name!.isEmpty)) {
          visibleName = "${bovine.sex.toString()} #${bovine.earring}";
        } else {
          visibleName = "${bovine.name!} #${bovine.earring}";
        }

        return ExpansionTile(
          title: Text(visibleName),
          subtitle: getBirthdayInfo(),
          leading: bovine.sex == Sex.male ? bullHead : cowHead,
          expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
          children: [ Padding(padding: const EdgeInsets.all(4.0), child: getResume(bovine)) ],
        );
      }
    );
  }

  Widget getResume(Bovine b) {
    List<Widget> info = [
      getParentInfo(),
      getBirthWeightInfo(),
      getWeaningWeightInfo(),
      getDiscardWeightInfo(),
      getWeightGainInfo(),
      buildParentingInfo(),
      // if (b.sex == Sex.female)
      //   buildFirstPregnancyWithBirth(),
      TextButton(
        onPressed: () => Navigator.of(context)
                                  .push(
                                    MaterialPageRoute(builder: (context) => BovineScreen(
                                      earring: b.earring,
                                      postBackButtonClick: widget.postBackButtonClick
                                    ))
                                  ),
        child: const Text("DETALHES"),
      ),
      const Divider(height: 1.5, color: Colors.transparent),
      TextButton(
        onPressed: () {
          showDialog(context: context, builder: (context) {
            return AlertDialog(
              title: const Text('Você deseja mesmo deletar esse animal?'),
              actions: <Widget>[
                TextButton(child: const Text("Confirmar"), onPressed: () {
                  BovineService.deleteBovine(widget.earring);
                  Navigator.of(context).pop();
                }),
                TextButton(child: const Text("Cancelar"), onPressed: () => Navigator.of(context).pop())
              ],
              actionsAlignment: MainAxisAlignment.center
            );
          }).then((_) {
            if (widget.postDelete != null) {
              widget.postDelete!();
            }
          });
        },
        child: const Text("DELETAR"),
      ),
    ];

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: info);
  }

  Widget getBirthdayInfo() {
    return FutureBuilder<Birth?>(
      future: _birthFuture,
      builder: (context, AsyncSnapshot<Birth?> snapshot) {
        if (snapshot.connectionState != ConnectionState.done && !snapshot.hasData) {
          return const Text("Carregando...", style: TextStyle(fontStyle: FontStyle.italic), textAlign: TextAlign.center);
        } else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasData) {
          return const Text("Data de Nascimento: --/--/--");
        } else {
          final birth = snapshot.data!;
          return Text('Data de Nascimento: ${DateFormat.yMd("pt_BR").format(birth.date)}');
        }
      }
    );
  }

  Widget getBirthWeightInfo() {
    return FutureBuilder<Birth?>(
      future: _birthFuture,
      builder: (context, AsyncSnapshot<Birth?> snapshot) {
        if (snapshot.connectionState != ConnectionState.done && !snapshot.hasData) {
          return const Text("Carregando...", style: TextStyle(fontStyle: FontStyle.italic), textAlign: TextAlign.center);
        } else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasData) {
          return const Row(children: [ Expanded(child: Text("Peso ao Nascimento:")), Text("-- kg") ]);
        } else {
          final birth = snapshot.data!;
          return Row(children: [ const Expanded(child: Text("Peso ao Nascimento:")), Text("${birth.weight} kg") ]);
        }
      }
    );
  }

  Widget getWeaningWeightInfo() {
    return FutureBuilder<Weaning?>(
      future: _weaningFuture,
      builder: (context, AsyncSnapshot<Weaning?> snapshot) {
        if (snapshot.connectionState != ConnectionState.done && !snapshot.hasData) {
          return const Text("Carregando...", style: TextStyle(fontStyle: FontStyle.italic), textAlign: TextAlign.center);
        } else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasData) {
          return const Row(children: [ Expanded(child: Text("Peso a Desmama:")), Text("-- kg") ]);
        } else {
          final weaning = snapshot.data!;
          return Row(children: [ const Expanded(child: Text("Peso a Desmama:")), Text("${weaning.weight} kg") ]);
        }
      }
    );
  }

  Widget getDiscardWeightInfo() {
    return FutureBuilder<Finish?>(
      future: _finishFuture,
      builder: (context, AsyncSnapshot<Finish?> snapshot) {
        if (snapshot.connectionState != ConnectionState.done && !snapshot.hasData) {
          return const Text("Carregando...", style: TextStyle(fontStyle: FontStyle.italic), textAlign: TextAlign.center);
        } else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasData) {
          return const SizedBox.shrink();
        } else {
          final finish = snapshot.data!;

          if (finish.reason == FinishingReason.slaughter) {
            return Column(children: [
              Row(children: [ const Expanded(child: Text("Finalização:")), Text(finish.reason.toString()) ]),
              Row(children: [ const Expanded(child: Text("\t\tPeso Animal:")), Text(finish.weight!.toString()) ]),
              Row(children: [ const Expanded(child: Text("\t\tPeso Carcaça Quente:")), Text(finish.hotCarcassWeight!.toString()) ]),
            ]);
          } else {
            return Row(children: [ const Expanded(child: Text("Finalização:")), Text(finish.reason.toString()) ]);
          }
        }
      }
    );
  }

  Widget getParentInfo() {
    return FutureBuilder<Reproduction?>(
      future: _reproductionFuture,
      builder: (context, AsyncSnapshot<Reproduction?> snapshot) {
        if (snapshot.connectionState != ConnectionState.done && !snapshot.hasData) {
          return const Text("Carregando...", style: TextStyle(fontStyle: FontStyle.italic), textAlign: TextAlign.center);
        } else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasData) {
          return const Column(children: [
            Row(children: [ Expanded(child: Text("Mãe:")), Text("--") ]),
            Row(children: [ Expanded(child: Text("Pai:")), Text("--") ]),
          ]);
        } else {
          final reproduction = snapshot.data!;
          final father = reproduction.bull != null ? '#${reproduction.bull}' : reproduction.breeder;
          return Column(children: [
            Row(children: [
              const Expanded(child: Text("Mãe:")),
              Text("#${reproduction.cow}")
            ]),
            Row(children: [
              const Expanded(child: Text("Pai:")),
              Text(father ?? "ERRO: Pai não identificado.")
            ]),
          ]);
        }
      }
    );
  }

  Widget getWeightGainInfo() {
    return FutureBuilder<List<dynamic>>(
      future: Future.wait([ _birthFuture, _weaningFuture, _finishFuture ]),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState != ConnectionState.done && !snapshot.hasData) {
          return const Text("Carregando...", style: TextStyle(fontStyle: FontStyle.italic), textAlign: TextAlign.center);
        } else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasData) {
          return const Row(children: [ Expanded(child: Text("GPM:")), Text("-- kg/dia") ]);
        } else {
          final birth = snapshot.data![0] as Birth?;
          final weaning = snapshot.data![1] as Weaning?;
          final finish = snapshot.data![2] as Finish?;

          if (birth == null) {
            return const Row(children: [ Expanded(child: Text("GPM:")), Text("-- kg/dia") ]);
          }

          if (finish != null && finish.weight != null) {
            int deltaT = finish.date.difference(birth.date).inDays;
            if (deltaT == 0) {
              deltaT = 1;
            }
            double gain = finish.weight! - birth.weight;
            double gainPerDay = gain / deltaT;
            return Row(children: [ const Expanded(child: Text("GPM")), Text("${gainPerDay.toStringAsFixed(2)} kg/dia") ]);
          }

          if (weaning != null) {
            int deltaT = weaning.date.difference(birth.date).inDays;
            if (deltaT == 0) {
              deltaT = 1;
            }
            double gain = weaning.weight - birth.weight;
            double gainPerDay = gain / deltaT;
            return Row(children: [ const Expanded(child: Text("GPMt")), Text("${gainPerDay.toStringAsFixed(2)} kg/dia") ]);
          }

          return const Row(children: [ Expanded(child: Text("GPM:")), Text("-- kg/dia") ]);
        }
      }
    );
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

  Widget buildFirstPregnancyWithBirth() {
    // TODO: Substituir por idade ao primeiro parto.
    return FutureBuilder<List<dynamic>>(
      future: birthAndPregnancyFutures(),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState != ConnectionState.done && !snapshot.hasData) {
          return const Text("Carregando...", style: TextStyle(fontStyle: FontStyle.italic), textAlign: TextAlign.center);
        } else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasData) {
          return const Row(children: [ Expanded(child: Text("Primeira Cria:")), Text("--") ]);
        } else {
          final birth = snapshot.data![0] as Birth?;
          final pregnancy = snapshot.data![1] as Pregnancy?;

          if (pregnancy == null) {
            return const Row(children: [ Expanded(child: Text("Primeira Cria:")), Text("--") ]);
          }

          if (birth == null) {
            return Column(children: [
              Row(children: [
                const Expanded(child: Text("Data Primeira Cria:")),
                Text(DateFormat.yMd("pt_BR").format(pregnancy.date))
              ]),
            ]);
          }

          Duration delta = pregnancy.date.difference(birth.date);
          String t = "Ano(s)";
          int age = (delta.inDays / 365).round();

          if (delta.inDays < 365) {
            age = (delta.inDays / 30).round();
            if (age == 1) {
              t = "Mês";
            } else {
              t = "Meses";
            }
          }

          return Column(children: [
            Row(children: [
              const Expanded(child: Text("Idade a Primeira Cria:")),
              Text("$age $t")
            ]),
          ]);
        }
      }
    );
  }

  Future<List<dynamic>> birthAndPregnancyFutures() async {
    return Future.wait([ _birthFuture, _firstPregnancy ]);
  }
}
