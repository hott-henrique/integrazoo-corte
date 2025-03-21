import 'dart:developer'; // ignore: unused_import

import 'package:drift/drift.dart';

import 'package:integrazoo/backend/persistence/birth_persistence.dart';
import 'package:integrazoo/backend/persistence/bovine_persistence.dart';
import 'package:integrazoo/backend/persistence/pregnancy_persistence.dart';

import 'package:integrazoo/backend/database/database.dart';

import 'package:integrazoo/domain/enumerations.dart';


class ReproductionPersistence {
  ReproductionPersistence();

  static Future<int> saveReproduction(Reproduction r) {
    final companion = ReproductionsCompanion.insert(
      id: r.id == 0 ? const Value.absent() : Value(r.id),
      cow: r.cow,
      bull: Value(r.bull),
      kind: r.kind,
      diagnostic: Value(r.diagnostic),
      date: r.date,
      breeder: Value(r.breeder),
      strawNumber: Value(r.strawNumber)
    );

    return database.into(database.reproductions).insertOnConflictUpdate(companion);
  }

  static Future<Reproduction?> getById(int id) {
    return (database.select(database.reproductions)..where((r) => r.id.equals(id))).getSingleOrNull();
  }

  static Future<int> delete(int id) async {
    final r = (await getById(id))!;

    final bovine = (await BovinePersistence.getBovine(r.cow))!;

    BovinePersistence.saveBovine(bovine.copyWith(isReproducing: false));

    return (database.delete(database.reproductions)..where((r) => r.id.equals(id))).go();
  }

  static Future<Reproduction?> getActiveReproduction(int earring) {
    return (database.select(database.reproductions)..where(
      (r) => r.cow.equals(earring) & r.diagnostic.equals(ReproductionDiagonostic.waiting.index)
    )).getSingleOrNull();
  }

  static Future<Reproduction?> getReproductionThatGeneratedAnimal(int earring) async {
    final birth = await BirthPersistence.getBirth(earring);

    if (birth == null || birth.pregnancy == null) {
      return null;
    }

    final pregnancy = await PregnancyPersistence.getById(birth.pregnancy!);

    if (pregnancy == null || pregnancy.reproduction == null) {
      return null;
    }

    return (database.select(database.reproductions)..where((r) => r.id.equals(pregnancy.reproduction!))).getSingleOrNull();
  }

  static Future<int> countBovinesReproducing() async {
    final result = await database.customSelect(
      """
        SELECT COUNT(*)
        FROM Bovines b
        JOIN Reproductions r ON r.cow = b.earring
        WHERE r.diagnostic = 2
      """,
    ).getSingle();

    return result.read<int>("COUNT(*)");
  }

  static Future<List<(Bovine, Reproduction)>> getBovinesReproducing(int pageSize, int page) async {
    final result = await database.customSelect(
      """
        SELECT b.*, r.*
        FROM Bovines b
        JOIN Reproductions r ON r.cow = b.earring
        WHERE r.diagnostic = 2
        ORDER BY r.date DESC
        LIMIT ?
        OFFSET ?
      """,
      variables: [ Variable(pageSize), Variable(page * pageSize)],
    ).get();

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
      });

      Reproduction r = Reproduction.fromJson({
        'id': row.data["id"] as int,
        'kind': row.data["kind"] as int,
        'date': DateTime.fromMillisecondsSinceEpoch((row.data["date"] as int) * 1000),
        'diagnostic': row.data["diagnostic"] as int,
        'cow': row.data["cow"] as int,
        'bull': row.data["bull"] as int?,
        'breeder': row.data["breeder"] as String?,
        'strawNumber': row.data["straw_number"] as int?,
      });

      return (b, r);
    }).toList();
  }
}
