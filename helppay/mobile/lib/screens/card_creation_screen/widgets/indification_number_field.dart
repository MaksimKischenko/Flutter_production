import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helppay/styles.dart';
import 'package:helppay_core/helppay_core.dart';

class IndificationNumberField extends StatelessWidget {
  final FocusNode? focusNode;
  final Function(String value)? onFieldSubmitted;
  final Function(String value)? onSaved;

  const IndificationNumberField({
    this.focusNode,
    this.onFieldSubmitted,
    this.onSaved
  });

  @override
  Widget build(BuildContext context) => TextFormField(
    autocorrect: false,
    keyboardType: TextInputType.multiline,
    inputFormatters: [
      LengthLimitingTextInputFormatter(14)
    ],
    focusNode: focusNode,
    decoration: InputDecoration(
      labelText: context.t.mobileScreens.cardRegistration.params.indificationNumberField,
      hintText: '',
      alignLabelWithHint: true,
      labelStyle: AppStyles.inputLabelStyle,
      enabledBorder: AppStyles.inputBorder,
      border: AppStyles.inputBorder,
      isDense: true,
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return context.t.mobileScreens.cardRegistration.params.errorValidationMessages.validationIndification;
      }
      if(value.length < 14) {
        return context.t.mobileScreens.cardRegistration.params.errorValidationMessages.validationIndificationCorrect;
      }
      return null;
    },    
    onFieldSubmitted: (value) => onFieldSubmitted?.call(value),
    onSaved: (value) => onSaved?.call(value!),
  );
}