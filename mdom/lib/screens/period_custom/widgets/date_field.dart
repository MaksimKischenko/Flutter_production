import 'package:bpc/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class DateField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final String? Function(DateTime date) validator;
  final Function(DateTime date) onChanged;

  final _dateFormatter = MaskTextInputFormatter(
    mask: '##/##/####',
    filter: {'#': RegExp('[0-9]')}
  );

  DateField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.validator,
    required this.onChanged
  });

  @override
  Widget build(BuildContext context) => TextFormField(
    controller: controller,
    autocorrect: false,
    keyboardType: TextInputType.number,
    textInputAction: TextInputAction.done,
    maxLength: 10,
    inputFormatters: [
      _dateFormatter
    ],
    decoration: InputDecoration(
      labelText: label,
      hintText: hint,
      counterText: '',
      alignLabelWithHint: true,
      labelStyle: AppStyles.inputLabelUnderlineStyle,
      enabledBorder: AppStyles.inputBorderUnderline,
      border: AppStyles.inputBorderUnderline,
      isDense: true
    ),
    // onChanged: (value) {
    //   try {
    //     final date = DateFormat('dd/MM/yyyy').parse(value);
    //     return onChanged?.call(date);
    //   } catch (e) {}
    // },
    validator: (value) {
      try {
        final date = DateFormat('dd/MM/yyyy').parse(value!);
        return validator(date);
      } on Exception catch(_) {
        return 'Неверный формат даты';
        // TODO
        // return t.screens.mdomPeriodCustom.dateField.errors.format;
      }
    },
  );
}