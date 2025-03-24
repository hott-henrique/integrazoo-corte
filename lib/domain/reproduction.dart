import 'package:drift/drift.dart';

import 'package:integrazoo/domain/bovine.dart';
import 'package:integrazoo/domain/breeder.dart';

import 'package:integrazoo/domain/enumerations.dart';


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
