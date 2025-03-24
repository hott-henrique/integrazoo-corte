import 'package:integrazoo/backend.dart';


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
