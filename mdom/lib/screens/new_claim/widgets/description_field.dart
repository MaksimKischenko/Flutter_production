import 'package:flutter/material.dart';

class DescriptionField extends StatelessWidget {
  final Function(String value)? onSaved;
  final FocusNode? focusNode;

  const DescriptionField({
    this.onSaved,
    this.focusNode
  });
  
  @override
  Widget build(BuildContext context) => TextFormField(
    focusNode: focusNode,
    // initialValue: "Пример описания",
    keyboardType: TextInputType.text,
    autocorrect: false,
    decoration: const InputDecoration(
      labelText: 'Описание',
    ),
    onSaved: (value) => onSaved?.call(value!),
  );
}