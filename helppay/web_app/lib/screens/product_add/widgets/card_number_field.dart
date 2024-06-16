import 'package:flutter/material.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/styles.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CardNumberField extends StatelessWidget {
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;
  final Function(String) onSaved;

  final _cardNumberFormatter = MaskTextInputFormatter(mask: '#### #### #### ####', filter: { '#': RegExp('[0-9]') });

  CardNumberField({
    this.focusNode,
    this.onFieldSubmitted,
    required this.onSaved
  });

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 500,
    child: TextFormField(
      autocorrect: false,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      maxLength: 19,
      inputFormatters: [_cardNumberFormatter],
      focusNode: focusNode,
      decoration: InputDecoration(
        labelText: context.t.mobileScreens.productAdd.cardForm.cardNumberField.tilte,
        hintText: '0000 0000 0000 0000',
        counterText: '',
        alignLabelWithHint: true,
        labelStyle: AppStyles.inputLabelUnderlineStyle,
        enabledBorder: AppStyles.inputBorderOutline,
        border: AppStyles.inputBorderOutline,
        errorBorder: AppStyles.errorWebBorder,
        focusedErrorBorder: AppStyles.errorWebBorder,
        isDense: true
      ),
      validator: (cardNumber) {
        if (cardNumber?.isEmpty ?? true) {
          return context.t.mobileScreens.productAdd.cardForm.cardNumberField.errors.empty;
        }
        if (_cardNumberFormatter.getUnmaskedText().length != 16) {
          return context.t.mobileScreens.productAdd.cardForm.cardNumberField.errors.incorrectFormat;
        }
        return null;
      },
      onFieldSubmitted: (cardNumber) => onFieldSubmitted?.call(cardNumber),
      onSaved: (_) => onSaved(_cardNumberFormatter.getUnmaskedText()),
    ),
  );
}