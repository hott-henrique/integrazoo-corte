import 'package:integrazoo/backend.dart';

enum BovinesOrderField {
  earring,

  birthWeight,
  weaningWeight,
  yearlingWeight,

  ageFirstBirth,
  recentFailedReproductionAttempts,
}

class BovinesFilter {
  String query;
  Sex? sex;
  bool? isBreeder;
  bool? hasBeenWeaned;
  bool? isReproducing;
  bool? isPregnant;
  bool? wasDiscarded;

  BovinesFilter({
    this.query = "",
    this.sex,
    this.isBreeder,
    this.hasBeenWeaned,
    this.isReproducing,
    this.isPregnant,
    this.wasDiscarded,
  });
}

class BovinesSearch {
  bool ascendent;
  BovinesOrderField? order;
  BovinesFilter? filter;

  BovinesSearch({ this.ascendent = false, this.order, this.filter });

  void setOrderField(BovinesOrderField field, bool ascendent) {
    order = field;
    this.ascendent = ascendent;
  }
}
