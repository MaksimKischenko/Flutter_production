import 'package:bpc/styles.dart';
import 'package:flutter/material.dart';

class ServiceField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onTap;

  const ServiceField({
    required this.controller,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) => TextField(
    controller: controller,
    onTap: onTap,
    readOnly: true,
    decoration: const InputDecoration(
      labelText: 'Услуга',
      suffixIcon: Padding(
          padding: EdgeInsets.only(top: 16, left: 10),
          child: Icon(
            Icons.expand_more,
            color: AppStyles.mainColor,
            size: 35,
          )
      )
    ),
  );
}