import 'dart:developer'; // ignore: unused_import

import 'package:drift/drift.dart';

import 'package:integrazoo/backend.dart';


class FinishPersistence {
  FinishPersistence();

  static Future<void> save(int earring, Finish finish) async {
    final r = await (database.select(database.bovines)
                             ..where((b) => b.earring.equals(earring)))
                             .getSingleOrNull();

    if (r == null) {
      return;
    }

    final finishCompanion = FinishesCompanion.insert(
      bovine: Value(finish.bovine),
      reason: finish.reason,
      observation: Value(finish.observation),
      weight: Value(finish.weight),
      hotCarcassWeight: Value(finish.hotCarcassWeight),
      date: finish.date
    );

    database.into(database.finishes).insertOnConflictUpdate(finishCompanion);
  }

  static Future<Finish?> getByEarring(int earring) async {
    return (database.select(database.finishes)
                    ..where((d) => d.bovine.equals(earring)))
                    .getSingleOrNull();
  }

  static Future<int> countFinishes() async {
    final result = await database.customSelect(
      """
        SELECT COUNT(*)
        FROM Finishes f
      """,
    ).getSingle();

    return result.read<int>("COUNT(*)");
  }

  static Future<List<Finish>> getFinishes(int pageSize, int page, FinishesOrderField field, bool asc) async {
    final mode = asc ? OrderingMode.asc : OrderingMode.desc;
    return (
      database.select(database.finishes)
              ..limit(pageSize, offset: page * pageSize)
              ..orderBy([
                if (field == FinishesOrderField.earring)
                  (u) => OrderingTerm(expression: u.bovine, mode: mode),
                if (field == FinishesOrderField.reason)
                  (u) => OrderingTerm(expression: u.reason, mode: mode),
                if (field == FinishesOrderField.date)
                  (u) => OrderingTerm(expression: u.date, mode: mode),
                if (field == FinishesOrderField.weight)
                  (u) => OrderingTerm(expression: u.weight, mode: mode),
                if (field == FinishesOrderField.hotCarcassWeight)
                  (u) => OrderingTerm(expression: u.hotCarcassWeight, mode: mode),
              ])
    ).get();
  }

  static Future<void> delete(int earring) async {
    final r = await (database.select(database.bovines)
                             ..where((b) => b.earring.equals(earring)))
                             .getSingleOrNull();

    if (r == null) {
      return;
    }

    (database.delete(database.finishes)..where((d) => d.bovine.equals(earring))).go().then(
      (_) {
        final bovineUpdate = r.copyWith(wasFinished: false);

        BovinePersistence.saveBovine(bovineUpdate);
      }
    );
  }
}
