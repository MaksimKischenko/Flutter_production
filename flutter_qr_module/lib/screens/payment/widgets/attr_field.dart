import 'package:fl_qr_module/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AttrField extends StatelessWidget {
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onSaved;
  final String? Function(String)? validator;
  final String labelText;
  final String? hintText;
  final String? initialValue;
  final int maxLength;
  final bool editable;

  const AttrField(
      {this.keyboardType = TextInputType.text,
      this.inputFormatters,
      this.onSaved,
      this.validator,
      required this.labelText,
      required this.hintText,
      this.initialValue,
      required this.maxLength,
      required this.editable});

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
          counterText: '',
          labelText: labelText,
          // hintText: hintText,
          helperText: hintText,
          alignLabelWithHint: true,
          labelStyle: AppStyles.inputLabelUnderlineStyle,
          enabledBorder: AppStyles.inputBorderUnderline,
          border: AppStyles.inputBorderUnderline,
          isDense: true,
        ),
        validator: (value) => validator?.call(value!),
        onSaved: (value) => onSaved?.call(value!),
      );
}
