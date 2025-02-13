import 'dart:developer';

import 'package:integrazoo/persistence/relatory_persistence.dart';


class RelatoryController {
  RelatoryController();

  static Future<List<(String, double?, double?, double?, int?, int)>> getFemaleBreedersStatistics(int pageSize, int page) {
    return RelatoryPersistence.getFemaleBreedersStatistics(pageSize, page);
  }

  static Future<List<(String, double?, double?, double?, int?, int)>> getOffspringStatistics(int earring) {
    return RelatoryPersistence.getOffspringStatistics(earring);
  }
}
