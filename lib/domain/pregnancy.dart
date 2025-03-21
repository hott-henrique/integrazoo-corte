import 'package:drift/drift.dart';

import 'package:integrazoo/domain/bovine.dart';
import 'package:integrazoo/domain/reproduction.dart';


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
