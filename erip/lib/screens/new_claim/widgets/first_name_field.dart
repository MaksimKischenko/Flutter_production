import 'package:flutter/material.dart';

class FirstNameField extends StatelessWidget {
  final Function(String value)? onSaved;
  final FocusNode? focusNode;

  const FirstNameField({
    required this.onSaved,
    this.focusNode
  });

  @override
  Widget build(BuildContext context) => TextFormField(
    focusNode: focusNode,
    // initialValue: "Иван",
    keyboardType: TextInputType.text,
    autocorrect: false,
    decoration: const InputDecoration(
      labelText: 'Имя',
    ),
    onSaved: (value) => onSaved?.call(value!),
  );
}