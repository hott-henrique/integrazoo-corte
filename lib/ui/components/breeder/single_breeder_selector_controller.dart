import 'package:flutter/material.dart';

import 'package:integrazoo/backend/database/database.dart';


class SingleBreederSelectorController with ChangeNotifier {
  String? _breeder;
  String? get breeder => _breeder;

  bool _hasTriedLoading = false;
  bool get hasTriedLoading => _hasTriedLoading;

  final queryController = TextEditingController();

  int page = 0, pageSize = 25;

  List<Breeder> breeders = List.empty(growable: true);

  List<Breeder> sorted() {
    List<Breeder> elements = List<Breeder>.from(breeders);

    elements.sort((a, b) {
      bool aSelected = breeder == a.name;
      bool bSelected = breeder == b.name;

      if (aSelected && !bSelected) {
        return -1;
      }

      if (bSelected && !aSelected) {
        return 1;
      }

      if (aSelected && aSelected) {
        return 0;
      }

      return a.name.compareTo(b.name);
    });

    return elements;
  }

  void setBreeder(String? value) {
    _breeder = value;
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
    _breeder = null;
    _hasTriedLoading = false;
    queryController.text = "";
    breeders.clear();
    notifyListeners();
  }
}
