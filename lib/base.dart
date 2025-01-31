import 'package:flutter/material.dart';

import 'package:integrazoo/view/forms/create/bovine_form.dart';
import 'package:integrazoo/view/forms/create/bovine_discard_form.dart';
import 'package:integrazoo/view/forms/create/breeder_form.dart';
import 'package:integrazoo/view/forms/create/artificial_insemination_form.dart';
import 'package:integrazoo/view/forms/create/natural_mating_form.dart';
import 'package:integrazoo/view/forms/create/pregnancy_form.dart';
import 'package:integrazoo/view/forms/create/birth_form.dart';
import 'package:integrazoo/view/forms/create/weaning_form.dart';
import 'package:integrazoo/view/forms/create/treatment_form.dart';

import 'package:integrazoo/view/screens/herd_screen.dart';
import 'package:integrazoo/view/screens/breeders_screen.dart';
import 'package:integrazoo/view/screens/discards_screen.dart';

import 'package:integrazoo/view/screens/relatories/female_breeders_relatory.dart';
import 'package:integrazoo/view/screens/relatories/herd_relatory.dart';


class IntegrazooBaseApp extends StatefulWidget {
  final Widget body;
  final String? title;
  final bool showBackButton;
  final VoidCallback? postBackButtonClick;

  const IntegrazooBaseApp({super.key, required this.body, this.title, this.showBackButton = true, this.postBackButtonClick});

  @override
  State<IntegrazooBaseApp> createState() => _IntegrazooBaseAppState();
}

class _IntegrazooBaseAppState extends State<IntegrazooBaseApp> {
  @override
  Widget build(BuildContext context) {
    Builder leadingBuilder = Builder(builder: (BuildContext context) {
      return IconButton(
        icon: const Icon(Icons.view_list, color: Colors.white),
        onPressed: () => Scaffold.of(context).openDrawer()
      );
    });

    String subtitle = widget.title == null ? "" : "- ${widget.title}";

    return Scaffold(
      appBar: AppBar(
        title: Text("INTEGRAZOO $subtitle", style: Theme.of(context).textTheme.titleLarge),
        backgroundColor: Colors.green,
        centerTitle: true,
        leading: leadingBuilder,
        actions: [
          if (Navigator.canPop(context) && widget.showBackButton)
            BackButton(
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).pop();
                if (widget.postBackButtonClick != null) {
                  widget.postBackButtonClick!();
                }
              }
            ),
        ]
      ),
      body: widget.body,
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
        title: const Text("Analises"),
        children: [
          ListTile(
            title: const Text("Matrizes"),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.of(context)
                       .push(MaterialPageRoute(builder: (context) => const FemaleBreedersRelatory()));
            }
          ),
          ListTile(
            title: const Text("Rebanho"),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.of(context)
                       .push(MaterialPageRoute(builder: (context) => const HerdRelatory()));
            }
          ),
        ]
      ),
      ExpansionTile(
        title: const Text("Rebanho"),
        children: [
          ListTile(
            title: const Text("Registrar Animal"),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.of(context)
                       .push(MaterialPageRoute(builder: (context) => const BovineForm()));
            }
          ),
          ListTile(
            title: const Text("Visualizar Rebanho"),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.of(context)
                       .push(MaterialPageRoute(builder: (context) => const HerdScreen()));
            }
          ),
        ]
      ),
      ExpansionTile(
        title: const Text("Reprodutores"),
        children: [
          ListTile(
            title: const Text("Registrar Reprodutor"),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.of(context)
                       .push(MaterialPageRoute(builder: (context) => const BreederForm()));
            }
          ),
          ListTile(
            title: const Text("Visualizar Reprodutores"),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.of(context)
                       .push(MaterialPageRoute(builder: (context) => const BreedersScreen()));
            }
          )
        ]
      ),
      ExpansionTile(
        title: const Text("Descarte"),
        children: [
          ListTile(
            title: const Text("Registrar Descarte"),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.of(context)
                       .push(MaterialPageRoute(builder: (context) => const BovineDiscardForm()));
            }
          ),
          ListTile(
            title: const Text("Visualizar Descartes"),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.of(context)
                       .push(MaterialPageRoute(builder: (context) => const DiscardsScreen()));
            }
          )
        ]
      ),
      ExpansionTile(
        title: const Text("Reprodução"),
        children: [
          ListTile(
            title: const Text("Registrar Inseminação Artificial"),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.of(context)
                       .push(MaterialPageRoute(builder: (context) => const ArtificialInseminationForm()));
            }
          ),
          ListTile(
            title: const Text("Registrar Cobertura"),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.of(context)
                       .push(MaterialPageRoute(builder: (context) => const NaturalMatingForm()));
            }
          ),
          ListTile(
            title: const Text("Diagnosticar Reprodução"),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.of(context)
                       .push(MaterialPageRoute(builder: (context) => const PregnancyForm()));
            }
          ),
          ListTile(
            title: const Text("Registrar Parto"),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.of(context)
                       .push(MaterialPageRoute(builder: (context) => const BirthForm()));
            }
          )
        ]
      ),
      ExpansionTile(
        title: const Text("Desmame"),
        children: [
          ListTile(
            title: const Text("Registrar Desmame"),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.of(context)
                       .push(MaterialPageRoute(builder: (context) => const WeaningForm()));
            }
          )
        ]
      ),
      ExpansionTile(
        title: const Text("Tratamento"),
        children: [
          ListTile(
            title: const Text("Registrar Tratamento"),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.of(context)
                       .push(MaterialPageRoute(builder: (context) => const TreatmentForm()));
            }
          )
        ]
      ),
    ];

    return ListView(children: tiles);
  }
}
