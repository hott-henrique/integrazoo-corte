import 'package:flutter/material.dart';

import 'package:integrazoo/backend.dart';


class EarringController with ChangeNotifier {
  int? _earring;
  int? get earring => _earring;

  final queryController = TextEditingController();

  int page = 0, pageSize = 25;

  void setEarring(int? value) {
    if (value != null) {
      BovineService.doesEarringExists(value).then(
        (exists) {
          if (!exists) {
            _earring = null;
            queryController.text = "";
            notifyListeners();
          }
        }
      );
    }
    _earring = value;
    notifyListeners();
  }

  void clear() {
    page = 0;
    _earring = null;
    queryController.text = "";
    notifyListeners();
  }
}
