import 'package:flutter/material.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/styles.dart';

class DeleteButton extends StatelessWidget {
  final Function() onPressed;

  const DeleteButton({
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    child: TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        )),
        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 29)),
      ),
      child: Text(
        context.t.mobileScreens.cardInfo.deleteButton,
        style: const TextStyle(
          color: AppStyles.mainColor,
          fontSize: 16,
          fontWeight: FontWeight.w500
        ),
      ),
    ),
  );
}