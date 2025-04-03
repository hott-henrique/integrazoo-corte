import 'package:drift/drift.dart';


class Breeders extends Table {
  TextColumn get name => text()();

  TextColumn get father => text().nullable()();
  TextColumn get mother => text().nullable()();

  TextColumn get paternalGrandmother => text().nullable()();
  TextColumn get paternalGrandfather => text().nullable()();
  TextColumn get maternalGrandmother => text().nullable()();
  TextColumn get maternalGrandfather => text().nullable()();

  RealColumn get epdBirthWeight => real().nullable()();
  RealColumn get epdWeaningWeight => real().nullable()();
  RealColumn get epdYearlingWeight => real().nullable()();

  @override
  Set<Column> get primaryKey => { name };
}
