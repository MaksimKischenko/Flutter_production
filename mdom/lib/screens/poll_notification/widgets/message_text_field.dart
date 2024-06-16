import 'package:bpc/styles.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';

class MessageTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String value) onChanged;
  final String? Function(String value)? onSaved;

  const MessageTextField({
    Key? key,
    required this.controller,
    required this.onChanged,
    this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => TextFormField(
    controller: controller,
    autocorrect: false,
    minLines: 1,
    maxLines: 10,
    decoration: InputDecoration(
      labelText: 'Текст оповещения*',
      // hintText: hint,
      counterText: '',
      alignLabelWithHint: true,
      labelStyle: AppStyles.inputLabelUnderlineStyle,
      focusedBorder: AppStyles.inputBorderUnderline,
      enabledBorder: AppStyles.inputBorderUnderline,
      border: AppStyles.inputBorderUnderline,
      isDense: true,
    ),
    onChanged: onChanged,
    onSaved: (value) => onSaved?.call(value!),
    validator: (value) {
      if (value.isNullOrEmpty) {
        return 'Обязательное поле';
      }

      return null;
    },
    // onChanged: (value) {
    //   try {
    //     final date = DateFormat('dd/MM/yyyy').parse(value);
    //     return onChanged?.call(date);
    //   } catch (e) {}
    // },
  );
}