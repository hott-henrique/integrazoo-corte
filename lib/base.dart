import 'package:flutter/material.dart';

import 'package:integrazoo/view/forms/bovine_form.dart';
import 'package:integrazoo/view/forms/finish_form.dart';
import 'package:integrazoo/view/forms/breeder_form.dart';
import 'package:integrazoo/view/forms/artificial_insemination_form.dart';
import 'package:integrazoo/view/forms/natural_mating_form.dart';
import 'package:integrazoo/view/forms/pregnancy_form.dart';
import 'package:integrazoo/view/forms/birth_form.dart';
import 'package:integrazoo/view/forms/weaning_form.dart';
import 'package:integrazoo/view/forms/treatment_form.dart';

import 'package:integrazoo/view/screens/relatories/female_breeders_relatory.dart';
import 'package:integrazoo/view/screens/relatories/herd_relatory.dart';

import 'package:integrazoo/view/screens/bovines_list_view.dart';
import 'package:integrazoo/view/screens/breeders_list_view.dart';
import 'package:integrazoo/view/screens/weanings_list_view.dart';
import 'package:integrazoo/view/screens/treatments_list_view.dart';
import 'package:integrazoo/view/screens/finishes_list_view.dart';


class IntegrazooBaseApp extends StatefulWidget {
  const IntegrazooBaseApp({ super.key });

  @override
  State<IntegrazooBaseApp> createState() => _IntegrazooBaseAppState();
}

class _IntegrazooBaseAppState extends State<IntegrazooBaseApp> {
  Widget body = const HerdRelatory();

  @override
  Widget build(BuildContext context) {
    Builder leadingBuilder = Builder(builder: (BuildContext context) {
      return IconButton(
        icon: const Icon(Icons.view_list, color: Colors.white),
        onPressed: () => Scaffold.of(context).openDrawer()
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("INTEGRAZOO", style: Theme.of(context).textTheme.titleLarge),
        backgroundColor: Colors.green,
        centerTitle: true,
        leading: leadingBuilder,
      ),
      body: body,
      drawer: Drawer(child: _createDrawerItems())
    );
  }

  ListView _createDrawerItems() {
    List<Widget> tiles = [
      Container(
        decoration: const BoxDecoration(color: Colors.green),
        child: const ListTile(
          title: Text('CULTURA', style: TextStyle(color: Colors.white)),
          subtitle: Text('Bovinocultura (Corte)', style: TextStyle(color: Colors.white)),
          dense: true,
          leading: CircleAvatar(backgroundColor: Colors.white, foregroundColor: Colors.green, child: Icon(Icons.source)),
        )
      ),
      ExpansionTile(
        title: const Text("Relatórios"),
        children: [
          ListTile(
            title: const Text("Desempenho das Matrizes"),
            onTap: () => setState(() => body = const FemaleBreedersRelatoryListView())
          ),
          ListTile(
            title: const Text("Rebanho"),
            onTap: () => setState(() => body = const HerdRelatory())
          ),
        ]
      ),
      ExpansionTile(
        title: const Text("Rebanho"),
        children: [
          ListTile(
            title: const Text("Registrar Animal"),
            onTap: () => setState(() => body = const BovineForm())
          ),
          ListTile(
            title: const Text("Visualizar Rebanho"),
            onTap: () => setState(() => body = const BovinesListView())
          )
        ]
      ),
      ExpansionTile(
        title: const Text("Reprodutores"),
        children: [
          ListTile(
            title: const Text("Registrar Reprodutor"),
            onTap: () => setState(() => body = const BreederForm())
          ),
          ListTile(
            title: const Text("Visualizar Reprodutores"),
            onTap: () => setState(() => body = const BreedersListView())
          )
        ]
      ),
      ExpansionTile(
        title: const Text("Desmame"),
        children: [
          ListTile(
            title: const Text("Registrar Desmame"),
            onTap: () => setState(() => body = const WeaningForm())
          ),
          ListTile(
            title: const Text("Visualizar Desmames"),
            onTap: () => setState(() => body = const WeaningsListView())
          )
        ]
      ),
      ExpansionTile(
        title: const Text("Reprodução"),
        children: [
          ListTile(
            title: const Text("Registrar Inseminações"),
            onTap: () => setState(() => body = const ArtificialInseminationForm())
          ),
          ListTile(
            title: const Text("Registrar Monta"),
            onTap: () => setState(() => body = const NaturalMatingForm())
          ),
          ListTile(
            title: const Text("Registrar Prenhe"),
            onTap: () => setState(() => body = const PregnancyForm())
          ),
          ListTile(
            title: const Text("Registrar Parto"),
            onTap: () => setState(() => body = const BirthForm())
          )
        ]
      ),
      ExpansionTile(
        title: const Text("Tratamento"),
        children: [
          ListTile(
            title: const Text("Registrar Tratamento"),
            onTap: () => setState(() => body = const TreatmentForm())
          ),
          ListTile(
            title: const Text("Visualizar Tratamentos"),
            onTap: () => setState(() => body = const TreatmentsListView())
          )
        ]
      ),
      ExpansionTile(
        title: const Text("Finalização"),
        children: [
          ListTile(
            title: const Text("Registrar Finalização"),
            onTap: () => setState(() => body = const FinishForm())
          ),
          ListTile(
            title: const Text("Visualizar Finalizações"),
            onTap: () => setState(() => body = const FinishesListView())
          )
        ]
      ),
    ];

    return ListView(children: tiles);
  }
}
