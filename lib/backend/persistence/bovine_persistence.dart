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
          joinClause = "LEFT OUTER JOIN births ON births.bovine = bovines.earring";
        break;

        case BovinesOrderField.weaningWeight:
          orderClause = "ORDER BY weanings.weight $ascOrDec";
          joinClause = "LEFT OUTER JOIN weanings ON weanings.bovine = bovines.earring";
        break;

        case BovinesOrderField.yearlingWeight:
          orderClause = "ORDER BY yearling_weights.value $ascOrDec";
          joinClause = "LEFT OUTER JOIN yearling_weights ON yearling_weights.bovine = bovines.earring";
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

  // static Future<List<Bovine>> getBovines_(int pageSize, int page, { BovinesFilter? filter }) async {
  //   int? queryAsEarring = int.tryParse(filter?.query ?? "");

  //   // TODO: Sorting, peso ao nascimento, peso a demama, peso ao sobreano, peso ao abate.
  //   // Ascendente e descedente.
  //   final bovinesQuery = (database.selectOnly(database.bovines)
  //     ..addColumns(database.bovines.$columns)
  //     ..join([
  //       innerJoin(
  //         database.weanings,
  //         database.weanings.bovine.equalsExp(database.bovines.earring),
  //       )
  //     ])
  //     ..where(
  //       Expression.and([
  //         Expression.or([
  //           database.bovines.name.like("%${filter?.query ?? ''}%"),
  //           if (queryAsEarring != null) database.bovines.earring.equals(queryAsEarring),
  //         ]),
  //         if (filter != null) ...[
  //           if (filter.sex != null) database.bovines.sex.equals(filter.sex!.index),
  //           if (filter.isBreeder != null) database.bovines.isBreeder.equals(filter.isBreeder!),
  //           if (filter.hasBeenWeaned != null) database.bovines.hasBeenWeaned.equals(filter.hasBeenWeaned!),
  //           if (filter.isReproducing != null) database.bovines.isReproducing.equals(filter.isReproducing!),
  //           if (filter.isPregnant != null) database.bovines.isPregnant.equals(filter.isPregnant!),
  //           if (filter.wasFinished != null) database.bovines.wasFinished.equals(filter.wasFinished!),
  //         ]
  //       ])
  //     )
  //     ..orderBy([
  //       // if (sortColumn != null)
  //       OrderingTerm(expression: database.weanings.weight, mode: OrderingMode.desc, nulls: NullsOrder.last)
  //     ])
  //     ..limit(pageSize, offset: page * pageSize)
  //   );

  //   final rows = await bovinesQuery.get();

  //   inspect(rows);

  //   return rows.map((row) {
  //     final data = row.rawData.data;
  //     return Bovine(
  //       earring: data["bovines.earring"],
  //       name: data["bovines.name"] as String?,
  //       sex: Sex.values[data["bovines.sex"]],
  //       isBreeder: data["bovines.is_breeder"] == 1,
  //       hasBeenWeaned: data["bovines.has_been_weaned"] == 1,
  //       isReproducing: data["bovines.is_reproducing"] == 1,
  //       isPregnant: data["bovines.is_pregnant"] == 1,
  //       wasFinished: data["bovines.was_discarded"] == 1,
  //     );
  //   }).toList();

  //   // return rows.map((row) => row.readTable(database.bovines)).toList();
  // }

  static Future<int> countBovines_({ BovinesFilter? filter }) async {
    int? queryAsEarring = int.tryParse(filter?.query ?? "");

    final countExp = database.bovines.earring.count();
    final countQuery = (database.selectOnly(database.bovines)
      ..addColumns([ countExp ])
      ..where(
        Expression.and([
          Expression.or([
            database.bovines.name.like("%${filter?.query ?? ''}%"),
            if (queryAsEarring != null) database.bovines.earring.equals(queryAsEarring),
          ]),
          if (filter != null) ...[
            if (filter.sex != null) database.bovines.sex.equals(filter.sex!.index),
            if (filter.isBreeder != null) database.bovines.isBreeder.equals(filter.isBreeder!),
            if (filter.hasBeenWeaned != null) database.bovines.hasBeenWeaned.equals(filter.hasBeenWeaned!),
            if (filter.isReproducing != null) database.bovines.isReproducing.equals(filter.isReproducing!),
            if (filter.isPregnant != null) database.bovines.isPregnant.equals(filter.isPregnant!),
            if (filter.wasFinished != null) database.bovines.wasFinished.equals(filter.wasFinished!),
          ]
        ])
      )
    );

    final countRow = await countQuery.getSingle();

    return countRow.read(countExp)!;
  }

  static Future<Bovine?> getBovine(int earring) async {
    return (database.select(database.bovines)..where((b) => b.earring.equals(earring))).getSingleOrNull();
  }

  static Future<int> countBovines() async {
    final result = await database.customSelect(
      """
        SELECT COUNT(*)
        FROM Bovines b
      """,
    ).getSingle();

    return result.read<int>("COUNT(*)");
  }

  static Future<List<Bovine>> getBovines(int pageSize, int page) async {
    return (database.select(database.bovines)..limit(pageSize, offset: page * pageSize)).get();
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

  static Future<List<Bovine>> searchHerd(
    String? query,
    int pageSz, int page,
    Sex? s,
    bool? wasFinished,
    bool? isReproducing,
    bool? isPregnant,
    bool? hasBeenWeaned,
  ) async {
    return (database.select(database.bovines)
                    ..where(
                      (b) {
                        query ??= "";

                        late Expression<bool> cond;

                        cond = b.name.like("%$query%");

                        if (query?.isEmpty == true) {
                          cond = cond | b.name.isNull();
                        }

                        int? queryAsNum = int.tryParse(query!);

                        if (queryAsNum != null) {
                          cond = cond | b.earring.equals(queryAsNum);
                        }

                        if (s != null) {
                          cond = cond & b.sex.equals(s.index);
                        }

                        if (wasFinished != null) {
                          cond = cond & b.wasFinished.equals(wasFinished);
                        }

                        if (isReproducing != null) {
                          cond = cond & b.isReproducing.equals(isReproducing);
                        }

                        if (isPregnant != null) {
                          cond = cond & b.isPregnant.equals(isPregnant);
                        }

                        if (hasBeenWeaned != null) {
                          cond = cond & b.hasBeenWeaned.equals(hasBeenWeaned);
                        }

                        return cond;
                      }
                    )
                    ..orderBy([ (b) => OrderingTerm(expression: b.earring, mode: OrderingMode.desc) ])
                    ..limit(pageSz, offset: page * pageSz))
                    .get();
  }

  static Future<List<Bovine>> searchHerdSortByBirthWeight(
    String? query,
    int pageSz,
    int page,
    Sex? s,
    bool? wasFinished,
    bool? isReproducing,
    bool? isPregnant,
    bool? hasBeenWeaned,
  ) async {
    final conditions = <String>[];
    final variables = <Variable>[ Variable(pageSz), Variable(page * pageSz) ];

    if (query != null && query.isNotEmpty) {
      conditions.add("(bo.name LIKE ? OR bo.earring LIKE ?)");
      variables.insertAll(0, [Variable('%$query%'), Variable('%$query%')]);
    }

    if (s != null) {
      conditions.add("bo.sex = ?");
      variables.insert(0, Variable(s.index));
    }

    if (wasFinished != null) {
      conditions.add("bo.wasFinished = ?");
      variables.insert(0, Variable(wasFinished ? 1 : 0));
    }

    if (isReproducing != null) {
      conditions.add("bo.isReproducing = ?");
      variables.insert(0, Variable(isReproducing ? 1 : 0));
    }

    if (isPregnant != null) {
      conditions.add("bo.isPregnant = ?");
      variables.insert(0, Variable(isPregnant ? 1 : 0));
    }

    if (hasBeenWeaned != null) {
      conditions.add("bo.hasBeenWeaned = ?");
      variables.insert(0, Variable(hasBeenWeaned ? 1 : 0));
    }

    final whereClause = conditions.isNotEmpty ? "WHERE ${conditions.join(' AND ')}" : "";

    final result = await database.customSelect(
      """
        SELECT bo.*
        FROM Bovines AS bo
        LEFT JOIN Births AS bi ON bo.earring = bi.bovine
        $whereClause
        ORDER BY bi.weight NULLS LAST
        LIMIT ?
        OFFSET ?
      """,
      variables: variables,
    ).get();

    return result.map((row) {
      return Bovine.fromJson({
        'earring': row.data["earring"] as int,
        'name': row.data["name"] as String?,
        'sex': row.data["sex"] as int,
        'wasFinished': row.data["was_finished"] == 0 ? false : true,
        'isReproducing': row.data["is_reproducing"] == 0 ? false : true,
        'isPregnant': row.data["is_pregnant"] == 0 ? false : true,
        'hasBeenWeaned': row.data["has_been_weaned"] == 0 ? false : true,
        'isBreeder': row.data["is_breeder"] == 0 ? false : true,
      });
    }).toList();
  }

  static Future<List<Bovine>> searchHerdSortByWeaningWeight(
    String? query,
    int pageSz,
    int page,
    Sex? s,
    bool? wasFinished,
    bool? isReproducing,
    bool? isPregnant,
    bool? hasBeenWeaned,
  ) async {
    final conditions = <String>[];
    final variables = <Variable>[ Variable(pageSz), Variable(page * pageSz) ];

    if (query != null && query.isNotEmpty) {
      conditions.add("(bo.name LIKE ? OR bo.earring LIKE ?)");
      variables.insertAll(0, [Variable('%$query%'), Variable('%$query%')]);
    }

    if (s != null) {
      conditions.add("bo.sex = ?");
      variables.insert(0, Variable(s.index));
    }

    if (wasFinished != null) {
      conditions.add("bo.wasFinished = ?");
      variables.insert(0, Variable(wasFinished ? 1 : 0));
    }

    if (isReproducing != null) {
      conditions.add("bo.isReproducing = ?");
      variables.insert(0, Variable(isReproducing ? 1 : 0));
    }

    if (isPregnant != null) {
      conditions.add("bo.isPregnant = ?");
      variables.insert(0, Variable(isPregnant ? 1 : 0));
    }

    if (hasBeenWeaned != null) {
      conditions.add("bo.hasBeenWeaned = ?");
      variables.insert(0, Variable(hasBeenWeaned ? 1 : 0));
    }

    final whereClause = conditions.isNotEmpty ? "WHERE ${conditions.join(' AND ')}" : "";

    final result = await database.customSelect(
      """
        SELECT bo.*
        FROM Bovines AS bo
        LEFT JOIN Weanings AS w ON bo.earring = w.bovine
        $whereClause
        ORDER BY w.weight DESC NULLS LAST
        LIMIT ?
        OFFSET ?
      """,
      variables: variables,
    ).get();

    return result.map((row) {
      return Bovine.fromJson({
        'earring': row.data["earring"] as int,
        'name': row.data["name"] as String?,
        'sex': row.data["sex"] as int,
        'wasFinished': row.data["was_discarded"] == 0 ? false : true,
        'isReproducing': row.data["is_reproducing"] == 0 ? false : true,
        'isPregnant': row.data["is_pregnant"] == 0 ? false : true,
        'hasBeenWeaned': row.data["has_been_weaned"] == 0 ? false : true,
        'isBreeder': row.data["is_breeder"] == 0 ? false : true,
      });
    }).toList();
  }

  static Future<List<Bovine>> searchHerdSortByChildrenBirthWeight(
    String? query,
    int pageSz,
    int page,
    Sex? s,
    bool? wasFinished,
    bool? isReproducing,
    bool? isPregnant,
    bool? hasBeenWeaned,
  ) async {
    List<Bovine> bovines = await BovinePersistence.searchHerd(query, pageSz, page, s, wasFinished, isReproducing, isPregnant, hasBeenWeaned);
    Map<int, double> performance = {};

    bovines.where((b) {
      bool cond = true;

      int? queryAsNum = int.tryParse(query ?? "");

      if (query != null && query.isNotEmpty && b.name != null) {
        cond = b.name!.toLowerCase().contains(query.toLowerCase());
      }

      if (queryAsNum != null) {
        cond = cond || b.earring == queryAsNum;
      }

      if (wasFinished != null) {
        cond = cond && (b.wasFinished == wasFinished);
      }

      if (isReproducing != null) {
        cond = cond && (b.isReproducing == isReproducing);
      }

      if (isPregnant != null) {
        cond = cond && (b.isPregnant == isPregnant);
      }

      if (hasBeenWeaned != null) {
        cond = cond && (b.hasBeenWeaned == hasBeenWeaned);
      }

      return cond;
    });

    for (int i = 0; i < bovines.length; i = i + 1) {
      final row = await database.customSelect("""
        SELECT AVG(b.weight) as avg_children_birth_weight
        FROM Births as b JOIN Parenting as p ON b.bovine = p.bovine
        WHERE p.bull = ? OR p.cow = ?;
      """, variables: [ Variable(bovines[i].earring), Variable(bovines[i].earring) ]).getSingle();

      final avgBirthWeight = (row.data["avg_children_birth_weight"] ?? 0.0) as double;

      performance[bovines[i].earring] =  avgBirthWeight;
    }

    bovines.sort((a, b) => performance[a.earring]!.compareTo(performance[b.earring]!));

    return bovines;
  }

  static Future<List<Bovine>> searchHerdSortByChildrenWeaningWeight(
    String? query,
    int pageSz,
    int page,
    Sex? s,
    bool? wasFinished,
    bool? isReproducing,
    bool? isPregnant,
    bool? hasBeenWeaned,
  ) async {
    List<Bovine> bovines = await BovinePersistence.searchHerd(query, pageSz, page, s, wasFinished, isReproducing, isPregnant, hasBeenWeaned);
    Map<int, double> performance = {};

    bovines.where((b) {
      bool cond = true;

      int? queryAsNum = int.tryParse(query ?? "");

      if (query != null && query.isNotEmpty && b.name != null) {
        cond = b.name!.toLowerCase().contains(query.toLowerCase());
      }

      if (queryAsNum != null) {
        cond = cond || b.earring == queryAsNum;
      }

      if (wasFinished != null) {
        cond = cond && (b.wasFinished == wasFinished);
      }

      if (isReproducing != null) {
        cond = cond && (b.isReproducing == isReproducing);
      }

      if (isPregnant != null) {
        cond = cond && (b.isPregnant == isPregnant);
      }

      if (hasBeenWeaned != null) {
        cond = cond && (b.hasBeenWeaned == hasBeenWeaned);
      }

      return cond;
    });

    for (int i = 0; i < bovines.length; i = i + 1) {
      final row = await database.customSelect("""
        SELECT AVG(w.weight) as avg_children_weaning_weight
        FROM Weanings as w JOIN Parenting as p ON w.bovine = p.bovine
        WHERE p.bull = ? OR p.cow = ?;
      """, variables: [ Variable(bovines[i].earring), Variable(bovines[i].earring) ]).getSingle();

      final avgWeaningWeight = (row.data["avg_weaning_birth_weight"] ?? 0.0) as double;

      performance[bovines[i].earring] =  avgWeaningWeight;
    }

    bovines.sort((a, b) => performance[b.earring]!.compareTo(performance[a.earring]!));


    return bovines;
  }

  static Future<int> getCountBovines() async {
    final r = database.customSelect("SELECT COUNT(*) AS count FROM BOVINES;").getSingle();

    return r.then((v) => v.data["count"] + 1);
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
