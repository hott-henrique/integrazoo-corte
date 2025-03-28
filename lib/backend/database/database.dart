import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'package:integrazoo/domain/bovine.dart';
import 'package:integrazoo/domain/bovine_entry.dart';
import 'package:integrazoo/domain/breeder.dart';
import 'package:integrazoo/domain/birth.dart';
import 'package:integrazoo/domain/weaning.dart';
import 'package:integrazoo/domain/yearling_weight.dart';
import 'package:integrazoo/domain/reproduction.dart';
import 'package:integrazoo/domain/parents.dart';
import 'package:integrazoo/domain/pregnancy.dart';
import 'package:integrazoo/domain/treatment.dart';
import 'package:integrazoo/domain/finish.dart';

export 'package:integrazoo/domain/relatories/bovine_statistics.dart';

// INFO: This import fix errors in 'database.g.dart'.
import 'package:integrazoo/domain/enumerations.dart';

export 'package:integrazoo/domain/enumerations.dart';

part 'database.g.dart';


@DriftDatabase(tables: [
  Bovines,
  BovinesEntry,
  Breeders,
  Births,
  Weanings,
  YearlingWeights,
  Reproductions,
  Parenting,
  Pregnancies,
  Treatments,
  Finishes,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'BANCO_DE_DADOS_INTEGRAZOO_BOVINO_DE_CORTE');
  }
}

late AppDatabase database;
