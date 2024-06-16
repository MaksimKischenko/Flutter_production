import 'package:bpc/styles.dart';
import 'package:flutter/material.dart';

class ItemUnitText extends StatelessWidget {
  final String value;

  const ItemUnitText(this.value);

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text(
        'Ед.измерения',
        style: TextStyle(
          color: AppStyles.mainTextColor.withOpacity(0.7),
          fontSize: 16
        ),
      ),
      const SizedBox(height: 4),
      Text(
        value,
        style: const TextStyle(
          // fontWeight: FontWeight.bold
          fontSize: 16
        ),
      )
    ],
  );
}