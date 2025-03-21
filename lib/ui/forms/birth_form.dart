import 'dart:developer'; // ignore: unused_import

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:integrazoo/backend.dart';

import 'package:integrazoo/ui/components.dart';


class BirthForm extends StatefulWidget {
  final int? earring;
  final bool shouldPop;

  const BirthForm({ super.key, this.earring, this.shouldPop = false });

  @override
  State<BirthForm> createState() => _BirthForm();
}

class _BirthForm extends State<BirthForm> {
  final _formKey = GlobalKey<FormState>();

  final motherEarringController = EarringController();

  final newBornEarringController = TextEditingController();
  final newBornNameController = TextEditingController();
  final newBornWeightController = TextEditingController();
  Sex? newBornSex;
  BodyConditionScore? newBornBCS;

  final observationController = TextEditingController();

  late final TextEditingController dateBirthController;
  DateTime dateBirth = DateTime.now();

  @override
  void initState() {
    super.initState();

    motherEarringController.setEarring(widget.earring);

    dateBirthController = TextEditingController(text: DateFormat.yMd("pt_BR").format(dateBirth));
  }

  @override
  Widget build(BuildContext context) {
    final addButton = TextButton(onPressed: saveBirth, child: const Text("SALVAR"));

    final cowSelector = SingleBovineSelector(
      sex: Sex.female,
      wasDiscarded: false,
      isReproducing: false,
      isPregnant: true,
      label: "Vaca",
      earringController: motherEarringController,
    );

    final dateBirthPicker = TextFormField(
      controller: dateBirthController,
      decoration: const InputDecoration(border: OutlineInputBorder(),
                                        label: Text("Data do Parto"),
                                        floatingLabelBehavior: FloatingLabelBehavior.always),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: dateBirth,
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
        );
        if (pickedDate != null) {
          setState(() {
            dateBirth = pickedDate;
            dateBirthController.text = DateFormat.yMd("pt_BR").format(pickedDate);
          });
        }
      },
    );

    final newBornNameField = TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(border: OutlineInputBorder(),
                                        label: Text("Nome do Novo Animal (Opcional)"),
                                        hintText: "Digite o nome do animal que nasceu.",
                                        floatingLabelBehavior: FloatingLabelBehavior.always),
      controller: newBornNameController
    );

    final newBornEarringField = TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(border: OutlineInputBorder(),
                                        label: Text("Brinco do Novo Animal"),
                                        hintText: "Digite o brinco do animal que nasceu.",
                                        floatingLabelBehavior: FloatingLabelBehavior.always),
      controller: newBornEarringController,
      validator: (String? value) {
        if (value == null) {
          return null;
        }

        if (value.isNotEmpty && int.tryParse(value) == null) {
          return "Por favor, digite um número válido.";
        }

        return null;
      },
    );

    final newBornWeightField = TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(border: OutlineInputBorder(),
                                        label: Text("Peso ao Nascer do Novo Animal"),
                                        hintText: "Digite o peso do animal que nasceu.",
                                        floatingLabelBehavior: FloatingLabelBehavior.always),
      controller: newBornWeightController,
      validator: (String? value) {
        if (value == null) {
          return null;
        }

        if (value.isNotEmpty && double.tryParse(value) == null) {
          return "Por favor, digite um número válido.";
        }

        return null;
      },
    );

    final newBornSexDropdown = DropdownMenu<Sex>(
      label: const Text("Sexo"),
      dropdownMenuEntries: Sex.values.map((sex) => DropdownMenuEntry(value: sex, label: sex.toString())).toList(),
      onSelected: (value) => newBornSex = value!,
      expandedInsets: EdgeInsets.zero,
    );

    final newBornBCSDropdown = DropdownMenu<BodyConditionScore>(
      label: const Text("Avaliação Corporal"),
      dropdownMenuEntries: BodyConditionScore.values.map((bcs) => DropdownMenuEntry(value: bcs, label: bcs.toString())).toList(),
      onSelected: (value) => newBornBCS = value!,
      expandedInsets: EdgeInsets.zero,
    );

    final observationField = TextFormField(
      keyboardType: TextInputType.text,
      controller: observationController,
      decoration: const InputDecoration(hintText: 'Exemplo: Veterinario indicou riscos na prenhez.',
                                        border: OutlineInputBorder(),
                                        label: Text("Observação"),
                                        floatingLabelBehavior: FloatingLabelBehavior.always),
    );

    Divider divider = const Divider(color: Colors.transparent);

    final header = Text(
      widget.earring == null ? "REGISTRANDO PARTO" : "EDITANDO NASCIMENTO DO ANIMAL #${widget.earring!}",
      textAlign: TextAlign.center,
      textScaler: const TextScaler.linear(1.5)
    );

    final column = <Widget>[
      header,
      if (widget.earring == null) ...[
        cowSelector,
        divider
      ],
      dateBirthPicker,
      divider,
      newBornEarringField,
      divider,
      newBornNameField,
      divider,
      newBornWeightField,
      divider,
      newBornSexDropdown,
      divider,
      newBornBCSDropdown,
      divider,
      observationField,
      divider,
      addButton
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      child:
      Form(
        autovalidateMode: AutovalidateMode.always,
        key: _formKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: column)
      )
    );
  }

  void saveBirth() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();

      String? error = validateAllFields();

      if (error != null) {
        if (context.mounted) {
          SnackBar snackBar = SnackBar(
            content: Text(error),
            backgroundColor: Colors.red,
            showCloseIcon: true
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        return;
      }

      final newBornEarring = int.parse(newBornEarringController.text);

      if (await BovineService.doesEarringExists(newBornEarring)) {
        if (mounted) {
          SnackBar snackBar = const SnackBar(
            content: Text("O brinco selsecionado para o novo animal ja foi utilizado."),
            backgroundColor: Colors.red,
            showCloseIcon: true
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        return;
      }

      await transaction(() async {
        final pregnancy = await PregnancyService.getActivePregnancy(motherEarringController.earring!);

        if (pregnancy != null) {
          final updatePregnancy = pregnancy.copyWith(hasEnded: true);

          await PregnancyService.savePregnancy(updatePregnancy);
        }

        await updateMother();

        await createAnimal();

        final reproductionId = pregnancy?.reproduction;

        final reproduction = await ReproductionService.getById(reproductionId ?? 0);

        if (reproduction != null) {
          createParents(motherEarringController.earring!, reproduction.bull, reproduction.breeder);
        } else {
          createParents(motherEarringController.earring!, null, null);
        }

        await saveBirthInfo(pregnancy?.id);

        if (mounted) {
          SnackBar snackBar = const SnackBar(
            content: Text("Parto registrado com sucesso"),
            backgroundColor: Colors.green,
            showCloseIcon: true
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

          clearForm();

          if (widget.shouldPop) {
            Navigator.of(context).pop();
          }
        }
      });
    }
  }

  Future<int> updateMother() {
    return BovineService.getBovine(motherEarringController.earring!).then(
      (cow) {
        if (cow == null) {
          throw Exception("Could not find bovine ${motherEarringController.earring}");
        }

        final cowUpdate = cow.copyWith(isReproducing: false, isPregnant: false);

        return BovineService.saveBovine(cowUpdate);
      }
    );
  }

  Future<int> createAnimal() {
    final newBornEarring = int.parse(newBornEarringController.text);

    final bovine = Bovine.fromJson({
      'name': newBornNameController.text.isEmpty ? null : newBornNameController.text,
      'sex': newBornSex!.index,
      'earring': newBornEarring,
      'wasDiscarded': false,
      'isReproducing': false,
      'isPregnant': false,
      'hasBeenWeaned': false,
      'isBreeder': false
    });

    return BovineService.saveBovine(bovine);
  }

  Future<int> createParents(int cow, int? bull, String? breeder) {
    final newBornEarring = int.parse(newBornEarringController.text);

    final parents = Parents.fromJson({
      'bovine': newBornEarring,
      'cow': cow,
      'bull': bull,
      'breeder': breeder
    });

    return ParentsService.saveParents(parents).then(
      (value) {
        return Future.value(value);
      },
      onError: (err) {
        throw err;
      }
    );
  }

  Future<int> saveBirthInfo(int? pregnancyId) {
    final newBornEarring = int.parse(newBornEarringController.text);
    final newBornWeight = double.parse(newBornWeightController.text);

    final birth = Birth.fromJson({
      'id': 0,
      'date': dateBirth,
      'weight': newBornWeight,
      'bcs': newBornBCS!.index,
      'bovine': newBornEarring,
      'pregnancy': pregnancyId
    });

    return BirthService.saveBirth(birth);
  }

  String? validateAllFields() {
    if (motherEarringController.earring == null) {
      return "Por favor, escolha a vaca.";
    }

    if (newBornEarringController.text.isEmpty) {
      return "Por favor, digite o brinco do novo animal.";
    }

    if (newBornWeightController.text.isEmpty) {
      return "Por favor, digite o peso do novo animal";
    }

    if (newBornSex == null) {
      return "Por favor, selecione o sexo do novo animal.";
    }

    if (newBornBCS == null) {
      return "Por favor, selecione a avaliação corporal do novo animal.";
    }

    return null;
  }

  void clearForm() {
    setState(() {
      motherEarringController.clear();

      newBornNameController.text = "";
      newBornEarringController.text = "";
      newBornWeightController.text = "";

      newBornSex = null;
      newBornBCS = null;

      observationController.text = "";
    });
  }
}
