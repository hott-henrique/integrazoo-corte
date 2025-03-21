import 'dart:developer'; // ignore: unused_import

import 'package:integrazoo/backend/persistence/relatory_persistence.dart';


class RelatoryService {
  RelatoryService();

  static Future<int> countNonDiscardedFemaleBreeders() {
    return RelatoryPersistence.countNonDiscardedFemaleBreeders();
  }
  static Future<List<(String, double?, double?, double?, int?, int)>> getFemaleBreedersStatistics(int pageSize, int page) {
    return RelatoryPersistence.getFemaleBreedersStatistics(pageSize, page);
  }

  static Future<List<(String, double?, double?, double?, int?, int)>> getOffspringStatistics(int earring) {
    return RelatoryPersistence.getOffspringStatistics(earring);
  }
}
