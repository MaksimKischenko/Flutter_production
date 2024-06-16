import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helppay/styles.dart';
import 'package:helppay_core/helppay_core.dart';

class PhoneNumberField extends StatelessWidget {
  final FocusNode? focusNode;
  final Function(String value)? onFieldSubmitted;
  final Function(String value)? onSaved;
  final Function(String value)? onChanged;

  const PhoneNumberField({
    this.focusNode,
    this.onFieldSubmitted,
    this.onSaved,
    this.onChanged
  });

  @override
  Widget build(BuildContext context) => TextFormField(
    autocorrect: false,
    keyboardType: TextInputType.phone,
    inputFormatters: [
      FilteringTextInputFormatter.allow(RegExp('[0-9]')),
      LengthLimitingTextInputFormatter(9)
    ],
    focusNode: focusNode,
    decoration: InputDecoration(
      labelText: context.t.mobileScreens.cardRegistration.params.phoneField,
      prefixText: '+375',
      hintText: '',
      alignLabelWithHint: true,
      labelStyle: AppStyles.inputLabelStyle,
      enabledBorder: AppStyles.inputBorder,
      border: AppStyles.inputBorder,
      isDense: true,
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return context.t.mobileScreens.cardRegistration.params.errorValidationMessages.validationPhone;
      }
      if(value.length < 9) {
        return context.t.mobileScreens.cardRegistration.params.errorValidationMessages.validationPhoneCorrect;
      }
      return null;
    },    
    onFieldSubmitted: (value) => onFieldSubmitted?.call(value),
    onSaved: (value) => onSaved?.call(value!),
    onChanged: (value) => onChanged?.call(value),
  );
}