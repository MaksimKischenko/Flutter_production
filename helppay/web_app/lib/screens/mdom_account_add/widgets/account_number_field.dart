import 'package:flutter/material.dart';
// import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/styles.dart';

class AccountNumberField extends StatelessWidget {
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;
  final Function(String) onSaved;

  // final _accountNumberFormatter = MaskTextInputFormatter(
  //   mask: '## AAAA #### #### #### #### ####',
  //   filter: {'#': RegExp('[0-9]'), 'A': RegExp('[a-zA-Z]')}
  // );

  const AccountNumberField(
      {required this.onSaved, this.focusNode, this.onFieldSubmitted});

  @override
  Widget build(BuildContext context) => TextFormField(
        autocorrect: false,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        maxLength: 32,
        inputFormatters: [
          UpperCaseTextFormatter(),
          // _accountNumberFormatter
        ],
        focusNode: focusNode,
        decoration: InputDecoration(
            labelText: '${t.mobileScreens.mdomAccountAdd.accountNumberField.title}*',
            counterText: '',
            alignLabelWithHint: true,
            labelStyle: AppStyles.inputLabelOutlineStyle,
            enabledBorder: AppStyles.inputBorderOutline,
            border: AppStyles.inputBorderOutline,
            isDense: true
        ),
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return t.mobileScreens.mdomAccountAdd.accountNumberField.errors.empty;
          }
          // if (_accountNumberFormatter.getUnmaskedText().length != 26) {
          //   return 'Неверный формат номера счета';
          // }
          return null;
        },
        onFieldSubmitted: (value) {
          onFieldSubmitted?.call(value);
        },
        onSaved: (value) => onSaved(value!),
        // onSaved: (_) => onSaved('BY${_accountNumberFormatter.getUnmaskedText()}'),
      );
}
