import 'package:flutter/material.dart';


class SingleBreederSelectorController with ChangeNotifier {
  String? _breeder;
  String? get breeder => _breeder;

  final queryController = TextEditingController();

  int page = 0, pageSize = 25;

  void setBreeder(String? value) {
    _breeder = value;
    notifyListeners();
  }

  void clear() {
    _breeder = null;
    queryController.text = "";
    notifyListeners();
  }
}
