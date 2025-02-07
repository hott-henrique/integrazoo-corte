import 'dart:developer';

import 'package:integrazoo/persistence/pregnancy_persistence.dart';

import 'package:integrazoo/database/database.dart';


class PregnancyController {
  PregnancyController();

  static Future<int> savePregnancy(Pregnancy p) {
    return PregnancyPersistence.savePregnancy(p);
  }

  static Future<Pregnancy?> getActivePregnancy(int earring) {
    return PregnancyPersistence.getActivePregnancy(earring);
  }

  static Future<int> delete(int id) {
    return PregnancyPersistence.delete(id);
  }

  static Future<int> countBovinesPregnant() {
    return PregnancyPersistence.countBovinesPregnant();
  }

  static Future<List<(Bovine, Pregnancy)>> getBovinesPregnant(int pageSize, int page) {
    return PregnancyPersistence.getBovinesPregnant(pageSize, page);
  }
}
