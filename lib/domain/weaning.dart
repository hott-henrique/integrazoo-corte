import 'package:drift/drift.dart';

import 'package:integrazoo/domain/bovine.dart';


class Weanings extends Table {
  IntColumn get bovine => integer().references(Bovines, #earring, onDelete: KeyAction.cascade)();

  DateTimeColumn get date => dateTime()();
  RealColumn get weight => real().check(weight.isBiggerThan(const Constant(0.0)))();

  @override
  Set<Column> get primaryKey => { bovine };
}
