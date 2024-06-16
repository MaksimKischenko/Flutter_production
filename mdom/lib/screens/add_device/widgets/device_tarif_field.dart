import 'package:bpc/utils/text_input_formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DeviceTarifField extends StatelessWidget {
  final TextEditingController? controller;
  final Function(double value)? onSaved;
  final FocusNode? focusNode;

  const DeviceTarifField({
    this.controller,
    this.onSaved,
    this.focusNode
  });
  
  @override
  Widget build(BuildContext context) => TextFormField(
    focusNode: focusNode,
    controller: controller,
    keyboardType: const TextInputType.numberWithOptions(decimal: true),
    inputFormatters: [FilteringTextInputFormatter.deny(RegExp('[\\-|\\ ]')), NumberTextInputFormatter(decimalRange: 2)],
    decoration: const InputDecoration(
      labelText: 'Тариф *',
    ),
    validator: (value) {
      final tarif = double.tryParse(value ?? '');
      if (tarif == null || tarif < 0) {
        return 'Некорректное значение';
      }
      return null;
    },
    onSaved: (value) => onSaved?.call(double.parse(value!)),
  );
}