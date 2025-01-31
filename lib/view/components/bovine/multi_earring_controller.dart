import 'package:flutter/material.dart';

import 'package:integrazoo/database/database.dart';


class MultiEarringController with ChangeNotifier {
  List<int> earrings = List<int>.empty(growable: true);

  bool _hasTriedLoading = false;
  bool get hasTriedLoading => _hasTriedLoading;

  final queryController = TextEditingController();

  int page = 0, pageSize = 25;

  List<Bovine> bovines = List.empty(growable: true);

  List<Bovine> sorted() {
    List<Bovine> elements = List<Bovine>.from(bovines);

    elements.sort((a, b) {
      bool aSelected = earrings.contains(a.earring);
      bool bSelected = earrings.contains(b.earring);
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

  void addEarring(int value) {
    earrings.add(value);
    notifyListeners();
  }

  void removeEarring(int value) {
    earrings.remove(value);
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
    _hasTriedLoading = false;
    queryController.text = "";
    bovines.clear();
    earrings.clear();
    notifyListeners();
  }
}
