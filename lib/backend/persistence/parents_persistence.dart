import 'dart:developer'; // ignore: unused_import

import 'package:drift/drift.dart';

import 'package:integrazoo/backend/database/database.dart';


class ParentsPersistence {
  ParentsPersistence();

  static Future<int> saveParents(Parents p) {
    final companion = ParentingCompanion.insert(
      bovine: Value(p.bovine),
      cow: Value(p.cow),
      bull: Value(p.bull),
      breeder: Value(p.breeder),
    );

    return database.into(database.parenting).insertOnConflictUpdate(companion);
  }

  static Future<Parents?> getParents(int earring) {
    return (database.select(database.parenting)
                    ..where((b) => b.bovine.equals(earring)))
                    .getSingleOrNull();
  }

  static Future<int> deleteParents(int earring) {
    return (database.delete(database.parenting)
                    ..where((b) => b.bovine.equals(earring)))
                    .go();
  }
}
