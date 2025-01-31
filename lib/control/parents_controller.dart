import 'dart:developer';

import 'package:integrazoo/persistence/parents_persistence.dart';

import 'package:integrazoo/database/database.dart';


class ParentsController {
  ParentsController();

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
