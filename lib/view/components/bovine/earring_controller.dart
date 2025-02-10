import 'package:flutter/material.dart';

import 'package:integrazoo/database/database.dart';


class EarringController with ChangeNotifier {
  int? _earring;
  int? get earring => _earring;

  bool _hasTriedLoading = false;
  bool get hasTriedLoading => _hasTriedLoading;

  final queryController = TextEditingController();

  int page = 0, pageSize = 25;

  List<Bovine> bovines = List.empty(growable: true);

  List<Bovine> sorted() {
    List<Bovine> elements = List<Bovine>.from(bovines);

    elements.sort((a, b) {
      bool aSelected = earring == a.earring;
      bool bSelected = earring == b.earring;

      if (aSelected && !bSelected) {
        return -1;
      }

      if (bSelected && !aSelected) {
        return 1;
      }

      if (aSelected && aSelected) {
        return 0;
      }

      return a.earring.compareTo(b.earring);
    });

    return elements;
  }

  void setEarring(int? value) {
    _earring = value;
    notifyListeners();
  }

  void setPage(int value) {
    page = value;
    notifyListeners();
  }

  void setHasTriedLoading(bool value) {
    _hasTriedLoading = value;
    notifyListeners();
  }

  void clear() {
    page = 0;
    _earring = null;
    _hasTriedLoading = false;
    queryController.text = "";
    bovines.clear();
    notifyListeners();
  }
}
