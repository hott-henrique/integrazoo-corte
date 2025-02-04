import 'dart:developer';

import 'package:integrazoo/persistence/birth_persistence.dart';

import 'package:integrazoo/database/database.dart';


class BirthController {
  BirthController();

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
