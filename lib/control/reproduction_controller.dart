import 'dart:developer';

import 'package:integrazoo/persistence/reproduction_persistence.dart';

import 'package:integrazoo/database/database.dart';


class ReproductionController {
  ReproductionController();

  static Future<int> saveReproduction(Reproduction r) {
    return ReproductionPersistence.saveReproduction(r);
  }

  static Future<Reproduction?> getById(int id) {
    return ReproductionPersistence.getById(id);
  }

  static Future<void> delete(int id) {
    return ReproductionPersistence.delete(id);
  }

  static Future<Reproduction?> getActiveReproduction(int earring) {
    return ReproductionPersistence.getActiveReproduction(earring);
  }

  static Future<Reproduction?> getReproductionThatGeneratedAnimal(int earring) {
    return ReproductionPersistence.getReproductionThatGeneratedAnimal(earring);
  }

  static Future<List<(Bovine, Reproduction)>> getBovinesReproducing(int pageSize, int page) async {
    return ReproductionPersistence.getBovinesReproducing(pageSize, page);
  }
}
