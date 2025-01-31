import 'dart:developer';

import 'package:integrazoo/persistence/relatory_persistence.dart';


class RelatoryController {
  RelatoryController();

  static Future<List<(String, double?, double?, double?, int?)>> getFemaleBreedersStatistics(int pageSize, int page) {
    return RelatoryPersistence.getFemaleBreedersStatistics(pageSize, page);
  }
}
