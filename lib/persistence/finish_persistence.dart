import 'dart:developer';

import 'package:drift/drift.dart';

import 'package:integrazoo/globals.dart';

import 'package:integrazoo/database/database.dart';
import 'package:integrazoo/persistence/bovine_persistence.dart';


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

  static Future<void> delete(int earring) async {
    final r = await (database.select(database.bovines)
                             ..where((b) => b.earring.equals(earring)))
                             .getSingleOrNull();

    if (r == null) {
      return;
    }

    (database.delete(database.finishes)..where((d) => d.bovine.equals(earring))).go().then(
      (_) {
        final bovineUpdate = r.copyWith(wasDiscarded: false);

        BovinePersistence.saveBovine(bovineUpdate);
      }
    );
  }
}
