import 'package:flutter/material.dart';

class DeviceNameField extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String value)? onSaved;
  final FocusNode? focusNode;

  const DeviceNameField({
    this.controller,
    this.onSaved,
    this.focusNode
  });

  @override
  Widget build(BuildContext context) => TextFormField(
    focusNode: focusNode,
    controller: controller,
    keyboardType: TextInputType.text,
    decoration: const InputDecoration(
      labelText: 'Наименование прибора учета *',
    ),
    validator: (value) {
      if (value?.isEmpty ?? true) return 'Обязательное поле';
      return null;
    },
    onSaved: (value) => onSaved?.call(value!),
  );
}