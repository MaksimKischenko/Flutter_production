import 'package:bpc/utils/text_input_formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DeviceLastRegField extends StatelessWidget {
  final TextEditingController? controller;
  final Function(double value)? onSaved;
  final FocusNode? focusNode;

  const DeviceLastRegField({
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
      labelText: 'Предыдущее показание прибора учета *',
    ),
    validator: (value) {
      final lastReg = double.tryParse(value ?? '');
      if (lastReg == null || lastReg < 0) {
        return 'Некорректное значение';
      }
      return null;
    },
    onSaved: (value) => onSaved?.call(double.parse(value!)),
  );
}