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
        title: const Text("Relatórios"),
        children: [
          ListTile(
            title: const Text("Desempenho das Matrizes"),
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
                       .push(MaterialPageRoute(builder: (context) => const IntegrazooBaseApp(
                         body: BovineForm(),
                         title: "REGISTRAR ANIMAL"
                       )));
            }
          ),
          ListTile(
            title: const Text("Visualizar Rebanho"),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.of(context)
                       .push(MaterialPageRoute(builder: (context) => const IntegrazooBaseApp(
                         body: BovinesListView(),
                         title: "REBANHO"
                       )));
            }
          )
        ]
      ),
      ExpansionTile(
        title: const Text("Reprodutores"),
        children: [
          ListTile(
            title: const Text("Registrar Reprodutor"),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const IntegrazooBaseApp(
                title: "REGISTRAR REPRODUTOR",
                body: BreederForm()
              )));
            }
          ),
          ListTile(
            title: const Text("Visualizar Reprodutores"),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.of(context)
                       .push(MaterialPageRoute(builder: (context) => const IntegrazooBaseApp(
                         body: BreedersListView(),
                         title: "REPRODUTORES"
                       )));
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
                       .push(MaterialPageRoute(builder: (context) => const IntegrazooBaseApp(
                         body: WeaningForm(),
                         title: "REGISTRAR DESMAME"
                       )));
            }
          ),
          ListTile(
            title: const Text("Visualizar Desmames"),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.of(context)
                       .push(MaterialPageRoute(builder: (context) => const IntegrazooBaseApp(
                         body: WeaningsListView(),
                         title: "DESMAMES"
                       )));
            }
          )
        ]
      ),
      ExpansionTile(
        title: const Text("Reprodução"),
        children: [
          ListTile(
            title: const Text("Registrar Inseminações"),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.of(context)
                       .push(MaterialPageRoute(builder: (context) => const IntegrazooBaseApp(
                         body: ArtificialInseminationForm(),
                         title: "REGISTRAR INSEMINAÇÃO ARTIFICIAL"
                       )));
            }
          ),
          ListTile(
            title: const Text("Registrar Monta"),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.of(context)
                       .push(MaterialPageRoute(builder: (context) => const IntegrazooBaseApp(
                         body: NaturalMatingForm(),
                         title: "REGISTRAR MONTA"
                       )));
            }
          ),
          ListTile(
            title: const Text("Registrar Prenhe"),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.of(context)
                       .push(MaterialPageRoute(builder: (context) => const IntegrazooBaseApp(
                         body: PregnancyForm(),
                         title: "REGISTRAR PRENHE"
                       )));
            }
          ),
          ListTile(
            title: const Text("Registrar Parto"),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.of(context)
                       .push(MaterialPageRoute(builder: (context) => const IntegrazooBaseApp(
                         body: BirthForm(),
                         title: "REGISTRAR PARTO"
                       )));
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
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const IntegrazooBaseApp(
                title: "REGISTRAR TRATAMENTO",
                body: TreatmentForm()
              )));
            }
          ),
          ListTile(
            title: const Text("Visualizar Tratamentos"),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const IntegrazooBaseApp(
                title: "TRATAMENTOS",
                body: TreatmentsListView()
              )));
            }
          )
        ]
      ),
      ExpansionTile(
        title: const Text("Finalização"),
        children: [
          ListTile(
            title: const Text("Registrar Finalização"),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const IntegrazooBaseApp(
                title: "REGISTRAR FINALIZAÇÃO",
                body: FinishForm()
              )));
            }
          ),
          ListTile(
            title: const Text("Visualizar Finalizações"),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.of(context) .push(MaterialPageRoute(builder: (context) => const IntegrazooBaseApp(
                title: "FINALIZAÇÕES",
                body: FinishesListView()
              )));
            }
          )
        ]
      ),
    ];

    return ListView(children: tiles);
  }
}
