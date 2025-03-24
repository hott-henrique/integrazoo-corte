import 'package:integrazoo/backend.dart';


class BreederService {
  BreederService();

  static Future<int> saveBreeder(Breeder breeder) {
    return BreederPersistence.saveBreeder(breeder);
  }

  static Future<Breeder?> getBreeder(String name) async {
    return BreederPersistence.getBreeder(name);
  }

  static Future<int> countBreeders() async {
    return BreederPersistence.countBreeders();
  }

  static Future<List<Breeder>> getBreeders(int pageSz, int page) async {
    return BreederPersistence.getBreeders(pageSz, page);
  }

  static Future<List<Breeder>> searchBreeders(String? query, int pageSz, int page) async {
    return BreederPersistence.searchBreeder(query, pageSz, page);
  }

  static Future<int> deleteBreeder(String name) {
    return BreederPersistence.deleteBreeder(name);
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
