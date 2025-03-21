enum Sex {
  male, female;

  @override
  String toString() {
    switch (this) {
      case Sex.male:
        return "Macho";

      case Sex.female:
        return "Fêmea";
    }
  }
}

enum ReproductionKind {
  artificialInsemination,
  coverage;

  @override
  String toString() {
    switch (this) {
      case artificialInsemination:
        return 'Inseminação Artificial';

      case coverage:
        return 'Monta';
    }
  }
}

enum ReproductionDiagonostic {
  positive,
  negative,
  waiting;

  @override
  String toString() {
    switch (this) {
      case positive:
        return 'Positivo';

      case negative:
        return 'Negativo';

      case waiting:
        return 'Esperando';
    }
  }
}

enum FinishingReason {
  discard,
  sell,
  death,
  slaughter;

  @override
  String toString() {
    switch (this) {
      case discard:
        return 'Descarte';

      case death:
        return 'Morte';

      case sell:
        return 'Venda';

      case slaughter:
        return 'Abate';
    }
  }
}

enum BodyConditionScore {
  cachetic,
  lean,
  ideal,
  fat,
  obese;

  @override
  String toString() {
    switch (this) {
      case BodyConditionScore.cachetic:
        return "Caquético";

      case BodyConditionScore.lean:
        return "Magro";

      case BodyConditionScore.ideal:
        return "Ideal";

      case BodyConditionScore.fat:
        return "Gordo";

      case BodyConditionScore.obese:
        return "Obeso";
    }
  }
}
