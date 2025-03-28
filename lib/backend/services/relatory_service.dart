import 'dart:developer'; // ignore: unused_import

import 'package:integrazoo/backend.dart';


class RelatoryService {
  RelatoryService();

  static Future<List<BovineStatistics>> getBovinesStatistics(List<Bovine> bovines) {
    return RelatoryPersistence.getBovinesStatistics(bovines);
  }

  static Future<List<BovineStatistics>> getOffspringStatistics(int earring) {
    return RelatoryPersistence.getOffspringStatistics(earring);
  }
}
