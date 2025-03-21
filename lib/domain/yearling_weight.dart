import 'package:drift/drift.dart';

import 'package:integrazoo/domain/bovine.dart';


class YearlingWeights extends Table {
  IntColumn get bovine => integer().references(Bovines, #earring, onDelete: KeyAction.cascade)();

  RealColumn get value => real().check(value.isBiggerThan(const Constant(0.0)))();

  @override
  Set<Column> get primaryKey => { bovine };
}
