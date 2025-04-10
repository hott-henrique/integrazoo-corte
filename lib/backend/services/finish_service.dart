import 'package:integrazoo/backend.dart';


class FinishService {
  FinishService();

  static Future<void> save(int earring, Finish finish) {
    return FinishPersistence.save(earring, finish);
  }

  static Future<Finish?> getByEarring(int earring) {
    return FinishPersistence.getByEarring(earring);
  }

  static Future<int> countFinishes() {
    return FinishPersistence.countFinishes();
  }

  static Future<List<Finish>> getFinishes(int pageSize, int page, FinishesOrderField field, bool ascendent) {
    return FinishPersistence.getFinishes(pageSize, page, field, ascendent);
  }

  static Future<void> delete(int earring) {
    return FinishPersistence.delete(earring);
  }
}
