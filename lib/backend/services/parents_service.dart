import 'dart:developer'; // ignore: unused_import

import 'package:integrazoo/backend/persistence/parents_persistence.dart';

import 'package:integrazoo/backend/database/database.dart';


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
