import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helppay/styles.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:sms_autofill/sms_autofill.dart';

class ConfirmationCodeField extends StatelessWidget {
  final FocusNode? focusNode;
  final String? currentCode;
  final Function(String? value)? onCodeSubmitted;
  final Function(String? value)? onCodeChanged; 
  final Function(String value)? onSaved;

  const ConfirmationCodeField({
    this.focusNode,
    this.currentCode,
    this.onCodeSubmitted,
    this.onCodeChanged,
    this.onSaved
  });

  @override
  Widget build(BuildContext context) => TextFieldPinAutoFill(
    currentCode: currentCode,
    codeLength: 4,
    inputFormatters: [
      FilteringTextInputFormatter.allow(RegExp('[0-9]')),
      LengthLimitingTextInputFormatter(6)
    ],
    focusNode: focusNode,
    decoration: InputDecoration(
      labelText: context.t.mobileScreens.cardRegistration.params.confirmationCodeField,
      hintText: '',
      alignLabelWithHint: true,
      labelStyle: AppStyles.inputLabelStyle,
      enabledBorder: AppStyles.inputBorder,
      border: AppStyles.inputBorder,
      isDense: true,
    ),
    // validator: (value) {
    //   if (value == null || value.isEmpty) {
    //     return context.t.mobileScreens.cardRegistration.params.errorValidationMessages.validationCode;
    //   }
    //   return null;
    // },    
    onCodeSubmitted: (code) => onCodeSubmitted?.call(code),
    onCodeChanged: (code) => onCodeChanged?.call(code),
  );
}