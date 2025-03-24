class FemaleBreederStatistics {
  int earring;
  String? name;

  double? weightBirth;
  double? weightWeaning;
  double? weightYearling;

  int? monthsAfterFirstBirth;

  int countFailedReproductions;

  FemaleBreederStatistics({
    required this.earring,
    this.name,
    this.weightBirth,
    this.weightWeaning,
    this.weightYearling,
    required this.monthsAfterFirstBirth,
    required this.countFailedReproductions,
  });
}
