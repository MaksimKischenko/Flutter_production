import 'package:bpc/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BiometricAuthFlag extends StatelessWidget {
  final bool value;
  final String text;
  final Function(bool value) onTap;

  const BiometricAuthFlag({
    required this.value,
    required this.text,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) => ListTile(
    onTap: () => onTap(!value),
    title: Text(text),
    trailing: CupertinoSwitch(
      activeColor: AppStyles.mainColor,
      value: value,
      onChanged: onTap,
    ),
  );
}