import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/styles.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ExpiryField extends StatelessWidget {
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;
  final Function(String) onSaved;

  final _expiryDateFormatter = MaskTextInputFormatter(mask: '##/##', filter: { '#': RegExp('[0-9]') });

  ExpiryField({
    this.focusNode,
    this.onFieldSubmitted,
    required this.onSaved
  });

  @override
  Widget build(BuildContext context) => TextFormField(
    autocorrect: false,
    keyboardType: TextInputType.number,
    textInputAction: TextInputAction.done,
    maxLength: 5,
    inputFormatters: [_expiryDateFormatter],
    focusNode: focusNode,
    decoration: InputDecoration(
      labelText: context.t.mobileScreens.productAdd.cardForm.expiryField.tilte,
      hintText: 'XX/XX',
      counterText: '',
      alignLabelWithHint: true,
      labelStyle: AppStyles.inputLabelUnderlineStyle,
      enabledBorder: AppStyles.inputBorderOutline,
      border: AppStyles.inputBorderOutline,
      errorBorder: AppStyles.errorWebBorder,
      focusedErrorBorder: AppStyles.errorWebBorder,
      isDense: true
    ),
    validator: (expiry) {
      if (expiry?.isEmpty ?? true) {
        return context.t.mobileScreens.productAdd.cardForm.expiryField.errors.empty;
      }
      if (expiry!.length != 5) return context.t.mobileScreens.productAdd.cardForm.expiryField.errors.incorrectFormat;

      final now = DateTime.now();
      final currentYear = DateFormat('yy').format(now).toInt();

      final expiryUnmasked = _expiryDateFormatter.getUnmaskedText();
      final month = expiryUnmasked.substring(0, 2).toInt();
      final year = expiryUnmasked.substring(2, 4).toInt();

      if (month < 1 || month > 12) return context.t.mobileScreens.productAdd.cardForm.expiryField.errors.empty;
      if (year < currentYear) return context.t.mobileScreens.productAdd.cardForm.expiryField.errors.empty;

      return null;
    },
    onFieldSubmitted: (_) => onFieldSubmitted?.call(_expiryDateFormatter.getUnmaskedText()),
    onSaved: (_) => onSaved(_expiryDateFormatter.getUnmaskedText()),
  );
}