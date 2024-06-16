import 'package:flutter/material.dart';

class PhoneField extends StatelessWidget {
  final FocusNode? focusNode;
  final String? Function(String value)? validator;
  final Function(String value)? onSaved;

  const PhoneField({
    this.focusNode,
    this.validator,
    this.onSaved
  });

  @override
  Widget build(BuildContext context) => TextFormField(
    // initialValue: "+375291181186",
    focusNode: focusNode,
    keyboardType: TextInputType.phone,
    decoration: const InputDecoration(
      labelText: 'Телефон',
    ),
    validator: (value) => validator?.call(value!),
    onSaved: (value) => onSaved?.call(value!),
  );
}