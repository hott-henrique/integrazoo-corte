import 'dart:developer';

import 'package:drift/drift.dart';

import 'package:integrazoo/globals.dart';


class RelatoryPersistence {
  RelatoryPersistence();

  static Future<int> countNonDiscardedFemaleBreeders() async {
    final result = (await database.customSelect("""
      SELECT
        COUNT(*)
      FROM Bovines bov
      WHERE bov.sex = 1 AND bov.was_discarded = 0 AND bov.is_breeder = 1
    """).getSingle());

    return result.read<int>("COUNT(*)");
  }

  static Future<List<(String, double?, double?, double?, int?, int)>> getFemaleBreedersStatistics(int pageSize, int page) async {
    final results = (await database.customSelect("""
      SELECT
          CASE
              WHEN bov.name IS NOT NULL THEN CONCAT(bov.name, ' #', bov.earring)
              ELSE CONCAT('#', bov.earring)
          END AS name,
          bov.weight540,
          bir.weight birth_weight,
          wea.weight weaning_weight,
          CAST(((JULIANDAY(DATE(fb_date, 'unixepoch')) - JULIANDAY(DATE(bir.date, 'unixepoch'))) / 30) AS INTEGER) afb
      FROM Bovines bov
      LEFT JOIN Births bir ON bov.earring = bir.bovine
      LEFT JOIN Weanings wea ON bov.earring = wea.bovine
      LEFT JOIN (
          SELECT p1.cow as cow, b.date as fb_date
          FROM Pregnancies p1
          JOIN Births b ON b.pregnancy = p1.id
          WHERE p1.reproduction = (
              SELECT r1.id
              FROM Reproductions r1
              WHERE r1.date = (SELECT MIN(date) FROM Reproductions r2 WHERE r1.cow = r2.cow AND r1.diagnostic = 0)
          )
      ) first_birth ON bov.earring = first_birth.cow
      WHERE bov.sex = 1 AND bov.was_discarded = 0 AND bov.is_breeder = 1
      LIMIT ?
      OFFSET ?;
    """, variables: [ Variable(pageSize), Variable(page * pageSize) ]).get());

    return results.map((row) {
      final name = row.read<String>('name');
      final weight540 = row.readNullable<double>('weight540');
      final birthWeight = row.readNullable<double>('birth_weight');
      final weaningWeight = row.readNullable<double>('weaning_weight');
      final afb = row.readNullable<int>('afb');
      const attempts = 0;
      inspect((name, weight540, birthWeight, weaningWeight, afb, attempts));
      return (name, weight540, birthWeight, weaningWeight, afb, attempts);
    }).toList();
  }

  static Future<List<(String, double?, double?, double?, int?, int)>> getOffspringStatistics(int earring) async {
    return [
      ("Test A", 1.0, 1.0, 6.0, null, 0),
      ("Test B", 2.0, 4.0, 5.0, null, 1),
      ("Test C", 3.0, 3.0, 3.0, null, 2),
    ];
  }
}
