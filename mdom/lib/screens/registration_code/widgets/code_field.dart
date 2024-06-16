import 'package:bpc/models/models.dart';
import 'package:bpc/styles.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';

class CodeField extends StatelessWidget {
  final ConfirmCodeType codeType;
  final Function(String code) onSaved;
  final FocusNode? focusNode;

  const CodeField({
    required this.codeType,
    required this.onSaved,
    this.focusNode
  });

  @override
  Widget build(BuildContext context) => TextFormField(
    focusNode: focusNode,
    autocorrect: false,
    keyboardType: TextInputType.number,
    textInputAction: TextInputAction.done,
    maxLength: 4,
    decoration: InputDecoration(
      labelText: codeType == ConfirmCodeType.email
          ? 'Код из E-mail'
          : 'Код из SMS',
      hintText: '',
      labelStyle: AppStyles.inputLabelStyle,
      enabledBorder: AppStyles.inputBorder,
      border: AppStyles.inputBorder,
      isDense: true,
    ),
    validator: (value) {
      if (value?.isEmpty ?? true) {
        return 'Поле обязательно для заполнения';
      }
      if (value!.length < 4) {
        return 'Поле обязательно для заполнения';
      }
      final _code = value.toIntOrNull();
      if (_code == null) {
        return 'Неверный формат';
      }
      return null;
    },
    onSaved: (value) => onSaved(value!),
  );
}