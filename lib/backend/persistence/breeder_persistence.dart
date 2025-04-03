import 'dart:developer'; // ignore: unused_import

import 'package:drift/drift.dart';

import 'package:integrazoo/backend.dart';


class BreederPersistence {
  BreederPersistence();

  static Future<int> saveBreeder(Breeder breeder) async {
    final companion = BreedersCompanion.insert(
      name: breeder.name,
      father: Value(breeder.father),
      mother: Value(breeder.mother),
      paternalGrandmother: Value(breeder.paternalGrandmother),
      paternalGrandfather: Value(breeder.paternalGrandfather),
      maternalGrandmother: Value(breeder.maternalGrandmother),
      maternalGrandfather: Value(breeder.maternalGrandfather),
      epdBirthWeight: Value(breeder.epdBirthWeight),
      epdWeaningWeight: Value(breeder.epdWeaningWeight),
      epdYearlingWeight: Value(breeder.epdYearlingWeight),
    );

    return database.into(database.breeders).insertOnConflictUpdate(companion);
  }

  static Future<Breeder?> getBreeder(String name) async {
    return (database.select(database.breeders)
                    ..where((b) => b.name.equals(name)))
                    .getSingleOrNull();
  }

  static Future<int> countBreeders() async {
    final result = await database.customSelect(
      """
        SELECT COUNT(*)
        FROM Breeders b
      """,
    ).getSingle();

    return result.read<int>("COUNT(*)");
  }

  static Future<List<Breeder>> getBreeders(int pageSz, int page) async {
    return (database.select(database.breeders)..limit(pageSz, offset: page * pageSz)).get();
  }

  static Future<List<Breeder>> searchBreeder(String? query) async {
    return (database.select(database.breeders)
                    ..where(
                      (b) {
                        query ??= "";

                        Expression<bool> cond = b.name.like("%$query%");

                        return cond;
                      }
                    ))
                    .get();
  }

  static Future<int> deleteBreeder(String name) {
    return (database.delete(database.breeders)
                    ..where((b) => b.name.equals(name)))
                    .go();
  }

  static Future<int> countChildrenOfSex(String breeder, Sex s) async {
    final result = await database.customSelect(
      """
        SELECT COUNT(*)
        FROM Parenting as p JOIN Bovines as b ON p.bovine = b.earring
        WHERE p.breeder = ? AND b.sex = ?;
      """,
      variables: [ Variable(breeder), Variable(s.index) ]
    ).getSingle();

    return result.data['COUNT(*)'] as int;
  }

  static Future<double> getAverageBirthWeight(String breeder) async {
    final result = await database.customSelect(
      """
        SELECT AVG(b.weight) AS avg_weight
        FROM Parenting as p JOIN Births as b ON p.bovine = b.bovine
        WHERE p.breeder = ?;
      """,
      variables: [ Variable(breeder) ]
    ).getSingle();

    return (result.data['avg_weight'] ?? 0.0) as double;
  }

  static Future<double> getAverageWeaningWeight(String breeder) async {
    final result = await database.customSelect(
      """
        SELECT AVG(w.weight) AS avg_weight
        FROM Parenting as p JOIN Weanings as w ON p.bovine = w.bovine
        WHERE p.breeder = ?;
      """,
      variables: [ Variable(breeder) ]
    ).getSingle();

    return (result.data['avg_weight'] ?? 0.0) as double;
  }

}
