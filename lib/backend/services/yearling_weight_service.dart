import 'dart:developer'; // ignore: unused_import

import 'package:integrazoo/backend/persistence/yearling_weight_persistence.dart';

import 'package:integrazoo/backend/database/database.dart';


class YearlingWeightService {
  YearlingWeightService();

  static Future<int> saveYearlingWeight(YearlingWeight b) {
    return YearlingWeightPersistence.saveYearlingWeight(b);
  }

  static Future<YearlingWeight?> getYearlingWeight(int earring) {
    return YearlingWeightPersistence.getYearlingWeight(earring);
  }

  static Future<void> deleteYearlingWeight(int earring) {
    return YearlingWeightPersistence.deleteYearlingWeight(earring);
  }
}
