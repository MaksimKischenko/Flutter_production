import 'package:flutter/material.dart';

class PatronymicField extends StatelessWidget {
  final Function(String value)? onSaved;
  final FocusNode? focusNode;

  const PatronymicField({
    required this.onSaved,
    this.focusNode
  });

  @override
  Widget build(BuildContext context) => TextFormField(
    focusNode: focusNode,
    // initialValue: "Иванович",
    keyboardType: TextInputType.text,
    autocorrect: false,
    decoration: const InputDecoration(
      labelText: 'Отчество',
    ),
    onSaved: (value) => onSaved?.call(value!),
  );
}