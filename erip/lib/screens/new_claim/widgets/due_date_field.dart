import 'package:bpc_nkfo/styles.dart';
import 'package:flutter/material.dart';

class DueDateField extends StatelessWidget {
  final TextEditingController? controller;
  final Function()? onTap;
  final Function(String value)? onSaved;
  final FocusNode? focusNode;

  const DueDateField({
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
      labelText: 'Дата оплаты *',
      suffixIcon: Padding(
        padding: EdgeInsets.only(top: 16, left: 10),
        child: Icon(
          Icons.calendar_today,
          color: AppStyles.mainColor
        )
      )
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Некорректная дата';
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