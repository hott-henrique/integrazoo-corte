import 'package:drift/drift.dart';

import 'package:integrazoo/domain/bovine.dart';
import 'package:integrazoo/domain/pregnancy.dart';
import 'package:integrazoo/domain/enumerations.dart';


class Births extends Table {
  IntColumn get bovine => integer().references(Bovines, #earring, onDelete: KeyAction.cascade)();

  DateTimeColumn get date => dateTime()();
  RealColumn get weight => real().check(weight.isBiggerThan(const Constant(0.0)))();
  IntColumn get bcs => intEnum<BodyConditionScore>()();

  IntColumn get pregnancy => integer().nullable().references(Pregnancies, #id)();

  @override
  Set<Column> get primaryKey => { bovine };
}
