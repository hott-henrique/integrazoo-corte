import 'dart:developer'; // ignore: unused_import

import 'package:drift/drift.dart';

import 'package:integrazoo/backend.dart';


class TreatmentPersistence {
  TreatmentPersistence();

  static Future<int> saveTreatment(Treatment t) {
    final companion = TreatmentsCompanion.insert(
      id: Value.absentIfNull(t.id == 0 ? null : t.id),
      medicine: t.medicine,
      reason: t.reason,
      startingDate: t.startingDate,
      endingDate: t.endingDate,
      bovine: t.bovine
    );

    return database.into(database.treatments).insertOnConflictUpdate(companion);
  }

  static Future<Treatment?> getTreatment(int id) {
    return (database.select(database.treatments)
                    ..where((t) => t.id.equals(id)))
                    .getSingleOrNull();
  }

  static Future<void> delete(int id) {
    return (database.delete(database.treatments)
                    ..where((t) => t.id.equals(id))).go();
  }

  static Future<int> countTreatments() async {
    final result = await database.customSelect(
      """
        SELECT COUNT(*)
        FROM Treatments t
      """,
    ).getSingle();

    return result.read<int>("COUNT(*)");
  }

  static Future<List<Treatment>> getTreatments(int pageSize, int page) async {
    return (database.select(database.treatments)..limit(pageSize, offset: page * pageSize)).get();
  }

  static Future<int> countActiveTreatments() async {
    final now = DateTime.now();
    final endOfToday = DateTime(now.year, now.month, now.day, 0, 0, 0);

    final result = await database.customSelect(
      """
        SELECT COUNT(*)
        FROM Bovines b
        JOIN Treatments t ON t.bovine = b.earring
        WHERE t.ending_date >= ?
      """,
      variables: [ Variable(endOfToday.millisecondsSinceEpoch ~/ 1000) ],
    ).getSingle();

    return result.read<int>("COUNT(*)");
  }

  static Future<List<(Bovine, Treatment)>> getBovinesInTreatment(int pageSize, int page) async {
    final now = DateTime.now();
    final endOfToday = DateTime(now.year, now.month, now.day, 0, 0, 0);

    final result = await database.customSelect(
      """
        SELECT b.*, t.*
        FROM Bovines b
        JOIN Treatments t ON t.bovine = b.earring
        WHERE t.ending_date >= ?
        ORDER BY t.starting_date DESC
        LIMIT ?
        OFFSET ?
      """,
      variables: [ Variable(endOfToday.millisecondsSinceEpoch ~/ 1000), Variable(pageSize), Variable(page * pageSize)],
    ).get();

    return result.map((row) {
      Bovine b = Bovine.fromJson({
        'earring': row.data["earring"] as int,
        'name': row.data["name"] as String?,
        'sex': row.data["sex"] as int,
        'wasFinished': row.data["was_discarded"] == 0 ? false : true,
        'isReproducing': row.data["is_reproducing"] == 0 ? false : true,
        'isPregnant': row.data["is_pregnant"] == 0 ? false : true,
        'hasBeenWeaned': row.data["has_been_weaned"] == 0 ? false : true,
        'isBreeder': row.data["is_breeder"] == 0 ? false : true,
      });

      Treatment t = Treatment.fromJson({
        'id': row.data["id"] as int,
        'medicine': row.data["medicine"] as String,
        'reason': row.data["reason"] as String,
        'startingDate': DateTime.fromMillisecondsSinceEpoch((row.data["starting_date"] as int) * 1000),
        'endingDate': DateTime.fromMillisecondsSinceEpoch((row.data["ending_date"] as int) * 1000),
        'bovine': row.data["bovine"] as int,
      });

      return (b, t);
    }).toList();
  }
}
