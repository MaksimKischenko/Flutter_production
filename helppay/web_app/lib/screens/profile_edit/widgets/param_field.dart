import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helppay_web_app/styles.dart';

class ParamField extends StatelessWidget {
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onSaved;
  final String? Function(String)? validator;
  final String labelText;
  final String? hintText;
  final String? initialValue;
  final int maxLength;
  final bool editable;
  final bool isMobileInputField;

  const ParamField({
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.onSaved,
    this.validator,
    required this.labelText,
    required this.hintText,
    this.initialValue,
    required this.maxLength,
    required this.editable,
    required this.isMobileInputField,
  });

  @override
  Widget build(BuildContext context) => TextFormField(
        maxLength: maxLength,
        initialValue: initialValue,
        autocorrect: false,
        readOnly: !editable,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters ?? [],
        // inputFormatters: [LngthLimitingTextInputFormatter()],
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
            prefixText: isMobileInputField ? '+375' : null,
            counterText: '',
            labelText: labelText,
            hintText: hintText,
            alignLabelWithHint: true,
            labelStyle: AppStyles.inputLabelOutlineStyle,
            enabledBorder: AppStyles.inputBorderOutline,
            border: AppStyles.inputBorderOutline,
            isDense: true),
        validator: (text) => validator?.call(text!),
        onSaved: (text) => onSaved?.call(text!),
      );
}
