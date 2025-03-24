import 'package:integrazoo/backend.dart';


class ParentsService {
  ParentsService();

  static Future<int> saveParents(Parents p) {
    return ParentsPersistence.saveParents(p);
  }

  static Future<Parents?> getParents(int earring) {
    return ParentsPersistence.getParents(earring);
  }

  static Future<int> deleteParents(int earring) {
    return ParentsPersistence.deleteParents(earring);
  }
}
