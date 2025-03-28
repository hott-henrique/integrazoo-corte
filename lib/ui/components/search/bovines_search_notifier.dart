import 'package:flutter/material.dart';

import 'package:integrazoo/backend.dart';


class BovinesSearchNotifier extends ChangeNotifier {
  BovinesSearch _search = BovinesSearch();

  BovinesSearch get search => _search;

  void update(BovinesSearch newSearch) {
    _search = newSearch;
    notifyListeners();
  }

  void setQuery(String query) {
    _search.filter = _search.filter ?? BovinesFilter();
    _search.filter!.query = query;
    notifyListeners();
  }

  void setSex(Sex? sex) {
    _search.filter = _search.filter ?? BovinesFilter();
    _search.filter!.sex = sex;
    notifyListeners();
  }

  void setIsBreeder(bool? value) {
    _search.filter = _search.filter ?? BovinesFilter();
    _search.filter!.isBreeder = value;
    notifyListeners();
  }

  void setHasBeenWeaned(bool? value) {
    _search.filter = _search.filter ?? BovinesFilter();
    _search.filter!.hasBeenWeaned = value;
    notifyListeners();
  }

  void setIsReproducing(bool? value) {
    _search.filter = _search.filter ?? BovinesFilter();
    _search.filter!.isReproducing = value;
    notifyListeners();
  }

  void setIsPregnant(bool? value) {
    _search.filter = _search.filter ?? BovinesFilter();
    _search.filter!.isPregnant = value;
    notifyListeners();
  }

  void setWasDiscarded(bool? value) {
    _search.filter = _search.filter ?? BovinesFilter();
    _search.filter!.wasDiscarded = value;
    notifyListeners();
  }

  void setOrderField(BovinesOrderField field, bool ascendent) {
    _search.order = field;
    _search.ascendent = ascendent;
    notifyListeners();
  }

  void reset() {
    _search.filter = BovinesFilter();
    _search.ascendent = false;
    _search.order = BovinesOrderField.earring;
    notifyListeners();
  }

  void setFilterCopy(BovinesFilter f) {
    _search.filter = f;
    notifyListeners();
  }
}
