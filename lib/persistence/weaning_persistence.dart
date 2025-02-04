import 'dart:developer';

import 'package:drift/drift.dart';

import 'package:integrazoo/database/database.dart';

import 'package:integrazoo/globals.dart';


class WeaningPersistence {
  WeaningPersistence();

  static Future<int> saveWeaning(Weaning w) {
    final companion = WeaningsCompanion.insert(
      bovine: Value(w.bovine),
      date: w.date,
      weight: w.weight,
    );

    return database.into(database.weanings).insertOnConflictUpdate(companion);
  }

  static Future<Weaning?> getWeaning(int earring) {
    return (database.select(database.weanings)
                    ..where((b) => b.bovine.equals(earring)))
                    .getSingleOrNull();
  }

  static Future<int> deleteWeaning(int earring) {
    return (database.delete(database.weanings)
                    ..where((b) => b.bovine.equals(earring)))
                    .go();
  }

  static Future<int> countWeanings() async {
    final result = await database.customSelect(
      """
        SELECT COUNT(*)
        FROM Weanings w
      """,
    ).getSingle();

    return result.read<int>("COUNT(*)");
  }

  static Future<List<Weaning>> getWeanings(int pageSize, int page) async {
    return (database.select(database.weanings)..limit(pageSize, offset: page * pageSize)).get();
  }
}
