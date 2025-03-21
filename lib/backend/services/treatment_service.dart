import 'dart:developer'; // ignore: unused_import

import 'package:integrazoo/backend/persistence/treatment_persistence.dart';

import 'package:integrazoo/backend/database/database.dart';


class TreatmentService {
  TreatmentService();

  static Future<int> saveTreatment(Treatment t) {
    return TreatmentPersistence.saveTreatment(t);
  }

  static Future<Treatment?> getTreatment(int id) {
    return TreatmentPersistence.getTreatment(id);
  }

  static Future<void> delete(int id) {
    return TreatmentPersistence.delete(id);
  }

  static Future<int> countTreatments() {
    return TreatmentPersistence.countTreatments();
  }

  static Future<List<Treatment>> getTreatments(int pageSize, int page) {
    return TreatmentPersistence.getTreatments(pageSize, page);
  }

  static Future<int> countActiveTreatments() {
    return TreatmentPersistence.countActiveTreatments();
  }

  static Future<List<(Bovine, Treatment)>> getBovinesInTreatment(int pageSize, int page) {
    return TreatmentPersistence.getBovinesInTreatment(pageSize, page);
  }
}
