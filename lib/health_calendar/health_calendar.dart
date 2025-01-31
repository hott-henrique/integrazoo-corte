import 'package:integrazoo/health_calendar/health_calendar_event.dart';


class HealthCalendar {
  static final List<List<HealthCalendarEvent>> treatmentsPerMonth = [
  // JANEIRO
    [ Mastite(), Paratifo(), VermifulgacaoAdultos() ],
  // FEVEREIRO
    [ Mastite(), Paratifo(), VermifulgacaoAdultos(), VermifulgacaoBezerros() ],
  // MARÇO
    [ Mastite(), Paratifo(), VermifulgacaoAdultos(), IBR_BVD4PI3_VRSB() ],
  // ABRIL
    [ Mastite(), Paratifo(), VermifulgacaoAdultos(), Brucelose(), Clostridiose() ],
  // MAIO
    [ Mastite(),
      Paratifo(),
      VermifulgacaoAdultos(),
      VermifulgacaoBezerros(),
      IBR_BVD4PI3_VRSB(),
      FebreAfetosa(),
      Raiva(),
      Leptospirose() ],
  // JUNHO
    [ Mastite(), Paratifo(), VermifulgacaoAdultos() ],
  // JULHO
    [ Mastite(), Paratifo(), VermifulgacaoAdultos() ],
  // AGOSTO
    [ Mastite(),
      Paratifo(),
      VermifulgacaoAdultos(),
      VermifulgacaoBezerros(),
      IBR_BVD4PI3_VRSB(),
      Brucelose(),
      Clostridiose() ],
  // SETEMBRO
    [ Mastite(), Paratifo(), VermifulgacaoAdultos() ],
  // OUTUBRO
    [ Mastite(), Paratifo(), VermifulgacaoAdultos() ],
  // NOVEMBRO
    [ Mastite(),
      Paratifo(),
      VermifulgacaoAdultos(),
      VermifulgacaoBezerros(),
      IBR_BVD4PI3_VRSB(),
      FebreAfetosa(),
      Raiva(),
      Leptospirose() ],
  // DEZEMBRO
    [ Mastite(),
      Paratifo(),
      VermifulgacaoAdultos(),
      Brucelose(),
      Clostridiose() ],
  ];

}
