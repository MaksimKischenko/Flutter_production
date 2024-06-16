import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/styles.dart';

class CvvField extends StatelessWidget {
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;
  final Function(String) onSaved;

  const CvvField({
    this.focusNode,
    this.onFieldSubmitted,
    required this.onSaved
  });

  @override
  Widget build(BuildContext context) => TextFormField(
    autocorrect: false,
    keyboardType: TextInputType.number,
    textInputAction: TextInputAction.done,
    maxLength: 3,
    inputFormatters: [
      FilteringTextInputFormatter.deny(RegExp('[\u0430-\u044F\u0410-\u042F]|\u0020'))
    ],
    focusNode: focusNode,
    decoration: InputDecoration(
      labelText: 'CVV*',
      hintText: 'XXX',
      counterText: '',
      alignLabelWithHint: true,
      labelStyle: AppStyles.inputLabelUnderlineStyle,
      enabledBorder: AppStyles.inputBorderOutline,
      border: AppStyles.inputBorderOutline,
      errorBorder: AppStyles.errorWebBorder,
      focusedErrorBorder: AppStyles.errorWebBorder,
      isDense: true
    ),
    validator: (cvv) {
      if (cvv?.isEmpty ?? true) {
        return context.t.mobileScreens.productAdd.cardForm.cvvField.errors.empty;
      }
      if (cvv!.toIntOrNull() == null || cvv.length != 3) {
        return context.t.mobileScreens.productAdd.cardForm.cvvField.errors.incorrectFormat;
      }
      return null;
    },
    onFieldSubmitted: (cvv) => onFieldSubmitted?.call(cvv),
    onSaved: (cvv) => onSaved(cvv!),
  );
}