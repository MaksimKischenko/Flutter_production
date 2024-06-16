// ignore_for_file: always_put_required_named_parameters_first

import 'package:bpc_nkfo/utils/text_input_formatters.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DeviceTarifField extends StatelessWidget {
  final TextEditingController? controller;
  final Function(double value)? onSaved;
  final FocusNode? focusNode;

  const DeviceTarifField({
    this.controller,
    required this.onSaved,
    this.focusNode
  });
  
  @override
  Widget build(BuildContext context) => TextFormField(
    focusNode: focusNode,
    controller: controller,
    keyboardType: const TextInputType.numberWithOptions(decimal: true),
    inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'[\-|\ ]')), NumberTextInputFormatter(decimalRange: 2)],
    decoration: const InputDecoration(
      labelText: 'Тариф *',
    ),
    validator: (value) {
      final tarif = value?.toDoubleOrNull();
      if (tarif == null || tarif < 0) {
        return 'Некорректное значение';
      }
      return null;
    },
    onSaved: (value) => onSaved?.call(value!.toDouble()),
  );
}