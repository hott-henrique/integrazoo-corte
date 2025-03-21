import 'package:drift/drift.dart';

import 'package:integrazoo/domain/bovine.dart';
import 'package:integrazoo/domain/enumerations.dart';


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
