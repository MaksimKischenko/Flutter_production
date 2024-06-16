import 'package:dartx/dartx.dart';
import 'package:fl_qr_module/styles.dart';
import 'package:fl_qr_module/utils/text_input_formatters.dart';
import 'package:flutter/material.dart';

class SumField extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final double? min;
  final double? max;
  final double? initialValue;
  final Function(double value) onSaved;

  const SumField(
      {required this.formKey,
      required this.min,
      required this.max,
      required this.initialValue,
      required this.onSaved});

  @override
  Widget build(BuildContext context) => Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: TextFormField(
            // maxLength: max.toString().length,
            initialValue: (initialValue ?? 0.0) == 0.0
                ? ''
                : initialValue?.toString() ?? '',
            // initialValue: initialValue.toString() ?? "",
            autocorrect: false,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [NumberTextInputFormatter(decimalRange: 2)],
            // inputFormatters: [LngthLimitingTextInputFormatter()],
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              counterText: '',
              labelText: 'Сумма*',
              // hintText: "Минимум $min р., максимум $max р.",
              helperText: 'Минимум $min р., максимум $max р.',
              alignLabelWithHint: true,
              labelStyle: AppStyles.inputLabelUnderlineStyle,
              enabledBorder: AppStyles.inputBorderUnderline,
              border: AppStyles.inputBorderUnderline,
              isDense: true,
            ),
            validator: (value) {
              final _value = value?.toDoubleOrNull();
              if (_value == null) {
                return 'Некорректное значение';
              }
              if (min != null && _value < min!) {
                return 'Минимум $min р.';
              }
              if (max != null && _value > max!) {
                return 'Максимум $max р.';
              }
              return null;
            },
            onSaved: (value) => onSaved(value!.toDouble()),
          ),
        ),
      );
}
