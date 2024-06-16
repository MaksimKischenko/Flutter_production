import 'package:bpc/styles.dart';
import 'package:flutter/material.dart';

class DevicesButton extends StatelessWidget {
  final VoidCallback onTap;

  const DevicesButton({
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
    color: Theme.of(context).primaryColorLight,
    textColor: Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(
          Icons.outlined_flag,
          color: AppStyles.mainColor,
        ),
        SizedBox(width: 4),
        Text(
          'Счетчики',
          style: TextStyle(
            color: AppStyles.mainColor,
            fontSize: 16
          ),
        ),
      ],
    )
  );
}