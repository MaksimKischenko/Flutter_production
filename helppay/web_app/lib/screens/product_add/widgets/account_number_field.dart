import 'package:flutter/material.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/styles.dart';
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
  Widget build(BuildContext context) => SizedBox(
    width: 500,
    child: TextFormField(
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
        labelText: context.t.mobileScreens.productAdd.accountForm.accountNumberField.tilte,
        hintText: '00 XXXX 0000 0000 0000 0000 0000',
        counterText: '',
        alignLabelWithHint: true,
        labelStyle: AppStyles.inputLabelUnderlineStyle,
        enabledBorder: AppStyles.inputBorderOutline,
        border: AppStyles.inputBorderOutline,
        // enabledBorder: AppStyles.inputWebBorder,
        // focusedBorder: AppStyles.inputWebBorder,
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
    ),
  );
}