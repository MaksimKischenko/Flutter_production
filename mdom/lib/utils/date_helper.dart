import 'package:intl/intl.dart';

extension DateHelperString on String {

  DateTime toDateFormatted({bool withTime = false}) {
    final dateFormat = DateFormat(withTime ? 'dd.MM.yyyy HH:mm:ss' : 'dd.MM.yyyy');
    return dateFormat.parse(this);
  }

  String toStringWithoutSeconds() {
    final dateFormat = DateFormat('dd.MM.yyyy HH:mm:ss');
    return DateFormat('dd.MM.yyyy HH:mm').format(dateFormat.parse(this));
  }

}

extension DateHelperDateTime on DateTime {

  String toStringFormatted() => DateFormat('dd.MM.yyyy').format(this);

  //TODO: remove & move time to [toStringFormatted]
  String toStringFormattedWithTime() => DateFormat('dd.MM.yyyy HH:mm:ss').format(this);

  String toStringOnlyTime() => DateFormat('HH:mm:ss').format(this);

  String toStringFormattedWithTimeShort() => DateFormat('dd.MM.yyyy HH:mm').format(this);

}