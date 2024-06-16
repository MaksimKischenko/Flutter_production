import 'package:bpc_nkfo/styles.dart';
import 'package:flutter/material.dart';

class DateField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Function() onTap;
  final String? Function()? validator;

  const DateField({
    required this.controller,
    required this.label,
    required this.onTap,
    required this.validator
  });

  @override
  Widget build(BuildContext context) => TextFormField(
    controller: controller,
    onTap: onTap,
    readOnly: true,
    decoration: InputDecoration(
      labelText: label,
      suffixIcon: const Padding(
        padding: EdgeInsets.only(top: 16, left: 10),
        child: Icon(
          Icons.calendar_today,
          color: AppStyles.mainColor,
        ),
      )
    ),
    validator: (_) => validator?.call(),
  );
}