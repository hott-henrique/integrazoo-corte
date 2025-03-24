import 'dart:developer'; // ignore: unused_import

import 'package:drift/drift.dart';

import 'package:integrazoo/backend.dart';


class BirthPersistence {
  BirthPersistence();

  static Future<int> saveBirth(Birth b) {
    final companion = BirthsCompanion.insert(
      date: b.date,
      weight: b.weight,
      bcs: b.bcs,
      bovine: Value(b.bovine),
      pregnancy: Value.absentIfNull(b.pregnancy),
    );

    return database.into(database.births).insertOnConflictUpdate(companion);
  }

  static Future<Birth?> getBirth(int earring) {
    return (database.select(database.births)
                    ..where((b) => b.bovine.equals(earring)))
                    .getSingleOrNull();
  }

  static Future<void> deleteBirth(int earring) {
    return (database.delete(database.births)
                    ..where((b) => b.bovine.equals(earring))).go();
  }

  static Future<Pregnancy?> getCowFirstBirth(int earring) async {
    final result = await database.customSelect(
      """
        SELECT p.*
        FROM Births as b JOIN Pregnancies as p ON p.id = b.pregnancy
        WHERE p.cow = ?
        ORDER BY b.date DESC
        LIMIT 1;
      """,
      variables: [ Variable(earring) ]
    ).getSingleOrNull();

    if (result != null) {
      return Pregnancy.fromJson({
        'id': result.data['id'],
        'cow': result.data['cow'],
        'date': DateTime.fromMillisecondsSinceEpoch(result.data['date'] * 1000),
        'birthForecast': DateTime.fromMillisecondsSinceEpoch(result.data['birth_forecast'] * 1000),
        'reproduction': result.data['reproduction'],
        'hasEnded': result.data['hasEnded'] == 0 ? false : true,
        'observation': result.data['observation'],
      });
    }

    return null;
  }
}
