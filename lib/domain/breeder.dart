import 'package:drift/drift.dart';


class Breeders extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().unique()();

  TextColumn get father => text().nullable()();
  TextColumn get mother => text().nullable()();

  TextColumn get paternalGrandmother => text().nullable()();
  TextColumn get paternalGrandfather => text().nullable()();
  TextColumn get maternalGrandmother => text().nullable()();
  TextColumn get maternalGrandfather => text().nullable()();

  RealColumn get epdBirthWeight => real().nullable()();
  RealColumn get epdWeaningWeight => real().nullable()();
  RealColumn get epdYearlingWeight => real().nullable()();
}
