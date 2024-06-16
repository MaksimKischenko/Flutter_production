import 'package:flutter/material.dart';
import 'package:isc_web_app/styles.dart';

class DateField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final VoidCallback? onTap;
  final String? Function()? validator;

  const DateField({
    required this.controller,
    required this.label,
    this.onTap,
    this.validator
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