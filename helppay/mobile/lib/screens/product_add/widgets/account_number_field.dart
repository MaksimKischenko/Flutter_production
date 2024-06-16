import 'package:flutter/material.dart';
import 'package:helppay/styles.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

void _log(dynamic message) => Logger.helpPayLog(message, name: 'account_form ');

class AccountNumberField extends StatefulWidget {
  final TextEditingController textFieldController;
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;
  final Function(String) onSaved;

  const AccountNumberField({
    required this.textFieldController,
    this.focusNode,
    this.onFieldSubmitted,
    required this.onSaved,
  });

  @override
  State<AccountNumberField> createState() => _AccountNumberFieldState();
}

class _AccountNumberFieldState extends State<AccountNumberField> {
  @override
  void initState() {
    super.initState();
  }

  final _accountNumberFormatter = MaskTextInputFormatter(
      mask: '## AAAA #### #### #### #### ####',
      filter: {'#': RegExp('[0-9]'), 'A': RegExp('[a-zA-Z]')});

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: widget.textFieldController,
        autocorrect: false,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        maxLength: 32,
        inputFormatters: [UpperCaseTextFormatter(), _accountNumberFormatter],
        focusNode: widget.focusNode,
        decoration: InputDecoration(
            prefixText: 'BY',
            labelText: context.t.mobileScreens.productAdd.accountForm
                .accountNumberField.tilte,
            hintText: '00 XXXX 0000 0000 0000 0000 0000',
            counterText: '',
            alignLabelWithHint: true,
            labelStyle: AppStyles.inputLabelUnderlineStyle,
            enabledBorder: AppStyles.inputBorderUnderline,
            border: AppStyles.inputBorderUnderline,
            isDense: true),
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return context.t.mobileScreens.productAdd.accountForm
                .accountNumberField.errors.empty;
          }
          if (_accountNumberFormatter.getUnmaskedText().length != 26) {
            return context.t.mobileScreens.productAdd.accountForm
                .accountNumberField.errors.incorrectFormat;
          }
          return null;
        },
        onFieldSubmitted: (value) => widget.onFieldSubmitted?.call(value),
        onChanged: (_) {
          _log('account number - ${widget.textFieldController.text}');
          widget.onSaved('BY${widget.textFieldController.text.trim()}');
        },
        onSaved: (_) =>
            widget.onSaved('BY${widget.textFieldController.text.trim()}'),
      );
}
