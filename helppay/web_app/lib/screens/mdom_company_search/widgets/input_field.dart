import 'package:flutter/material.dart';
import 'package:helppay_web_app/styles.dart';


class SearcScreenInputField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? Function(String)? validator;
  final int? maxLength;
  final String fieldTitle;
  final TextInputType inputType;
  final Function(String)? onFieldSubmitted;

  const SearcScreenInputField({
    this.controller,
    this.focusNode,
    this.maxLength,
    required this.fieldTitle,
    required this.inputType,
    this.validator,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextFormField(
          controller: controller,
          autocorrect: false,
          keyboardType: inputType,
          textInputAction: TextInputAction.done,
          maxLength: maxLength,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: fieldTitle,
            counterText: '',
            alignLabelWithHint: true,
            labelStyle: AppStyles.inputLabelOutlineStyle,
            enabledBorder: AppStyles.inputBorderOutline,
            border: AppStyles.inputBorderOutline,
            isDense: true
          ),
          validator: (value) => validator?.call(value!),
          onFieldSubmitted: (value) {
            onFieldSubmitted?.call(value);
          },
          // onSaved: (_) => onSaved(_accountNumberFormatter.getUnmaskedText()),
        ),
      );
}
