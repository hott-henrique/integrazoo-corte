import 'dart:developer'; // ignore: unused_import

import 'package:drift/drift.dart';

import 'package:integrazoo/backend.dart';


class RelatoryPersistence {
  RelatoryPersistence();


  static Future<List<BovineStatistics>> getOffspringStatistics(int earring) async {
    final bovines = await (database.customSelect("""
      SELECT b.earring, b.name, b.sex
      FROM Bovines b JOIN Parenting p
      WHERE p.cow = ? OR p.bull = ?;
    """, variables:[ Variable(earring), Variable(earring) ]).get());

    List<BovineStatistics> statistics = List.empty(growable: true);

    for (final b in bovines) {
      final earring = b.read<int>("earring");
      final name = b.read<String?>("name");

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

      final s = BovineStatistics(
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

  static Future<List<BovineStatistics>> getBovinesStatistics(List<Bovine> bovines) async {
    List<BovineStatistics> statistics = List.empty(growable: true);

    for (final b in bovines) {
      final earring = b.earring;
      final name = b.name;

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

      final s = BovineStatistics(
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
}
