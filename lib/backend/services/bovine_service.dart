import 'package:integrazoo/backend.dart';


class BovineService {
  BovineService();

  static Future<int> saveBovine(Bovine bovine) {
    return BovinePersistence.saveBovine(bovine);
  }

  static Future<Bovine?> getBovine(int earring) async {
    return BovinePersistence.getBovine(earring);
  }

  static Future<int> countBovines_({ BovinesSearch? search }) async {
    return BovinePersistence.countBovines_(search: search);
  }

  static Future<List<Bovine>> getBovines_(int pageSize, int page, { BovinesSearch? search }) async {
    return BovinePersistence.getBovines_(pageSize, page, search: search);
  }

  static Future<int> deleteBovine(int earring) async {
    return BovinePersistence.deleteBovine(earring);
  }

  static Future<int> saveBovineEntry(BovineEntry bovineEntry) {
    return BovinePersistence.saveBovineEntry(bovineEntry);
  }

  static Future<BovineEntry?> getBovineEntry(int earring) async {
    return BovinePersistence.getBovineEntry(earring);
  }

  static Future<bool> doesEarringExists(int earring) {
    return BovinePersistence.doesEarringExists(earring);
  }

  static Future<int> countChildrenOfSex(int earring, Sex s) {
    return BovinePersistence.countChildrenOfSex(earring, s);
  }
}
