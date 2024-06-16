import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:kpm_fl/config.dart';
import 'package:kpm_fl/styles.dart';
import 'package:kpm_fl/utils/utils.dart';

class SumField extends StatelessWidget {
  final TextEditingController controller;
  final double? min;
  final double? max;
  final double? initialValue;
  final Function(double? value) onSaved;
  final bool editable;
  final int currency;
  final VoidCallback? onTap;

  SumField({
    required this.controller,
    required this.min,
    required this.max,
    required this.initialValue,
    required this.onSaved,
    required this.currency,
    this.editable = true,
    required this.onTap
  }) {
    if (initialValue != null) {
      if (initialValue == 0.0) {
        controller.clear();
      } else {
        controller.value = TextEditingValue(text: initialValue.toString());
      }
    } else {
      controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    var helperText = '';
    if (min != null) helperText += 'минимум $min ${currencyName(currency)}';
    if (max != null) helperText += ', максимум $max ${currencyName(currency)}';

    return TextFormField(
      controller: controller,
      autocorrect: false,
      // readOnly: !editable,
      readOnly: true,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [NumberTextInputFormatter(decimalRange: 2)],
      textInputAction: TextInputAction.done,
      style: TextStyle(
        color: editable
          ? AppStyles.mainTextColor
          : AppStyles.mainTextColor.withOpacity(0.55),
      ),
      decoration: InputDecoration(
        alignLabelWithHint: true,
        // filled: true,
        isDense: true,
        // fillColor: const Color(0xfff7f7f9),
        counterText: '',
        labelText: editable
          ? 'Сумма*'
          : 'Сумма',
        labelStyle: TextStyle(
          color: editable
            ? AppStyles.mainTextColor
            : AppStyles.mainTextColor.withOpacity(0.55),
        ),
        helperText: helperText,
        hintStyle: TextStyle(
          color: editable
            ? AppStyles.mainTextColor
            : AppStyles.mainTextColor.withOpacity(0.55),
        ),
        border: AppStyles.inputBorder,
        focusedBorder: AppStyles.inputBorderFocused,
        enabledBorder: AppStyles.inputBorderEnabled,
      ),
      validator: (value) {
        if (editable) {
          final _value = value?.toDoubleOrNull();
          if (_value == null) {
            return 'Некорректное значение';
          } else if (_value == 0) {
            return 'Некорректное значение';
          } else if (min != null && _value < min!) {
            return 'Минимум $min р.';
          } else if (max != null && _value > max!) {
            return 'Максимум $max р.';
          }
        }
        return null;
      },
      onSaved: (value) => onSaved(value?.toDoubleOrNull()),
    );
  }

  String currencyName(int code) => AppConfig.mapCurrencyToName[code] ?? '';
}