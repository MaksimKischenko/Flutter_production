import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:helppay/styles.dart';
import 'package:helppay_core/helppay_core.dart';

class CodeField extends StatelessWidget {
  final ConfirmCodeType codeType;
  final Function(String) onSaved;

  const CodeField({
    required this.codeType,
    required this.onSaved
  });

  @override
  Widget build(BuildContext context) => TextFormField(
    autocorrect: false,
    keyboardType: TextInputType.number,
    textInputAction: TextInputAction.done,
    maxLength: 4,
    decoration: InputDecoration(
      labelText: codeType == ConfirmCodeType.email
          ? context.t.mobileScreens.registrationCode.codeField.title.email
          : context.t.mobileScreens.registrationCode.codeField.title.sms,
      hintText: '',
      labelStyle: AppStyles.inputLabelStyle,
      enabledBorder: AppStyles.inputBorder,
      border: AppStyles.inputBorder,
      isDense: true,
    ),
    validator: (code) {
      if (code?.isEmpty ?? true) {
        return context.t.mobileScreens.registrationCode.codeField.errors.empty;
      }
      if (code!.length < 4) {
        return context.t.mobileScreens.registrationCode.codeField.errors.empty;
      }
      final _code = code.toIntOrNull();
      if (_code == null) {
        return context.t.mobileScreens.registrationCode.codeField.errors.incorrectFormat;
      }
      return null;
    },
    onSaved: (value) => onSaved(value!),
  );
}