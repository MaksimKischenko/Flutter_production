import 'package:bpc_nkfo/styles.dart';
import 'package:flutter/material.dart';

class ServiceField extends StatelessWidget {
  final TextEditingController? controller;
  final Function()? onTap;

  const ServiceField({
    required this.controller,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) => TextFormField(
    controller: controller,
    onTap: () => onTap?.call(),
    readOnly: true,
    decoration: const InputDecoration(
      labelText: 'Услуга *',
      suffixIcon: Padding(
        padding: EdgeInsets.only(top: 16, left: 10),
        child: Icon(
          Icons.expand_more,
          color: AppStyles.mainColor,
          size: 35,
        )
      )
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Выберите услугу';
      }
      return null;
    }
  );
}