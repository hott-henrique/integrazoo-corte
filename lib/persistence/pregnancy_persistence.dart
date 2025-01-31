import 'dart:developer';

import 'package:drift/drift.dart';
import 'package:integrazoo/control/bovine_controller.dart';
import 'package:integrazoo/control/reproduction_controller.dart';

import 'package:integrazoo/globals.dart';

import 'package:integrazoo/database/database.dart';


class PregnancyPersistence {
  PregnancyPersistence();

  static Future<int> savePregnancy(Pregnancy p) {
    final companion = PregnanciesCompanion.insert(
      id: p.id == 0 ? const Value.absent() : Value(p.id),
      cow: p.cow,
      date: p.date,
      birthForecast: p.birthForecast,
      reproduction: Value(p.reproduction),
      observation: Value(p.observation)
    );

    return database.into(database.pregnancies).insertOnConflictUpdate(companion);
  }

  static Future<Pregnancy?> getById(int id) {
    return (database.select(database.pregnancies)
                    ..where((p) => p.id.equals(id)))
                    .getSingleOrNull();
  }

  static Future<int> delete(int id) async {
    final pregnancy = await getById(id);

    if (pregnancy!.reproduction != null) {
      final reproduction = await ReproductionController.getById(pregnancy.reproduction!);

      await ReproductionController.saveReproduction(reproduction!.copyWith(diagnostic: ReproductionDiagonostic.waiting));
    }

    final cow = (await BovineController.getBovine(pregnancy.cow))!;

    await BovineController.saveBovine(cow.copyWith(isPregnant: false, isReproducing: true));

    return (database.delete(database.pregnancies)..where((p) => p.id.equals(id))).go();
  }

  static Future<Pregnancy?> getActivePregnancy(int earring) {
    return (database.select(database.pregnancies)
                    ..where((p) => p.cow.equals(earring) & p.hasEnded.equals(false))
                    ..orderBy([ (p) => OrderingTerm(expression: p.id, mode: OrderingMode.desc) ]))
                    .getSingleOrNull();
  }

  static Future<List<(Bovine, Pregnancy)>> getBovinesPregnant(int pageSize, int page) async {
    final result = await database.customSelect(
      """
        SELECT b.*, p.*
        FROM Bovines b
        JOIN Pregnancies p ON p.cow = b.earring
        WHERE p.has_ended = false AND b.is_pregnant = true
        ORDER BY p.birth_forecast DESC
        LIMIT ?
        OFFSET ?
      """,
      variables: [ Variable(pageSize), Variable(page * pageSize)],
    ).get();

    inspect(result);

    return result.map((row) {
      Bovine b = Bovine.fromJson({
        'earring': row.data["earring"] as int,
        'name': row.data["name"] as String?,
        'sex': row.data["sex"] as int,
        'wasDiscarded': row.data["was_discarded"] == 0 ? false : true,
        'isReproducing': row.data["is_reproducing"] == 0 ? false : true,
        'isPregnant': row.data["is_pregnant"] == 0 ? false : true,
        'hasBeenWeaned': row.data["has_been_weaned"] == 0 ? false : true,
        'isBreeder': row.data["is_breeder"] == 0 ? false : true,
        'weight540': row.data["weight540"] as int?,
      });

      inspect(b);

      Pregnancy p = Pregnancy.fromJson({
        'id': row.data["id"] as int,
        'cow': row.data["cow"] as int,
        'date': DateTime.fromMillisecondsSinceEpoch((row.data["date"] as int) * 1000),
        'birthForecast': DateTime.fromMillisecondsSinceEpoch((row.data["birth_forecast"] as int) * 1000),
        'reproduction': row.data["reproduction"] as int,
        'hasEnded': (row.data["has_ended"] as int) == 0 ? false : true,
        'observation': row.data["observation"] as String,
      });

      inspect(p);

      return (b, p);
    }).toList();
  }
}
