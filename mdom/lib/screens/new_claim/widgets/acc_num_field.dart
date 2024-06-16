import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AccNumField extends StatelessWidget {
  final Function(String value)? onSaved;
  final FocusNode? focusNode;

  const AccNumField({
    this.onSaved,
    this.focusNode
  });

  @override
  Widget build(BuildContext context) => TextFormField(
    focusNode: focusNode,
    // initialValue: "12345678",
    keyboardType: TextInputType.text,
    autocorrect: false,
    inputFormatters: [
      FilteringTextInputFormatter.deny(RegExp('[\u0430-\u044F\u0410-\u042F]|\u0020'))
    ],
    decoration: const InputDecoration(
      labelText: 'Номер счета *',
    ),
    validator: (value) {
      if (value?.isEmpty ?? true) {
        return 'Некорректный номер';
      }
      return null;
    },
    onSaved: (value) => onSaved?.call(value!),
  );
}