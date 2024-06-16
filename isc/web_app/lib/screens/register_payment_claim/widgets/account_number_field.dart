import 'package:flutter/material.dart';
import 'package:isc_web_app/generated/translations.g.dart';
import 'package:isc_web_app/styles.dart';
import 'package:isc_web_app/utils/text_input_formatters.dart';

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AccountNumberField extends StatelessWidget {
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;
  final Function(String) onSaved;

  final _accountNumberFormatter = MaskTextInputFormatter(mask: '## AAAA #### #### #### #### ####', filter: { '#': RegExp('[0-9]'), 'A': RegExp('[a-zA-Z]') });

  AccountNumberField({
    this.focusNode,
    this.onFieldSubmitted,
    required this.onSaved
  });

  @override
  Widget build(BuildContext context) => TextFormField(
    autocorrect: false,
    keyboardType: TextInputType.text,
    textInputAction: TextInputAction.done,
    maxLength: 32,
    inputFormatters: [
      UpperCaseTextFormatter(),
      _accountNumberFormatter
    ],
    focusNode: focusNode,
    decoration: InputDecoration(
      prefixText: 'BY',
      labelText: 'Номер расчетного счета на оплату*',
      hintText: '00 XXXX 0000 0000 0000 0000 0000',
      counterText: '',
      alignLabelWithHint: true,
      labelStyle: AppStyles.inputLabelUnderlineStyle,
      enabledBorder: AppStyles.inputBorderOutline,
      border: AppStyles.inputBorderOutline,
      errorBorder: AppStyles.errorWebBorder,
      focusedErrorBorder: AppStyles.errorWebBorder,
      isDense: true
    ),
    validator: (value) {
      if (value?.isEmpty ?? true) {
        return context.t.mobileScreens.productAdd.accountForm.accountNumberField.errors.empty;
      }
      if (_accountNumberFormatter.getUnmaskedText().length != 26) {
        return context.t.mobileScreens.productAdd.accountForm.accountNumberField.errors.incorrectFormat;
      }
      return null;
    },
    onFieldSubmitted: (value) => onFieldSubmitted?.call(value),
    onSaved: (_) => onSaved('BY${_accountNumberFormatter.getUnmaskedText()}'),
  );
}