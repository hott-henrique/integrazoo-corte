import 'package:integrazoo/database/database.dart';

import 'package:integrazoo/persistence/finish_persistence.dart';


class FinishController {
  FinishController();

  static Future<void> save(int earring, Finish finish) {
    return FinishPersistence.save(earring, finish);
  }

  static Future<Finish?> getByEarring(int earring) {
    return FinishPersistence.getByEarring(earring);
  }

  static Future<void> delete(int earring) {
    return FinishPersistence.delete(earring);
  }
}
