import 'package:integrazoo/backend.dart';

import 'package:integrazoo/ui/components.dart';


class BovinesDataLoader extends DataLoader {
  BovinesSearch _search = BovinesSearch();

  bool _isLoading = true;

  @override
  bool get isLoading => _isLoading;

  final List<Bovine> _data = [];

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

  BovinesSearch get search => _search;

  set search (search) {
    _search = search;
    _loadData();
  }

  Future<void> _loadData() async {
    _isLoading = true;

    notifyListeners();

    _data.clear();

    _rowCount = await BovineService.countBovines_(filter: _search.filter);

    final bovines = await BovineService.getBovines_(_rowsPerPage, _page, search: _search);

    _data.addAll(bovines);

    _isLoading = false;

    notifyListeners();
  }

  void reload() {
    _loadData();
  }

  void update(BovinesSearch newSearch) {
    _search = newSearch;
    notifyListeners();
  }

  void setQuery(String query) {
    _search.filter = _search.filter ?? BovinesFilter();
    _search.filter!.query = query;
    _loadData();
  }

  void setSex(Sex? sex) {
    _search.filter = _search.filter ?? BovinesFilter();
    _search.filter!.sex = sex;
    _loadData();
  }

  void setIsBreeder(bool? value) {
    _search.filter = _search.filter ?? BovinesFilter();
    _search.filter!.isBreeder = value;
    _loadData();
  }

  void setHasBeenWeaned(bool? value) {
    _search.filter = _search.filter ?? BovinesFilter();
    _search.filter!.hasBeenWeaned = value;
    _loadData();
  }

  void setIsReproducing(bool? value) {
    _search.filter = _search.filter ?? BovinesFilter();
    _search.filter!.isReproducing = value;
    _loadData();
  }

  void setIsPregnant(bool? value) {
    _search.filter = _search.filter ?? BovinesFilter();
    _search.filter!.isPregnant = value;
    _loadData();
  }

  void setWasDiscarded(bool? value) {
    _search.filter = _search.filter ?? BovinesFilter();
    _search.filter!.wasDiscarded = value;
    _loadData();
  }

  void setOrderField(BovinesOrderField field, bool ascendent) {
    _search.order = field;
    _search.ascendent = ascendent;
    _loadData();
  }

  int get orderFieldIndex => _search.order?.index ?? 0;
  bool get orderAscending => _search.ascendent;

  Bovine getElement(int index) {
    return _data[index % _rowsPerPage];
  }
}
