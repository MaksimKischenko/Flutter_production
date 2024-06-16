import 'package:flutter/material.dart';
import 'package:isc_web_app/generated/translations.g.dart';
import 'package:isc_web_app/styles.dart';


class MemNumberField extends StatelessWidget {
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;
  final Function(String) onSaved;

  const MemNumberField({
    required this.onSaved,
    this.focusNode,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) => TextFormField(
      autocorrect: false,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      maxLength: 20,
      focusNode: focusNode,
      decoration: InputDecoration(
        labelText: 'Номер платежного документа*',
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
