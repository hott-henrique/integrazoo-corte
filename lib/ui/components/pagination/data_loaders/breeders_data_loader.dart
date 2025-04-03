import 'package:integrazoo/backend.dart';

import 'package:integrazoo/ui/components.dart';


class BreedersDataLoader extends DataLoader {
  bool _isLoading = true;

  @override
  bool get isLoading => _isLoading;

  final List<Breeder> _data = [];

  int? _rowCount;

  int _rowsPerPage = 25;
  int _page = 0;

  int get selectedRowCount => 0;

  @override
  void initialize() {
    _loadData();
  }

  @override
  int get page => _page;

  @override
  int get rowsPerPage => _rowsPerPage;

  @override
  int get availableRows => _data.length;
  int get rowCount => _isLoading ? 0 : _rowCount!;

  @override
  int get maxPages => ((_rowCount ?? 0) / _rowsPerPage).ceil();

  @override
  void previousPage() {
    if (_page > 0) {
      _page = _page - 1;
      _loadData();
    }
  }

  @override
  void nextPage() {
    if (_page < maxPages - 1) {
      _page = _page + 1;
      _loadData();
    }
  }

  @override
  set rowsPerPage (value) {
    _rowsPerPage = value;
    _loadData();
  }

  Future<void> _loadData() async {
    _isLoading = true;

    notifyListeners();

    _data.clear();

    _rowCount = await BreederService.countBreeders();

    final breeders = await BreederService.getBreeders(_rowsPerPage, _page);

    _data.addAll(breeders);

    _isLoading = false;

    notifyListeners();
  }

  void reload() {
    _loadData();
  }

  Breeder getElement(int index) {
    return _data[index % _rowsPerPage];
  }
}
