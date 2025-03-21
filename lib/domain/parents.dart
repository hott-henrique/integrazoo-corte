import 'package:drift/drift.dart';

import 'package:integrazoo/domain/bovine.dart';
import 'package:integrazoo/domain/breeder.dart';


@DataClassName('Parents')
class Parenting extends Table {
  IntColumn get bovine => integer().references(Bovines, #earring, onDelete: KeyAction.cascade)();

  IntColumn get cow => integer().references(Bovines, #earring, onDelete: KeyAction.setNull).nullable()();

  IntColumn get bull => integer().references(Bovines, #earring, onDelete: KeyAction.setNull).nullable()();
  TextColumn get breeder => text().references(Breeders, #name, onDelete: KeyAction.setNull).nullable()();

  @override
  Set<Column> get primaryKey => { bovine };
}
