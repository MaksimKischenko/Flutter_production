import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helppay/styles.dart';
import 'package:helppay_core/helppay_core.dart';

class CodeWordField extends StatelessWidget {
  final FocusNode? focusNode;
  final Function(String value)? onFieldSubmitted;
  final Function(String value)? onSaved;

  const CodeWordField({
    this.focusNode,
    this.onFieldSubmitted,
    this.onSaved
  });

  @override
  Widget build(BuildContext context) => TextFormField(
    autocorrect: false,
    keyboardType: TextInputType.multiline,
    inputFormatters: [
      FilteringTextInputFormatter.allow(RegExp('[a-zA-Zа-яА-Я]')),
      LengthLimitingTextInputFormatter(25)
    ],
    focusNode: focusNode,
    decoration: InputDecoration(
      labelText: context.t.mobileScreens.cardRegistration.params.codeWordField,
      hintText: '',
      alignLabelWithHint: true,
      labelStyle: AppStyles.inputLabelStyle,
      enabledBorder: AppStyles.inputBorder,
      border: AppStyles.inputBorder,
      isDense: true,
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return context.t.mobileScreens.cardRegistration.params.errorValidationMessages.validationCodeWord;
      }
      return null;
    },    
    onFieldSubmitted: (value) => onFieldSubmitted?.call(value),
    onSaved: (value) => onSaved?.call(value!),
  );
}