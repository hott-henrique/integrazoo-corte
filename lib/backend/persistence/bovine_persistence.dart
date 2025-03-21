import 'dart:developer'; // ignore: unused_import

import 'package:drift/drift.dart';

import 'package:integrazoo/backend/database/database.dart';

import 'package:integrazoo/domain/enumerations.dart';


class BovinePersistence {
  BovinePersistence();

  static Future<int> saveBovine(Bovine bovine) async {
    final companion = BovinesCompanion.insert(
      earring: Value(bovine.earring),
      name: Value(bovine.name),
      sex: bovine.sex,
      wasDiscarded: Value(bovine.wasDiscarded),
      isReproducing: Value(bovine.isReproducing),
      isPregnant: Value(bovine.isPregnant),
      hasBeenWeaned: Value(bovine.hasBeenWeaned),
      isBreeder: Value(bovine.isBreeder),
    );

    return database.into(database.bovines).insertOnConflictUpdate(companion);
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
    bool? wasDiscarded,
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

                        if (wasDiscarded != null) {
                          cond = cond & b.wasDiscarded.equals(wasDiscarded);
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
    bool? wasDiscarded,
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

    if (wasDiscarded != null) {
      conditions.add("bo.wasDiscarded = ?");
      variables.insert(0, Variable(wasDiscarded ? 1 : 0));
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
        'wasDiscarded': row.data["was_discarded"] == 0 ? false : true,
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
    bool? wasDiscarded,
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

    if (wasDiscarded != null) {
      conditions.add("bo.wasDiscarded = ?");
      variables.insert(0, Variable(wasDiscarded ? 1 : 0));
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
        'wasDiscarded': row.data["was_discarded"] == 0 ? false : true,
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
    bool? wasDiscarded,
    bool? isReproducing,
    bool? isPregnant,
    bool? hasBeenWeaned,
  ) async {
    List<Bovine> bovines = await BovinePersistence.searchHerd(query, pageSz, page, s, wasDiscarded, isReproducing, isPregnant, hasBeenWeaned);
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

      if (wasDiscarded != null) {
        cond = cond && (b.wasDiscarded == wasDiscarded);
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
    bool? wasDiscarded,
    bool? isReproducing,
    bool? isPregnant,
    bool? hasBeenWeaned,
  ) async {
    List<Bovine> bovines = await BovinePersistence.searchHerd(query, pageSz, page, s, wasDiscarded, isReproducing, isPregnant, hasBeenWeaned);
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

      if (wasDiscarded != null) {
        cond = cond && (b.wasDiscarded == wasDiscarded);
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
