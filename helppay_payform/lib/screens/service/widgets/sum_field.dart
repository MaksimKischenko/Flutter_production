import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:helppay_payform_app/config.dart';
import 'package:helppay_payform_app/styles.dart';
import 'package:helppay_payform_app/utils/utils.dart';

class SumField extends StatelessWidget {
  final double? min;
  final double? max;
  final double? initialValue;
  final Function(double? value) onSaved;
  final bool editable;
  final int currency;
  final bool isDevice;

  const SumField({
    required this.min,
    required this.max,
    required this.initialValue,
    required this.onSaved,
    required this.currency,
    required this.isDevice,
    this.editable = true,
  });

  @override
  Widget build(BuildContext context) => TextFormField(
    cursorWidth: 1,
      initialValue: (initialValue ?? 0.0) == 0.0
        ? ''
        : initialValue?.toString() ?? '',
      autocorrect: false,
      readOnly: !editable,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [NumberTextInputFormatter(decimalRange: 2)],
      textInputAction: TextInputAction.done,
      cursorColor: AppStyles.mainColor,
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
        hintStyle: TextStyle(
          color: editable
            ? AppStyles.mainTextColor
            : AppStyles.mainTextColor.withOpacity(0.55),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xffEBEBEB), width: 2),
          borderRadius: BorderRadius.circular(6)
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1)
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1)
        ),       
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(6)
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xffEBEBEB), width: 2),
          borderRadius: BorderRadius.circular(6)
        ),
        errorStyle: TextStyle(fontSize: isDevice? 14 : 16, fontWeight: FontWeight.w400),  
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

  String currencyName(int code) => AppConfig.mapCurrencyToName[code] ?? '';
}