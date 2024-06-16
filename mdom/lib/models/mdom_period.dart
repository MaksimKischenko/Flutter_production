import 'package:dartx/dartx.dart';
import 'package:intl/intl.dart';

enum MdomPeriod {
  notSet, month, quarter, year, custom
}

extension MdomPeriodExtension on MdomPeriod {
  String get name {
    String value;
    switch (this) {
      case MdomPeriod.notSet:
        value = 'Неизвестно';
        // TODO
        // value = t.models.period.names.notSet;
        break;
      case MdomPeriod.month:
        value = 'Месяц';
        // TODO
        // value = t.models.period.names.month;
        break;
      case MdomPeriod.quarter:
        value = 'Квартал';
        // TODO
        // value = t.models.period.names.quarter;
        break;
      case MdomPeriod.year:
        value = 'Год';
        // TODO
        // value = t.models.period.names.year;
        break;
      case MdomPeriod.custom:
        value = 'Выбрать период';
        // TODO
        // value = t.models.period.names.custom;
        break;
      default:
        value = 'Неизвестно';
        // TODO
        // value = t.models.period.names.notSet;
    }
    return value;
  }
}

class MdomPeriodWrapper {
  final MdomPeriod period;
  final DateTime? from;
  final DateTime? to;

  MdomPeriodWrapper({
    required this.period,
    this.from,
    this.to,
  });

  final _dateFormat = DateFormat('dd.MM.yyyy');

  int get month => from!.month;
  int get year => from!.year;
  int get quarter => from != null ? DateFormat('Q').format(from!).toIntOrNull() ?? 1 : 1;

  String name(String localeName) {
    String value;
    switch (period) {
      case MdomPeriod.notSet:
        value = 'Выбрать период';
        // TODO
        // value = t.models.period.selectedNames.notSet;
        break;
      case MdomPeriod.month:
        final m = DateFormat('MMMM', localeName).format(from!);
        value = '$m $year';
        // TODO
        // value = t.models.period.selectedNames.month(month: m, year: year);
        break;
      case MdomPeriod.quarter:
        value = '$quarter квартал $year';
        // TODO
        // value = t.models.period.selectedNames.quarter(quarter: quarter, year: year);
        break;
      case MdomPeriod.year:
        value = '$year год';
        // TODO
        // value = t.models.period.selectedNames.year(year: year);
        break;
      case MdomPeriod.custom:
        final dateFromFormated = _dateFormat.format(from!);
        final dateToFormatted = _dateFormat.format(to!);
        value = '$dateFromFormated - $dateToFormatted';
        // TODO
        // value = t.models.period.selectedNames.custom(startDate: dateFromFormated, endDate: dateToFormatted);
        break;
      default:
        value = 'Выбрать период';
        // TODO
        // value = t.models.period.selectedNames.notSet;
    }
    return value;
  }

  // ignore: prefer_constructors_over_static_methods
  static MdomPeriodWrapper fromMonth({
    required int month,
    required int year
  }) => MdomPeriodWrapper(
    period: MdomPeriod.month,
    from: DateTime(year, month, 1),
    to: DateTime(year, month+1, 0)
  );

  // map quarter to first month of it
  static final Map<int, int> _quarterToMonth = {
    // Janyary
    1: 1,
    // April
    2: 4,
    // July
    3: 7,
    // October
    4: 10
  };

  // ignore: prefer_constructors_over_static_methods
  static MdomPeriodWrapper fromQuarter({
    required int quarter,
    required int year
  }) {
    final startMonth = _quarterToMonth[quarter]!;
    return MdomPeriodWrapper(
      period: MdomPeriod.quarter,
      from: DateTime(year, startMonth, 1),
      to: DateTime(year, startMonth+3, 0)
    );
  }

  // ignore: prefer_constructors_over_static_methods
  static MdomPeriodWrapper fromYear(
    int year
  ) => MdomPeriodWrapper(
    period: MdomPeriod.year,
    from: DateTime(year, 1, 1),
    to: DateTime(year+1, 1, 0)
  );

  // ignore: prefer_constructors_over_static_methods
  static MdomPeriodWrapper custom({
    required DateTime from,
    required DateTime to
  }) => MdomPeriodWrapper(
    period: MdomPeriod.custom,
    from: from,
    to: to
  );

  MdomPeriodWrapper prev() {
    MdomPeriodWrapper temp;
    switch (period) {
      case MdomPeriod.month:
        temp = MdomPeriodWrapper.fromMonth(
          month: month - 1,
          year: year
        );
        break;
      case MdomPeriod.quarter:
        temp = MdomPeriodWrapper.fromQuarter(
          quarter: quarter == 1 ? 4 : quarter - 1,
          year: quarter == 1 ? year - 1 : year
        );
        break;
      case MdomPeriod.year:
        temp = MdomPeriodWrapper.fromYear(year - 1);
        break;
      default:
        temp = this;
    }
    return temp;
  }

  MdomPeriodWrapper next() {
    MdomPeriodWrapper temp;
    switch (period) {
      case MdomPeriod.month:
        temp = MdomPeriodWrapper.fromMonth(
          month: month + 1,
          year: year
        );
        break;
      case MdomPeriod.quarter:
        temp = MdomPeriodWrapper.fromQuarter(
          quarter: quarter == 4 ? 1 : quarter + 1,
          year: quarter == 4 ? year + 1 : year
        );
        break;
      case MdomPeriod.year:
        temp = MdomPeriodWrapper.fromYear(year + 1);
        break;
      default:
        temp = this;
    }
    return temp;
  }

  @override
  String toString() {
    if (period == MdomPeriod.notSet) {
      return 'MdomPeriodWrapper( period: $period )';
    } else {
      return 'MdomPeriodWrapper( period: $period, from: ${_dateFormat.format(from!)}, to: ${_dateFormat.format(to!)}, quarter: $quarter )';
    }
  }
}
