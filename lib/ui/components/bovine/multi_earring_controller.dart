import 'package:flutter/material.dart';

import 'package:integrazoo/backend.dart';


class MultiEarringController with ChangeNotifier {
  List<int> earrings = List<int>.empty(growable: true);

  final queryController = TextEditingController();

  List<Bovine> bovines = List.empty(growable: true);

  void addEarring(int value) {
    earrings.add(value);

    BovineService.doesEarringExists(value).then(
      (exists) {
        if (!exists) {
          removeEarring(value);
          notifyListeners();
        }
      }
    );

    notifyListeners();
  }

  void removeEarring(int value) {
    earrings.remove(value);
    notifyListeners();
  }

  void clear({ bool shouldClearQuery = true }) {
    if (shouldClearQuery) {
      queryController.text = "";
    }
    bovines.clear();
    earrings.clear();
    notifyListeners();
  }
}
