import 'package:integrazoo/backend/database/database.dart';

Future<T> transaction<T>(Future<T> Function() action, {bool requireNew = false}) {
  return database.transaction(action);
}
