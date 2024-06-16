import 'package:bpc/styles.dart';
import 'package:flutter/material.dart';

class DueTimeField extends StatelessWidget {
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final Function(String value)? onSaved;
  final FocusNode? focusNode;

  const DueTimeField({
    this.controller,
    this.onTap,
    this.onSaved,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) => TextFormField(
    focusNode: focusNode,
    controller: controller,
    onTap: onTap,
    readOnly: true,
    decoration: const InputDecoration(
      labelText: 'Время оплаты *',
      suffixIcon: Padding(
        padding: EdgeInsets.only(top: 16, left: 10),
        child: Icon(
          Icons.schedule,
          color: AppStyles.mainColor
        )
      )
    ),
    validator: (value) {
      if (value?.isEmpty ?? true) {
        return 'Некорректное время';
      }
      return null;
    },
    // validator: (_) {
    //   int isBefore = _dueDate?.compareTo(DateTime.now()) ?? -1;
    //   if (isBefore < 0) {
    //     return "Некорректная дата";
    //   }
    //   return null;
    // },
    onSaved: (value) => onSaved?.call(value!),
  );
}