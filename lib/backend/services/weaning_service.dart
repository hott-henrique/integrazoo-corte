import 'dart:developer'; // ignore: unused_import

import 'package:integrazoo/backend/persistence/weaning_persistence.dart';

import 'package:integrazoo/backend/database/database.dart';


class WeaningService {
  WeaningService();

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
