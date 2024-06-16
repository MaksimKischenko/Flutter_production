import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  final FocusNode? focusNode;
  final String? Function(String value)? validator;
  final Function(String value)? onSaved;

  const EmailField({
    this.focusNode,
    this.validator,
    this.onSaved
  });

  @override
  Widget build(BuildContext context) => TextFormField(
      // initialValue: "mobile@mdom.by",
      focusNode: focusNode,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        labelText: 'E-mail',
      ),
      validator: (value) => validator?.call(value!),
      onSaved: (value) => onSaved?.call(value!),
    );
}