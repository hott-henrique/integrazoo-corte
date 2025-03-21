import 'package:drift/drift.dart';

import 'package:integrazoo/domain/enumerations.dart';


class Bovines extends Table {
  IntColumn get earring => integer()();
  TextColumn get name => text().nullable()();
  IntColumn get sex => intEnum<Sex>()();

  BoolColumn get isBreeder => boolean().withDefault(const Constant(false))();

  BoolColumn get hasBeenWeaned => boolean().withDefault(const Constant(false))();

  BoolColumn get isReproducing => boolean().withDefault(const Constant(false))();
  BoolColumn get isPregnant => boolean().withDefault(const Constant(false))();

  BoolColumn get wasDiscarded => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => { earring };
}
