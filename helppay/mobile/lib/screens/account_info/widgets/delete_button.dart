import 'package:flutter/material.dart';
import 'package:helppay/styles.dart';
import 'package:helppay_core/helppay_core.dart';

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
        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 14)),
      ),
      child: Text(
        context.t.mobileScreens.accountInfo.deleteButton,
        style: const TextStyle(
          color: AppStyles.mainColor,
          fontSize: 18,
          fontWeight: FontWeight.w300
        ),
      ),
    ),
  );
}