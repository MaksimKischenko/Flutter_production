import 'package:bpc_nkfo/styles.dart';
import 'package:flutter/material.dart';

class DueTimeField extends StatelessWidget {
  final TextEditingController? controller;
  final Function()? onTap;
  final Function(String value)? onSaved;
  final FocusNode? focusNode;

  const DueTimeField({
    required this.controller,
    required this.onTap,
    required this.onSaved,
    this.focusNode
  });

  @override
  Widget build(BuildContext context) => TextFormField(
    focusNode: focusNode,
    controller: controller,
    onTap: () => onTap?.call(),
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
      if (value == null || value.isEmpty) {
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