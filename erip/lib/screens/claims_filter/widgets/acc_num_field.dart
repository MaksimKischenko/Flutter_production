import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class AccNumField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;

  const AccNumField({
    required this.controller,
    this.focusNode
  });

  @override
  Widget build(BuildContext context) => TextFormField(
    controller: controller,
    keyboardType: TextInputType.text,
    inputFormatters: [
      FilteringTextInputFormatter.deny(RegExp('[\u0430-\u044F\u0410-\u042F]|\u0020'))
    ],
    autocorrect: false,
    decoration: const InputDecoration(
      labelText: 'Номер счета',
    ),
    // ignore: prefer_expression_function_bodies
    validator: (value) {
      // if (value.isEmpty) {
      //   return "Некорректный номер счета";
      // }
      return null;
    },
  );
}