import 'package:bpc/styles.dart';
import 'package:flutter/material.dart';

class PaymentStatusField extends StatelessWidget {
  final TextEditingController? controller;
  final VoidCallback? onTap;

  const PaymentStatusField({
    this.controller,
    this.onTap
  });

  @override
  Widget build(BuildContext context) => TextFormField(
    controller: controller,
    onTap: onTap,
    readOnly: true,
    decoration: const InputDecoration(
        labelText: 'Тип платежей',
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