import 'dart:developer';

import 'package:integrazoo/persistence/weaning_persistence.dart';

import 'package:integrazoo/database/database.dart';


class WeaningController {
  WeaningController();

  static Future<int> saveWeaning(Weaning w) {
    return WeaningPersistence.saveWeaning(w);
  }

  static Future<Weaning?> getWeaning(int earring) {
    return WeaningPersistence.getWeaning(earring);
  }

  static Future<int?> deleteWeaning(int earring) {
    return WeaningPersistence.deleteWeaning(earring);
  }

  static Future<int> countWeanings() {
    return WeaningPersistence.countWeanings();
  }

  static Future<List<Weaning>> getWeanings(int pageSize, int page) {
    return WeaningPersistence.getWeanings(pageSize, page);
  }
}
