import 'dart:developer'; // ignore: unused_import

import 'package:integrazoo/backend/persistence/birth_persistence.dart';

import 'package:integrazoo/backend/database/database.dart';


class BirthService {
  BirthService();

  static Future<int> saveBirth(Birth b) {
    return BirthPersistence.saveBirth(b);
  }

  static Future<Birth?> getBirth(int earring) {
    return BirthPersistence.getBirth(earring);
  }

  static Future<void> deleteBirth(int earring) {
    return BirthPersistence.deleteBirth(earring);
  }

  static Future<Pregnancy?> getCowFirstBirth(int earring) {
    return BirthPersistence.getCowFirstBirth(earring);
  }
}
