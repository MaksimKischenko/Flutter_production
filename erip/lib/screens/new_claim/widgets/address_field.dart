import 'package:flutter/material.dart';

class AddressField extends StatelessWidget {
  final Function(String value)? onSaved;
  final FocusNode? focusNode;

  const AddressField({
    required this.onSaved,
    this.focusNode
  });

  @override
  Widget build(BuildContext context) => TextFormField(
    focusNode: focusNode,
    // initialValue: "Ложинская, 7",
    keyboardType: TextInputType.text,
    autocorrect: false,
    decoration: const InputDecoration(
      labelText: 'Адрес',
    ),
    onSaved: (value) => onSaved?.call(value!),
  );
}