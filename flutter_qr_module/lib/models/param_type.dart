import 'package:dartx/dartx.dart';
import 'package:fl_qr_module/generated/translations.g.dart';
import 'package:fl_qr_module/utils/text_input_formatters.dart';
import 'package:flutter/services.dart';


enum ParamType {
  /// Строка
  str,

  /// Целое число
  integ,

  /// Вещественное число
  doubl,

  /// Дата
  date,

  /// Логический тип (Y-да/N-нет)
  logic,

  /// Составной параметр (значения перечисляются через разделитель «^»)
  composite,
}

extension ParamTypeHelpExtension on ParamType {
  static String get errorMessage => t.models.paramType.error;

  List<TextInputFormatter> get inputFormatters {
    List<TextInputFormatter> ret;
    switch (this) {
      case ParamType.str:
        ret = [];
        break;
      case ParamType.integ:
        ret = [FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+$'))];
        break;
      case ParamType.doubl:
        ret = [NumberTextInputFormatter(decimalRange: 5)];
        break;
      case ParamType.date:
        ret = [];
        break;
      case ParamType.logic:
        ret = [];
        break;
      case ParamType.composite:
        ret = [];

        break;
    }
    return ret;
  }

  static const keyboardTypes = {
    ParamType.str: TextInputType.text,
    ParamType.integ: TextInputType.number,
    ParamType.doubl: TextInputType.numberWithOptions(decimal: true),
    ParamType.date: TextInputType.datetime,
    ParamType.composite: TextInputType.text
  };

  TextInputType get keyboardType => keyboardTypes[this] ?? TextInputType.text;

  String? Function(String) get validator {
    String? Function(String) ret;
    switch (this) {
      case ParamType.str:
        ret = (String value) => null;
        break;
      case ParamType.integ:
        ret = (String value) {
          final _value = value.toIntOrNull();
          if (_value == null) {
            return errorMessage;
          }
          return null;
        };
        break;
      case ParamType.doubl:
        ret = (String value) {
          final _value = value.toDoubleOrNull();
          if (_value == null) {
            return errorMessage;
          }
          return null;
        };
        break;

      case ParamType.date:
        ret = (String value) => null;
        break;
      case ParamType.logic:
        ret = (String value) => null;
        break;
      case ParamType.composite:
        ret = (String value) => null;
        break;
    }
    return ret;
  }
}
