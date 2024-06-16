import 'package:bpc/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ParamField extends StatelessWidget {
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String value)? onSaved;
  final String? Function(String value)? validator;
  final String labelText;
  final String? hintText;
  final String? initialValue;
  final int maxLength;
  final bool editable;

  const ParamField({
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.onSaved,
    this.validator,
    required this.labelText,
    this.hintText,
    this.initialValue,
    required this.maxLength,
    required this.editable
  });

  @override
  Widget build(BuildContext context) => TextFormField(
    maxLength: maxLength,
    initialValue: initialValue,
    autocorrect: false,
    enabled: editable,
    readOnly: !editable,
    keyboardType: keyboardType,
    inputFormatters: inputFormatters ?? [],
    // inputFormatters: [LngthLimitingTextInputFormatter()],
    textInputAction: TextInputAction.done,
    decoration: InputDecoration(
      counterText: '',
      filled: true,
      labelText: labelText,
      hintText: hintText,
      alignLabelWithHint: true,
      labelStyle: AppStyles.inputLabelStyle,
      fillColor: editable ? Colors.transparent  : Colors.grey.shade300.withOpacity(0.3),
      enabledBorder: AppStyles.inputBorder,
      border: AppStyles.inputBorder,
      isDense: true,
    ),
    validator: (value) => validator?.call(value!),
    onSaved: (value) => onSaved?.call(value!),
  );
}