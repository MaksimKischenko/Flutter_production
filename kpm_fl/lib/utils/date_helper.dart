import 'package:intl/intl.dart';

extension DateHelperString on String {

  DateTime? toDateFormatted({String? format = 'dd/MM/yyyy'}) {
    final dateFormat = DateFormat(format);
    try {
      return dateFormat.parse(this);
    // ignore: avoid_catches_without_on_clauses
    } catch(err, _) {
      return null;
    }
  }

}

extension DateHelperDateTime on DateTime {

  String toStringFormatted({String? format = 'dd/MM/yyyy'}) => DateFormat(format ?? 'dd/MM/yyyy').format(this);

  String toStringFormattedGetOperationHistory() => DateFormat('dd/MM/yyyy HH:mm:ss').format(this);

  String toStringFormattedRunOperation() => DateFormat('dd/MM/yyyy HH:mm:ss').format(this);

}