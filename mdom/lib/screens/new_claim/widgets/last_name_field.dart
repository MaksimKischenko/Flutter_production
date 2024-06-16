import 'package:flutter/material.dart';

class LastNameField extends StatelessWidget {
  final Function(String value)? onSaved;
  final FocusNode? focusNode;

  const LastNameField({
    this.onSaved,
    this.focusNode
  });

  @override
  Widget build(BuildContext context) => TextFormField(
    focusNode: focusNode,
    // initialValue: "Иванов",
    keyboardType: TextInputType.text,
    autocorrect: false,
    decoration: const InputDecoration(
      labelText: 'Фамилия',
    ),
    onSaved: (value) => onSaved?.call(value!),
  );
}