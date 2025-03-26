import 'dart:developer'; // ignore: unused_import

import 'package:integrazoo/backend.dart';


class RelatoryService {
  RelatoryService();

  static Future<int> countNonDiscardedFemaleBreeders() {
    return RelatoryPersistence.countNonDiscardedFemaleBreeders();
  }
  static Future<List<FemaleBreederStatistics>> getFemaleBreedersStatistics(int pageSize, int page) {
    return RelatoryPersistence.getFemaleBreedersStatistics(pageSize, page);
  }

  static Future<List<FemaleBreederStatistics>> getOffspringStatistics(int earring) {
    return RelatoryPersistence.getOffspringStatistics(earring);
  }
}
