import 'package:flutter/material.dart';
import 'package:isc_web_app/generated/translations.g.dart';
import 'package:isc_web_app/styles.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PaySumField extends StatelessWidget {
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;
  final Function(String) onSaved;
  final MaskTextInputFormatter sumFormatter;

  PaySumField({
    required this.onSaved,
    this.focusNode,
    this.onFieldSubmitted,
  }) : sumFormatter = MaskTextInputFormatter(mask: '#########', filter: { '#': RegExp('[.0-9]')});

  @override
  Widget build(BuildContext context) => TextFormField(
        autocorrect: false,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.done,
        maxLength: 20,
        inputFormatters: [
          sumFormatter
        ],
        focusNode: focusNode,
        decoration: InputDecoration(
          labelText: 'Сумма оплаты*',
          counterText: '',
          alignLabelWithHint: true,
          labelStyle: AppStyles.inputLabelUnderlineStyle,
          enabledBorder: AppStyles.inputBorderOutline,
          border: AppStyles.inputBorderOutline,
          errorBorder: AppStyles.errorWebBorder,
          focusedErrorBorder: AppStyles.errorWebBorder,
          isDense: true,
        ),
        validator: (codeWord) {
          if (codeWord?.isEmpty ?? true) {
            return t.mobileScreens.mdomAccountAdd.codeWordField.errors.empty;
          }
          return null;
        },
        onFieldSubmitted: (codeWord) {
          onFieldSubmitted?.call(codeWord);
        },
        onSaved: (value) => onSaved(value!),
      );
}
