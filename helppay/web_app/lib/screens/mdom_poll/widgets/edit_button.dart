import 'package:flutter/material.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/styles.dart';

class EditButton extends StatelessWidget {
  final Function(BuildContext context) onTap;

  const EditButton({required this.onTap});

  @override
  Widget build(BuildContext context) => MaterialButton(
      onPressed: () => onTap(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0,
      highlightElevation: 0,
      minWidth: double.maxFinite,
      disabledColor: const Color(0xff8498BC),
      color: AppStyles.mainColor,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Text(
        context.t.mobileScreens.mdomPoll.editButton,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ));
}
