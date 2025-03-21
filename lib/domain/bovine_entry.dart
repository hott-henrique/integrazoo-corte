import 'package:drift/drift.dart';

import 'package:integrazoo/domain/bovine.dart';


@DataClassName('BovineEntry')
class BovinesEntry extends Table {
  IntColumn get bovine => integer().references(Bovines, #earring, onDelete: KeyAction.cascade)();

  RealColumn get weight => real().nullable().check(weight.isBiggerThan(const Constant(0.0)))();
  DateTimeColumn get date => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => { bovine };
}
