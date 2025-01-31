import 'package:integrazoo/persistence/breeder_persistence.dart';

import 'package:integrazoo/database/database.dart';


class BreederController {
  BreederController();

  static Future<Breeder?> getBreeder(String name) async {
    return BreederPersistence.getBreeder(name);
  }

  static Future<List<Breeder>> readBreeders(int pageSz, int page) async {
    return BreederPersistence.readBreeders(pageSz, page);
  }

  static Future<List<Breeder>> searchBreeders(String? query, int pageSz, int page) async {
    return BreederPersistence.searchBreeder(query, pageSz, page);
  }

  static Future<int> saveBreeder(Breeder breeder) {
    return BreederPersistence.saveBreeder(breeder);
  }

  static Future<int> countChildrenOfSex(String breeder, Sex s) {
    return BreederPersistence.countChildrenOfSex(breeder, s);
  }

  static Future<double> getAverageBirthWeight(String breeder) {
    return BreederPersistence.getAverageBirthWeight(breeder);
  }

  static Future<double> getAverageWeaningWeight(String breeder) {
    return BreederPersistence.getAverageWeaningWeight(breeder);
  }
}
