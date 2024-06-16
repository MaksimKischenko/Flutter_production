import 'package:bpc/styles.dart';
import 'package:flutter/material.dart';

class KeyField extends StatelessWidget {
  final FocusNode? focusNode;
  final Function(String value)? onFieldSubmitted;
  final Function(String value)? onSaved;
  final bool needValidate;
  final TextEditingController? controller;

  const KeyField({
    this.focusNode,
    this.onFieldSubmitted,
    this.onSaved,
    required this.needValidate,
    this.controller
  });

  @override
  Widget build(BuildContext context) => TextFormField(
    controller: controller,
    autocorrect: false,
    keyboardType: TextInputType.text,
    textInputAction: TextInputAction.done,
    focusNode: focusNode,
    decoration: InputDecoration(
      labelText: 'Код',
      hintText: 'Введите ваш код',
      alignLabelWithHint: true,
      labelStyle: AppStyles.inputLabelStyle,
      enabledBorder: AppStyles.inputBorder,
      border: AppStyles.inputBorder,
      isDense: true,
    ),
    validator: (value) {
      if (needValidate) {
        if (value?.isEmpty ?? true) {
          return 'Поле обязательно для заполнения';
        }
      }
      return null;
    },
    onFieldSubmitted: (value) => onFieldSubmitted?.call(value),
    onSaved: (value) => onSaved?.call(value!),
  );
}