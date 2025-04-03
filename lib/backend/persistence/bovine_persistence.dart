import 'dart:developer'; // ignore: unused_import

import 'package:drift/drift.dart';

import 'package:integrazoo/backend.dart';


class BovinePersistence {
  BovinePersistence();

  static Future<int> saveBovine(Bovine bovine) async {
    final companion = BovinesCompanion.insert(
      earring: Value(bovine.earring),
      name: Value(bovine.name),
      sex: bovine.sex,
      wasFinished: Value(bovine.wasFinished),
      isReproducing: Value(bovine.isReproducing),
      isPregnant: Value(bovine.isPregnant),
      hasBeenWeaned: Value(bovine.hasBeenWeaned),
      isBreeder: Value(bovine.isBreeder),
    );

    return database.into(database.bovines).insertOnConflictUpdate(companion);
  }

  static Future<List<Bovine>> getBovines_(int pageSize, int page, { BovinesSearch? search }) async {
    final queryAsEarring = int.tryParse(search?.filter?.query ?? '');

    final whereConditions = <String>[];

    final filter = search?.filter;

    if (filter?.query.isNotEmpty ?? false) {
      whereConditions.add("(bovines.name LIKE '%${filter!.query}%' ${queryAsEarring != null ? 'OR bovines.earring = $queryAsEarring' : ''})");
    }

    if (filter != null) {
      if (filter.sex != null) {
        whereConditions.add('bovines.sex = ${filter.sex!.index}');
      }
      if (filter.isBreeder != null) {
        whereConditions.add('bovines.is_breeder = ${filter.isBreeder! ? 1 : 0}');
      }
      if (filter.hasBeenWeaned != null) {
        whereConditions.add('bovines.has_been_weaned = ${filter.hasBeenWeaned! ? 1 : 0}');
      }
      if (filter.isReproducing != null) {
        whereConditions.add('bovines.is_reproducing = ${filter.isReproducing! ? 1 : 0}');
      }
      if (filter.isPregnant != null) {
        whereConditions.add('bovines.is_pregnant = ${filter.isPregnant! ? 1 : 0}');
      }
      if (filter.wasFinished != null) {
        whereConditions.add('bovines.was_finished = ${filter.wasFinished! ? 1 : 0}');
      }
    }

    final whereClause = whereConditions.isNotEmpty ? 'WHERE ${whereConditions.join(" AND ")}' : '';

    final order = search?.order;

    final ascOrDec = search?.ascendent ?? false ? "ASC" : "DESC";
    final nullsPosition = search?.ascendent ?? false ? "FIRST" : "LAST";

    String joinClause = "";

    String orderClause = "ORDER BY bovines.earring $ascOrDec";

    if (order != null) {
      switch (order) {
        case BovinesOrderField.earring:
          orderClause = "ORDER BY bovines.earring $ascOrDec";
        break;

        case BovinesOrderField.birthWeight:
          orderClause = "ORDER BY births.weight $ascOrDec";
          joinClause = "JOIN births ON births.bovine = bovines.earring";
        break;

        case BovinesOrderField.weaningWeight:
          orderClause = "ORDER BY weanings.weight $ascOrDec";
          joinClause = "JOIN weanings ON weanings.bovine = bovines.earring";
        break;

        case BovinesOrderField.yearlingWeight:
          orderClause = "ORDER BY yearling_weights.value $ascOrDec";
          joinClause = "JOIN yearling_weights ON yearling_weights.bovine = bovines.earring";
        break;

        case BovinesOrderField.ageFirstBirth:
          orderClause = "ORDER BY first_birth_age $ascOrDec";
        break;

        case BovinesOrderField.recentFailedReproductionAttempts:
          orderClause = "ORDER BY failures $ascOrDec";
        break;
      }
    }

    const failuresSql = """
      (
        SELECT COUNT(*)
        FROM Reproductions r1
        WHERE r1.date > (
          SELECT COALESCE((
            SELECT r3.date
            FROM Reproductions r3
            WHERE r3.cow = bovines.earring AND r3.diagnostic = 0
            ORDER BY r3.date DESC
            LIMIT 1
          ), 0)
        ) AND r1.cow = bovines.earring
      ) AS failures
    """;

    const firstBirthAgeSql = """
      (
        SELECT b.date AS date
        FROM Births b JOIN Pregnancies p ON b.pregnancy = p.id
                      JOIN Reproductions r ON p.reproduction = r.id
        WHERE r.cow = bovines.earring
        ORDER BY b.date ASC
        LIMIT 1
      ) AS first_birth_age
    """;

    final sql = '''
      SELECT
        bovines.*, $failuresSql, $firstBirthAgeSql
      FROM bovines
      $joinClause
      $whereClause
      $orderClause NULLS $nullsPosition
      LIMIT $pageSize OFFSET ${page * pageSize}
    ''';

    final result = await database.customSelect(sql).get();

    return result.map((row) {
      final data = row.data;

      final bovine = Bovine(
        earring: data["earring"],
        name: data["name"] as String?,
        sex: Sex.values[data["sex"]],
        isBreeder: data["is_breeder"] == 1,
        hasBeenWeaned: data["has_been_weaned"] == 1,
        isReproducing: data["is_reproducing"] == 1,
        isPregnant: data["is_pregnant"] == 1,
        wasFinished: data["was_finished"] == 1,
      );

      return bovine;
    }).toList();
  }

  static Future<int> countBovines_({ BovinesSearch? search }) async {
    final queryAsEarring = int.tryParse(search?.filter?.query ?? '');

    final whereConditions = <String>[];

    final filter = search?.filter;

    if (filter?.query.isNotEmpty ?? false) {
      whereConditions.add("(bovines.name LIKE '%${filter!.query}%' ${queryAsEarring != null ? 'OR bovines.earring = $queryAsEarring' : ''})");
    }

    if (filter != null) {
      if (filter.sex != null) {
        whereConditions.add('bovines.sex = ${filter.sex!.index}');
      }
      if (filter.isBreeder != null) {
        whereConditions.add('bovines.is_breeder = ${filter.isBreeder! ? 1 : 0}');
      }
      if (filter.hasBeenWeaned != null) {
        whereConditions.add('bovines.has_been_weaned = ${filter.hasBeenWeaned! ? 1 : 0}');
      }
      if (filter.isReproducing != null) {
        whereConditions.add('bovines.is_reproducing = ${filter.isReproducing! ? 1 : 0}');
      }
      if (filter.isPregnant != null) {
        whereConditions.add('bovines.is_pregnant = ${filter.isPregnant! ? 1 : 0}');
      }
      if (filter.wasFinished != null) {
        whereConditions.add('bovines.was_finished = ${filter.wasFinished! ? 1 : 0}');
      }
    }

    final whereClause = whereConditions.isNotEmpty ? 'WHERE ${whereConditions.join(" AND ")}' : '';

    final order = search?.order;

    final ascOrDec = search?.ascendent ?? false ? "ASC" : "DESC";
    final nullsPosition = search?.ascendent ?? false ? "FIRST" : "LAST";

    String joinClause = "";

    String orderClause = "ORDER BY bovines.earring $ascOrDec";

    if (order != null) {
      switch (order) {
        case BovinesOrderField.earring:
          orderClause = "ORDER BY bovines.earring $ascOrDec";
        break;

        case BovinesOrderField.birthWeight:
          orderClause = "ORDER BY births.weight $ascOrDec";
          joinClause = "JOIN births ON births.bovine = bovines.earring";
        break;

        case BovinesOrderField.weaningWeight:
          orderClause = "ORDER BY weanings.weight $ascOrDec";
          joinClause = "JOIN weanings ON weanings.bovine = bovines.earring";
        break;

        case BovinesOrderField.yearlingWeight:
          orderClause = "ORDER BY yearling_weights.value $ascOrDec";
          joinClause = "JOIN yearling_weights ON yearling_weights.bovine = bovines.earring";
        break;

        default:
          break;
      }
    }

    final sql = '''
      SELECT
        COUNT(*)
      FROM bovines
      $joinClause
      $whereClause
      $orderClause NULLS $nullsPosition
    ''';

    final result = await database.customSelect(sql).getSingle();

    return result.data["COUNT(*)"];
  }

  static Future<Bovine?> getBovine(int earring) async {
    return (database.select(database.bovines)..where((b) => b.earring.equals(earring))).getSingleOrNull();
  }

  static Future<int> deleteBovine(int earring) async {
    return (database.delete(database.bovines)
                    ..where((b) => b.earring.equals(earring))).go();
  }

  static Future<int> saveBovineEntry(BovineEntry bovineEntry) async {
    final companion = BovinesEntryCompanion(
      bovine: Value(bovineEntry.bovine),
      weight: Value(bovineEntry.weight),
      date: Value(bovineEntry.date)
    );

    return database.into(database.bovinesEntry).insertOnConflictUpdate(companion);
  }

  static Future<BovineEntry?> getBovineEntry(int earring) async {
    return (database.select(database.bovinesEntry)..where((e) => e.bovine.equals(earring))).getSingleOrNull();
  }

  static Future<bool> doesEarringExists(int earring) async {
    final r = (database.select(database.bovines)
                       ..where((b) => b.earring.equals(earring)))
                       .getSingleOrNull();

    return r.then((v) => v != null);
  }

  static Future<int> countChildrenOfSex(int earring, Sex s) async {
    final result = await database.customSelect(
      """
        SELECT COUNT(*)
        FROM Parenting as p JOIN Bovines as b ON p.bovine = b.earring
        WHERE (p.bull = ? OR p.cow = ?) AND b.sex = ?;
      """,
      variables: [ Variable(earring), Variable(earring), Variable(s.index) ]
    ).getSingle();

    return result.data['COUNT(*)'] as int;
  }
}
