import 'package:flutter/material.dart';
// import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:helppay/styles.dart';
import 'package:helppay_core/helppay_core.dart';

class CodeWordField extends StatelessWidget {
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;
  final Function(String) onSaved;

  // final _codeWordFormatter = MaskTextInputFormatter(mask: '#########', filter: { "#": RegExp(r'[0-9]')});

  const CodeWordField({
    required this.onSaved,
    this.focusNode,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) => TextFormField(
    autocorrect: false,
    textInputAction: TextInputAction.done,
    maxLength: 20,
    inputFormatters: const [
      // _codeWordFormatter
    ],
    focusNode: focusNode,
    decoration: InputDecoration(
      labelText: '${context.t.mobileScreens.mdomAccountAdd.codeWordField.title}*',
      // hintText: 'СОКОЛ',
      counterText: '',
      alignLabelWithHint: true,
      labelStyle: AppStyles.inputLabelUnderlineStyle,
      enabledBorder: AppStyles.inputBorderUnderline,
      border: AppStyles.inputBorderUnderline,
      isDense: true,
    ),
    validator: (codeWord) {
      if (codeWord?.isEmpty ?? true) {
        return t.mobileScreens.mdomAccountAdd.codeWordField.errors.empty;
      }
      // if (codeWord!.length != 5) {
      //   return 'Неверный формат кодового слова';
      // }
      return null;
    },
    onFieldSubmitted: (codeWord) {
      onFieldSubmitted?.call(codeWord);
    },
    onSaved: (value) => onSaved(value!),
  );
}