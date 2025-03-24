import 'dart:developer'; // ignore: unused_import

import 'package:drift/drift.dart';

import 'package:integrazoo/backend.dart';


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

  static Future<List<FemaleBreederStatistics>> getFemaleBreedersStatistics(int pageSize, int page) async {
    final cows = await (database.customSelect("""
      SELECT b.earring, b.name
      FROM Bovines b
      WHERE b.sex = 1 AND b.was_discarded = 0 AND b.is_breeder = 1
      LIMIT ?
      OFFSET ?;
    """, variables:[ Variable(pageSize), Variable(page * pageSize) ]).get());

    inspect(cows);

    List<FemaleBreederStatistics> statistics = List.empty(growable: true);

    for (final c in cows) {
      final earring = c.read<int>("earring");
      final name = c.read<String?>("name");

      final futureFirstBirthDate = (database.customSelect("""
        SELECT b.date AS date
        FROM Births b JOIN Pregnancies p ON b.pregnancy = p.id
                      JOIN Reproductions r ON p.reproduction = r.id
        WHERE r.cow = ?
        ORDER BY b.date ASC
        LIMIT 1;
      """, variables: [ Variable(earring) ]).getSingleOrNull());

      final futureCountFailedReproductions = database.customSelect("""
        SELECT COUNT(*) AS failures
        FROM Reproductions r1
        WHERE date > (
            SELECT COALESCE((
                SELECT r3.date
                FROM Reproductions r3
                WHERE r3.cow = ? AND r3.diagnostic = 0
                ORDER BY r3.date DESC
                LIMIT 1
            ), 0)
        ) AND r1.cow = ?;
      """, variables: [ Variable(earring), Variable(earring) ]).getSingle();

      final futureBirth = BirthService.getBirth(earring);
      final futureWeaning = WeaningService.getWeaning(earring);
      final futureYearlingWeight = YearlingWeightService.getYearlingWeight(earring);

      final countFailedReproductions = (await futureCountFailedReproductions).read<int>("failures");
      final weaningWeight = (await futureWeaning)?.weight;
      final yearlingWeight = (await futureYearlingWeight)?.value;

      final birth = await futureBirth;
      final firstBirthDate = (await futureFirstBirthDate)?.read<int?>("date");

      int? monthsAfterFirstBirth;

      if (birth != null && firstBirthDate != null) {
        monthsAfterFirstBirth = (
          (firstBirthDate - (birth.date.millisecondsSinceEpoch / 1000)) /
          (60 * 60 * 24 * 30.44)
        ).round();
      }

      final birthWeight = birth?.weight;

      final s = FemaleBreederStatistics(
        earring: earring,
        name: name,
        weightBirth: birthWeight,
        weightWeaning: weaningWeight,
        weightYearling: yearlingWeight,
        monthsAfterFirstBirth: monthsAfterFirstBirth,
        countFailedReproductions: countFailedReproductions
      );

      statistics.add(s);
    }

    return statistics;
  }

  static Future<List<(String, double?, double?, double?, int?, int)>> getOffspringStatistics(int earring) async {
    return [
      ("Test A", 1.0, 1.0, 6.0, null, 0),
      ("Test B", 2.0, 4.0, 5.0, null, 1),
      ("Test C", 3.0, 3.0, 3.0, null, 2),
    ];
  }
}
