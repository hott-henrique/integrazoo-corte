import 'dart:developer'; // ignore: unused_import

import 'package:drift/drift.dart';

import 'package:integrazoo/backend.dart';


class YearlingWeightPersistence {
  YearlingWeightPersistence();

  static Future<int> saveYearlingWeight(YearlingWeight b) {
    final companion = YearlingWeightsCompanion.insert(
      bovine: Value(b.bovine),
      value: b.value,
    );

    return database.into(database.yearlingWeights).insertOnConflictUpdate(companion);
  }

  static Future<YearlingWeight?> getYearlingWeight(int earring) {
    return (database.select(database.yearlingWeights)
                    ..where((b) => b.bovine.equals(earring)))
                    .getSingleOrNull();
  }

  static Future<void> deleteYearlingWeight(int earring) {
    return (database.delete(database.yearlingWeights)
                    ..where((b) => b.bovine.equals(earring))).go();
  }
}
