import 'package:bpc_nkfo/utils/text_input_formatters.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SumField extends StatelessWidget {
  final Function(double value)? onSaved;
  final String? Function(double value)? validator;
  final FocusNode? focusNode;

  const SumField({
    required this.onSaved,
    required this.validator,
    this.focusNode
  });
  
  @override
  Widget build(BuildContext context) => TextFormField(
    focusNode: focusNode,
    // initialValue: "22.8",
    keyboardType: const TextInputType.numberWithOptions(decimal: true),
    inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'[\-|\ ]')), NumberTextInputFormatter(decimalRange: 2)],
    decoration: const InputDecoration(
      labelText: 'Сумма *',
    ),
    validator: (value) {
      final sum = value?.toDoubleOrNull();
      if (sum == null || sum < 0) {
        return 'Некорректная сумма';
      }
      return validator?.call(sum);
    },
    onSaved: (value) => onSaved?.call(value!.toDouble()),
  );
}