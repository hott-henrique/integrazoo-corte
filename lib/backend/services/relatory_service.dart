import 'dart:developer'; // ignore: unused_import

import 'package:integrazoo/backend.dart';


class RelatoryService {
  RelatoryService();

  static Future<int> countNonDiscardedFemaleBreeders() {
    return RelatoryPersistence.countNonDiscardedFemaleBreeders();
  }
  static Future<List<FemaleBreederStatistics>> getFemaleBreedersStatistics(int pageSize, int page) {
    try {
      return RelatoryPersistence.getFemaleBreedersStatistics(pageSize, page);
    } catch (e) {
      print(e);
      inspect(e);
      rethrow;
    }
  }

  static Future<List<(String, double?, double?, double?, int?, int)>> getOffspringStatistics(int earring) {
    return RelatoryPersistence.getOffspringStatistics(earring);
  }
}
