import 'package:bpc_nkfo/styles.dart';
import 'package:flutter/material.dart';

class DevicesButton extends StatelessWidget {
  final Function()? onTap;

  const DevicesButton({
    required this.onTap
  });


  @override
  Widget build(BuildContext context) => MaterialButton(
    onPressed: () => onTap?.call(),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    elevation: 0,
    highlightElevation: 0,
    minWidth: double.maxFinite,
    color: Theme.of(context).primaryColorLight,
    textColor: Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 4),
          child: Icon(
            Icons.outlined_flag,
            color: AppStyles.mainColor,
          ),
        ),
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