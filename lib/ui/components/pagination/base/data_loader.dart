import 'package:flutter/material.dart';


abstract class DataLoader extends ChangeNotifier {
  bool get isLoading;

  int get availableRows;
  int get maxPages;

  int get page;

  int get rowsPerPage;
  set rowsPerPage (value);

  void previousPage();
  void nextPage();

  void initialize();
}
