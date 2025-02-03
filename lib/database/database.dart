import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database.g.dart';

enum Sex {
  male, female;

  @override
  String toString() {
    switch (this) {
      case Sex.male:
        return "Macho";

      case Sex.female:
        return "Fêmea";
    }
  }
}

class Bovines extends Table {
  IntColumn get earring => integer()();
  TextColumn get name => text().nullable()();
  IntColumn get sex => intEnum<Sex>()();

  BoolColumn get hasBeenWeaned => boolean().withDefault(const Constant(false))();
  BoolColumn get isReproducing => boolean().withDefault(const Constant(false))();
  BoolColumn get isPregnant => boolean().withDefault(const Constant(false))();
  BoolColumn get wasDiscarded => boolean().withDefault(const Constant(false))();

  BoolColumn get isBreeder => boolean().withDefault(const Constant(false))();

  RealColumn get weight540 => real().check(weight540.isBiggerThan(const Constant(0.0))).nullable()();

  @override
  Set<Column> get primaryKey => { earring };
}

@DataClassName('BovineEntry')
class BovinesEntry extends Table {
  IntColumn get bovine => integer().references(Bovines, #earring, onDelete: KeyAction.cascade)();

  RealColumn get weight => real().nullable().check(weight.isBiggerThan(const Constant(0.0)))();
  DateTimeColumn get date => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => { bovine };
}

class Breeders extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().unique()();

  TextColumn get father => text().nullable()();
  TextColumn get mother => text().nullable()();

  TextColumn get paternalGrandmother => text().nullable()();
  TextColumn get paternalGrandfather => text().nullable()();
  TextColumn get maternalGrandmother => text().nullable()();
  TextColumn get maternalGrandfather => text().nullable()();

  RealColumn get epdBirthWeight => real().nullable()();
  RealColumn get epdWeaningWeight => real().nullable()();
  RealColumn get epdYearlingWeight => real().nullable()();
}

enum FinishingReason {
  discard,
  sell,
  death,
  slaughter;

  @override
  String toString() {
    switch (this) {
      case discard:
        return 'Descarte';

      case death:
        return 'Morte';

      case sell:
        return 'Venda';

      case slaughter:
        return 'Abate';
    }
  }
}

@DataClassName('Finish')
class Finishes extends Table {
  IntColumn get bovine => integer().references(Bovines, #earring, onDelete: KeyAction.cascade)();

  IntColumn get reason => intEnum<FinishingReason>()();
  DateTimeColumn get date => dateTime()();
  TextColumn get observation => text().nullable()();

  RealColumn get weight => real().nullable().check(weight.isBiggerThan(const Constant(0.0)))();
  RealColumn get hotCarcassWeight => real().nullable().check(hotCarcassWeight.isBiggerThan(const Constant(0.0)))();

  @override
  Set<Column> get primaryKey => { bovine };
}

enum ReproductionDiagonostic {
  positive,
  negative,
  waiting;

  @override
  String toString() {
    switch (this) {
      case positive:
        return 'Positivo';

      case negative:
        return 'Negativo';

      case waiting:
        return 'Esperando';
    }
  }
}

enum ReproductionKind {
  artificialInsemination,
  coverage;

  @override
  String toString() {
    switch (this) {
      case artificialInsemination:
        return 'Inseminação Artificial';

      case coverage:
        return 'Monta';
    }
  }
}

class Reproductions extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get kind => intEnum<ReproductionKind>()();
  DateTimeColumn get date => dateTime()();

  IntColumn get diagnostic => intEnum<ReproductionDiagonostic>().withDefault(Constant(ReproductionDiagonostic.waiting.index))();

  IntColumn get cow => integer().references(Bovines, #earring, onDelete: KeyAction.cascade)();

  IntColumn get bull => integer().references(Bovines, #earring, onDelete: KeyAction.setNull).nullable()();

  TextColumn get breeder => text().references(Breeders, #name, onDelete: KeyAction.setNull).nullable()();
  IntColumn get strawNumber => integer().nullable()();
}

@DataClassName('Pregnancy')
class Pregnancies extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get cow => integer().references(Bovines, #earring, onDelete: KeyAction.cascade)();

  DateTimeColumn get date => dateTime()();

  DateTimeColumn get birthForecast => dateTime()();

  IntColumn get reproduction => integer().nullable().references(Reproductions, #id)();

  BoolColumn get hasEnded => boolean().withDefault(const Constant(false))();

  TextColumn get observation => text().nullable()();
}

enum BodyConditionScore {
  cachetic,
  lean,
  ideal,
  fat,
  obese;

  @override
  String toString() {
    switch (this) {
      case BodyConditionScore.cachetic:
        return "Caquético";

      case BodyConditionScore.lean:
        return "Magro";

      case BodyConditionScore.ideal:
        return "Ideal";

      case BodyConditionScore.fat:
        return "Gordo";

      case BodyConditionScore.obese:
        return "Obeso";
    }
  }
}

class Births extends Table {
  IntColumn get bovine => integer().references(Bovines, #earring, onDelete: KeyAction.cascade)();

  DateTimeColumn get date => dateTime()();
  RealColumn get weight => real().check(weight.isBiggerThan(const Constant(0.0)))();
  IntColumn get bcs => intEnum<BodyConditionScore>()();

  IntColumn get pregnancy => integer().nullable().references(Pregnancies, #id)();

  @override
  Set<Column> get primaryKey => { bovine };
}

@DataClassName('Parents')
class Parenting extends Table {
  IntColumn get bovine => integer().references(Bovines, #earring, onDelete: KeyAction.cascade)();

  IntColumn get cow => integer().references(Bovines, #earring, onDelete: KeyAction.setNull).nullable()();

  IntColumn get bull => integer().references(Bovines, #earring, onDelete: KeyAction.setNull).nullable()();
  TextColumn get breeder => text().references(Breeders, #name, onDelete: KeyAction.setNull).nullable()();

  @override
  Set<Column> get primaryKey => { bovine };
}

class Weanings extends Table {
  IntColumn get bovine => integer().references(Bovines, #earring, onDelete: KeyAction.cascade)();

  DateTimeColumn get date => dateTime()();
  RealColumn get weight => real().check(weight.isBiggerThan(const Constant(0.0)))();

  @override
  Set<Column> get primaryKey => { bovine };
}

class Weight540 extends Table {
  IntColumn get bovine => integer().references(Bovines, #earring, onDelete: KeyAction.cascade)();


  @override
  Set<Column> get primaryKey => { bovine };
}

class Treatments extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get medicine => text()();
  TextColumn get reason => text()();

  DateTimeColumn get startingDate => dateTime()();
  DateTimeColumn get endingDate => dateTime()();

  IntColumn get bovine => integer().references(Bovines, #earring, onDelete: KeyAction.cascade)();
}

@DriftDatabase(tables: [
  Bovines,
  BovinesEntry,
  Breeders,
  Finishes,
  Reproductions,
  Pregnancies,
  Births,
  Parenting,
  Weanings,
  Treatments,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'integrazoo');
  }
}
