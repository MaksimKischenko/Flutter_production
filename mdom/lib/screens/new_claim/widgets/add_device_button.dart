import 'package:bpc/styles.dart';
import 'package:flutter/material.dart';

class AddDeviceButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddDeviceButton({
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) => MaterialButton(
    onPressed: onPressed,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    elevation: 0,
    //focusElevation: 0,
    highlightElevation: 0,
    minWidth: double.maxFinite,
    color: AppStyles.mainColor.withOpacity(0.05),
    textColor: AppStyles.mainColor,
    padding: const EdgeInsets.symmetric(vertical: 16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(
          Icons.add,
          color: AppStyles.mainColor,
        ),
        SizedBox(width: 4),
        Text(
          'Добавить',
          style: TextStyle(
            fontSize: 16
          ),
        ),
      ],
    ),
  );
}