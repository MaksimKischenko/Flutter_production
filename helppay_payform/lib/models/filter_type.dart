import 'package:dartx/dartx.dart';
import 'package:flutter/services.dart';
import 'package:helppay_payform_app/utils/utils.dart';

enum FilterType {
  doubl, integ, str, date, logic
}

extension FilterTypeExtension on FilterType {
  static const errorMessage = 'Некорректное значение';

  static final Map<String, FilterType> _mapStringToValue = {
    'R': FilterType.doubl,
    'I': FilterType.integ,
    'S': FilterType.str,
    'D': FilterType.date,
    'L': FilterType.logic,
  };

  static FilterType fromString(String? value) => _mapStringToValue[value] ?? FilterType.str;

  List<TextInputFormatter> get inputFormatters {
    List<TextInputFormatter> ret;
    switch (this) {
      case FilterType.str:
        ret = [];
        break;
      case FilterType.integ:
        ret = [FilteringTextInputFormatter.allow(RegExp('^[0-9]+\$'))];
        break;
      case FilterType.doubl:
        ret = [NumberTextInputFormatter(decimalRange: 5)];
        break;
      case FilterType.date:
        ret = [];
        break;
      case FilterType.logic:
        ret = [];
        break;
    }
    return ret;
  }

  String? Function(String?) get validator {
    String? Function(String?) ret;
    switch (this) {
      case FilterType.str:
        ret = (String? value) => null;
        break;
      case FilterType.integ:
        ret = (String? value) => value?.toIntOrNull() == null ? errorMessage : null;
        break;
      case FilterType.doubl:
        ret = (String? value) => value?.toDoubleOrNull() == null ? errorMessage : null;
        break;
      case FilterType.date:
        ret = (String? value) => null;
        break;
      case FilterType.logic:
        ret = (String? value) => null;
        break;
    }
    return ret;
  }

  static const keyboardTypes = {
    FilterType.str: TextInputType.text,
    FilterType.integ: TextInputType.number,
    FilterType.doubl: TextInputType.numberWithOptions(decimal: true),
    FilterType.date: TextInputType.datetime,
  };

  TextInputType get keyboardType => keyboardTypes[this] ?? TextInputType.text;
}