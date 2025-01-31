import 'package:integrazoo/database/database.dart';


abstract class HealthCalendarEvent {
  abstract final String vaccineName;

  String getDescription(int month);
  bool doesApply(int month, Bovine bovine);
}

class FebreAfetosa extends HealthCalendarEvent {
  @override
  final String vaccineName = 'Febre Afetosa';

  @override
  String getDescription(int month) {
    if (month != 5 || month != 11) {
      return "A vacina para a Febre Afetosa é aplicada no rebanho todo somente nos meses de maio e novembro.";
    }

    return "Nos meses de maio e novembro a vacina para a Febre Afetosa é aplicada no rebanho todo, e a primeira vacinação ocorre quando o animal tem de 3 a 8 meses de vida.";
  }

  @override
  bool doesApply(int month, Bovine bovine) => true;

}

class Raiva extends HealthCalendarEvent {
  @override
  final String vaccineName = 'Raiva';

  @override
  String getDescription(int month) {
    if (month != 5 || month != 11) {
      return "A vacina para a Raiva é aplicada no rebanho todo somente nos meses de maio e novembro.";
    }

    return "Nos meses de maio e novembro a vacina para a Febre Afetosa é aplicada no rebanho todo, e ocorre quando o animal tem a partir de 3 meses de vida.";
  }

  @override
  bool doesApply(int month, Bovine bovine) => true;
}

class Leptospirose extends HealthCalendarEvent {
  @override
  final String vaccineName = 'Leptospirose';

  @override
  String getDescription(int month) {
    if (month != 5 || month != 11) {
      return "A vacina para a Leptospirose é aplicada no rebanho todo somente nos meses de maio e novembro.";
    }

    return "Nos meses de maio e novembro a vacina para a Febre Afetosa é aplicada no rebanho todo, a partir do início da vida reprodutiva do animal.";
  }

  @override
  bool doesApply(int month, Bovine bovine) => true;
}

class IBR_BVD4PI3_VRSB extends HealthCalendarEvent {
  @override
  final String vaccineName = 'IBR-BVD4PI3-VRSB';

  @override
  String getDescription(int month) {
    if (month != 3 || month != 5 || month != 8 || month != 11) {
      return "Aplicada somente nos meses de março, maio, agosto e novembro.";
    }

    return """Em novembro, aplica-se no rebanho todo. Em março, maio e agosto apenas nas fêmeas prenha a mais de dois meses.""";
  }

  @override
  bool doesApply(int month, Bovine bovine) => true;
}

class Brucelose extends HealthCalendarEvent {
  @override
  final String vaccineName = 'Brucelose';

  @override
  String getDescription(int month) {
    if (month != 4 || month != 8 || month != 12) {
      return "Aplicada somente nos meses de abril, agosto e dezembro.";
    }

    return """Em abril, agosto e dezembro, aplica-se nos bezerros com 3 a 6 meses de idade.""";
  }

  @override
  bool doesApply(int month, Bovine bovine) => true;
}

class Clostridiose extends HealthCalendarEvent {
  @override
  final String vaccineName = 'Clostridiose';

  @override
  String getDescription(int month) {
    if (month != 4 || month != 8 || month != 12) {
      return "Aplicada somente nos meses de abril, agosto e dezembro.";
    }

    return """Em abril, agosto e dezembro, aplica-se nos bezerros com 3, 4 e 9 meses de idade.""";
  }

  @override
  bool doesApply(int month, Bovine bovine) => true;
}

class Mastite extends HealthCalendarEvent {
  @override
  final String vaccineName = 'Mastite';

  @override
  String getDescription(int month) => "Aplicada em vacas secas.";

  @override
  bool doesApply(int month, Bovine bovine) => true;
}

class Paratifo extends HealthCalendarEvent {
  @override
  final String vaccineName = 'Paratifo';

  @override
  String getDescription(int month) => "Aplicada em vacas secas.";

  @override
  bool doesApply(int month, Bovine bovine) => true;
}

class VermifulgacaoAdultos extends HealthCalendarEvent {
  @override
  final String vaccineName = 'Vermifulgação (Adultos)';

  @override
  String getDescription(int month) {
    if (month == 5 || month == 7 || month == 9) {
      return "Aplicar a vermifugação no rebanho todo.";
    }
    return "Aplicar a vermifugação nas vacas secas.";
  }

  @override
  bool doesApply(int month, Bovine bovine) => true;
}

class VermifulgacaoBezerros extends HealthCalendarEvent {
  @override
  final String vaccineName = 'Vermifulgação (Bezerros)';

  @override
  String getDescription(int month) {
    if (month == 2 || month == 5 || month == 8 || month == 11) {
      return "Aplicar a vermifugação nos bezerros com 2 a 12 meses de vida.";
    }

    return "A vermifugação dos bezerros é feita em fevereiro, maior, agosto e novembro, e apenas nos que tem entre 2 e 12 meses de vida.";
  }

  @override
  bool doesApply(int month, Bovine bovine) => true;
}
