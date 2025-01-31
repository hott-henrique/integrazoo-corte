import 'dart:developer';

import 'package:integrazoo/persistence/treatment_persistence.dart';

import 'package:integrazoo/database/database.dart';


class TreatmentController {
  TreatmentController();

  static Future<int> saveTreatment(Treatment t) {
    return TreatmentPersistence.saveTreatment(t);
  }

  static Future<Treatment?> getTreatment(int id) {
    return TreatmentPersistence.getTreatment(id);
  }

  static Future<void> delete(int id) {
    return TreatmentPersistence.delete(id);
  }

  static Future<List<(Bovine, Treatment)>> getBovinesInTreatment(int pageSize, int page) {
    return TreatmentPersistence.getBovinesInTreatment(pageSize, page);
  }
}
