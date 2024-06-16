import 'package:flutter/material.dart';
import 'package:helppay/styles.dart';
import 'package:helppay_core/helppay_core.dart';

class AddButton extends StatelessWidget {
  final Function() onPressed;

  const AddButton({
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) => TextButton(
    onPressed: onPressed,
    child: Text(
      context.t.mobileScreens.mdomAccruals.addButton,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: AppStyles.mainColor
      ),
    ),
  );
}