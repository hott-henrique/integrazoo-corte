import 'package:drift/drift.dart';

import 'package:integrazoo/domain/bovine.dart';


class Treatments extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get medicine => text()();
  TextColumn get reason => text()();

  DateTimeColumn get startingDate => dateTime()();
  DateTimeColumn get endingDate => dateTime()();

  IntColumn get bovine => integer().references(Bovines, #earring, onDelete: KeyAction.cascade)();
}
