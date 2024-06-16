import 'package:bpc/utils/text_input_formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SumField extends StatelessWidget {
  final Function(double value)? onSaved;
  final String? Function(double value)? validator;
  final FocusNode? focusNode;

  const SumField({
    this.onSaved,
    this.validator,
    this.focusNode
  });
  
  @override
  Widget build(BuildContext context) => TextFormField(
    focusNode: focusNode,
    keyboardType: const TextInputType.numberWithOptions(decimal: true),
    inputFormatters: [FilteringTextInputFormatter.deny(RegExp('[\\-|\\ ]')), NumberTextInputFormatter(decimalRange: 2)],
    decoration: const InputDecoration(
      labelText: 'Сумма *',
    ),
    validator: (value) {
      final sum = double.tryParse(value ?? '');
      if (sum == null || sum < 0) {
        return 'Некорректная сумма';
      }
      return validator?.call(sum);
    },
    onSaved: (value) => onSaved?.call(double.parse(value!)),
  );
}