import 'package:bpc/styles.dart';
import 'package:flutter/material.dart';

class AddQuestionButton extends StatelessWidget {
  final VoidCallback onTap;

  const AddQuestionButton({
    required this.onTap
  });

  @override
  Widget build(BuildContext context) => MaterialButton(
    onPressed: onTap,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    elevation: 0,
    highlightElevation: 0,
    minWidth: double.maxFinite,
    color: const Color(0xffF1F3F8),
    disabledColor: AppStyles.mainTextColor.withOpacity(.3),
    padding: const EdgeInsets.symmetric(vertical: 14),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(
          Icons.add_rounded,
          color: AppStyles.mainColor,
          size: 24,
        ),
        SizedBox(width: 4),
        Text(
          'Добавить вопрос',
          style: TextStyle(
            color: AppStyles.mainColor,
            fontSize: 16,
            fontWeight: FontWeight.w400
          ),
        ),
      ],
    )
  );
}