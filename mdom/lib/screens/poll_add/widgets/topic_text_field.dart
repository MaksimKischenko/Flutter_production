import 'package:bpc/styles.dart';
import 'package:flutter/material.dart';

class TopicTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String value) onChanged;

  const TopicTextField({
    Key? key,
    required this.controller,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => TextFormField(
    controller: controller,
    autocorrect: false,
    minLines: 1,
    maxLines: 3,
    decoration: InputDecoration(
      labelText: 'Собрание (опрос)*',
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
    // onChanged: (value) {
    //   try {
    //     final date = DateFormat('dd/MM/yyyy').parse(value);
    //     return onChanged?.call(date);
    //   } catch (e) {}
    // },
  );
}