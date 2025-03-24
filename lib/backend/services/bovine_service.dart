import 'package:integrazoo/backend.dart';


enum SearchSorting {
  sortByEarring,
  sortByBirthWeight,
  sortByWeaningWeight,
  sortByAvgChildrenBirthWeight,
  sortByAvgChildrenWeaningWeight;

  @override
  String toString() {
    switch (this) {
      case SearchSorting.sortByEarring:
        return "Brinco";

      case SearchSorting.sortByBirthWeight:
        return "Peso ao Nascimento";

      case SearchSorting.sortByWeaningWeight:
        return "Peso a Desmama";

      case SearchSorting.sortByAvgChildrenBirthWeight:
        return "Peso Médio ao Nascimento (Cria)";

      case SearchSorting.sortByAvgChildrenWeaningWeight:
        return "Peso Médio a Desmama (Cria)";
    }
  }
}

class BovineService {
  BovineService();

  static Future<int> saveBovine(Bovine bovine) {
    return BovinePersistence.saveBovine(bovine);
  }

  static Future<Bovine?> getBovine(int earring) async {
    return BovinePersistence.getBovine(earring);
  }

  static Future<int> countBovines() async {
    return BovinePersistence.countBovines();
  }

  static Future<List<Bovine>> getBovines(int pageSize, int page) async {
    return BovinePersistence.getBovines(pageSize, page);
  }

  static Future<int> deleteBovine(int earring) async {
    return BovinePersistence.deleteBovine(earring);
  }

  static Future<int> saveBovineEntry(BovineEntry bovineEntry) {
    return BovinePersistence.saveBovineEntry(bovineEntry);
  }

  static Future<BovineEntry?> getBovineEntry(int earring) async {
    return BovinePersistence.getBovineEntry(earring);
  }

  static Future<List<Bovine>> searchHerd(
    String? query,
    int pageSz, int page,
    Sex? sex,
    bool? wasDiscarded,
    bool? isReproducing,
    bool? isPregnant,
    bool? hasBeenWeaned,
    { SearchSorting sortingOrder = SearchSorting.sortByEarring }
  ) async {
    switch (sortingOrder) {
      case SearchSorting.sortByEarring:
        return searchHerdSortByEarring(query, pageSz, page, sex, wasDiscarded, isReproducing, isPregnant, hasBeenWeaned);

      case SearchSorting.sortByBirthWeight:
        return searchHerdSortByBirthWeight(query, pageSz, page, sex, wasDiscarded, isReproducing, isPregnant, hasBeenWeaned);

      case SearchSorting.sortByWeaningWeight:
        return searchHerdSortByWeaningWeight(query, pageSz, page, sex, wasDiscarded, isReproducing, isPregnant, hasBeenWeaned);

      case SearchSorting.sortByAvgChildrenBirthWeight:
        return searchHerdSortByChildrenBirthWeight(query, pageSz, page, sex, wasDiscarded, isReproducing, isPregnant, hasBeenWeaned);

      case SearchSorting.sortByAvgChildrenWeaningWeight:
        return searchHerdSortByChildrenWeaningWeight(query, pageSz, page, sex, wasDiscarded, isReproducing, isPregnant, hasBeenWeaned);
    }
  }

  static Future<List<Bovine>> searchHerdSortByEarring(
    String? query,
    int pageSz, int page,
    Sex? sex,
    bool? wasDiscarded,
    bool? isReproducing,
    bool? isPregnant,
    bool? hasBeenWeaned,
  ) async {
    return BovinePersistence.searchHerd(query, pageSz, page, sex, wasDiscarded, isReproducing, isPregnant, hasBeenWeaned);
  }

  static Future<List<Bovine>> searchHerdSortByBirthWeight(
    String? query,
    int pageSz, int page,
    Sex? sex,
    bool? wasDiscarded,
    bool? isReproducing,
    bool? isPregnant,
    bool? hasBeenWeaned,
  ) async {
    return BovinePersistence.searchHerdSortByBirthWeight(query, pageSz, page, sex, wasDiscarded, isReproducing, isPregnant, hasBeenWeaned);
  }

  static Future<List<Bovine>> searchHerdSortByWeaningWeight(
    String? query,
    int pageSz, int page,
    Sex? sex,
    bool? wasDiscarded,
    bool? isReproducing,
    bool? isPregnant,
    bool? hasBeenWeaned,
  ) async {
    return BovinePersistence.searchHerdSortByWeaningWeight(query, pageSz, page, sex, wasDiscarded, isReproducing, isPregnant, hasBeenWeaned);
  }

  static Future<List<Bovine>> searchHerdSortByChildrenBirthWeight(
    String? query,
    int pageSz, int page,
    Sex? sex,
    bool? wasDiscarded,
    bool? isReproducing,
    bool? isPregnant,
    bool? hasBeenWeaned,
  ) async {
    return BovinePersistence.searchHerdSortByChildrenBirthWeight(query, pageSz, page, sex, wasDiscarded, isReproducing, isPregnant, hasBeenWeaned);
  }

  static Future<List<Bovine>> searchHerdSortByChildrenWeaningWeight(
    String? query,
    int pageSz, int page,
    Sex? sex,
    bool? wasDiscarded,
    bool? isReproducing,
    bool? isPregnant,
    bool? hasBeenWeaned,
  ) async {
    return BovinePersistence.searchHerdSortByChildrenWeaningWeight(query, pageSz, page, sex, wasDiscarded, isReproducing, isPregnant, hasBeenWeaned);
  }

  static Future<int> getCountBovines() {
    return BovinePersistence.getCountBovines();
  }

  static Future<bool> doesEarringExists(int earring) {
    return BovinePersistence.doesEarringExists(earring);
  }

  static Future<int> countChildrenOfSex(int earring, Sex s) {
    return BovinePersistence.countChildrenOfSex(earring, s);
  }
}
