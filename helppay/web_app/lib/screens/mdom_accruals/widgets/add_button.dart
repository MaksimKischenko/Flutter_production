import 'package:flutter/material.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/styles.dart';

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
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppStyles.mainColor
      ),
    ),
  );
}