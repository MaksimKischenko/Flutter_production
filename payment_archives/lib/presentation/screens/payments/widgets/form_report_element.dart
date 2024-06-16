import 'package:flutter/material.dart';
import 'package:payment_tracking_module/presentation/styles.dart';

class ActionIconElement extends StatelessWidget {

  final String actionName; 
  final Icon icon;
  final bool isAvailable;
  final Function() onTap;

  const ActionIconElement({
     required this.onTap,
     required this.icon,
     required this.actionName,
     this.isAvailable = false,
  }); 

  @override
  Widget build(BuildContext context) => Tooltip(
    message: actionName,
    child: Material(
      child: IconButton(
        splashRadius: 22,
        onPressed: isAvailable ? onTap : null, 
        icon: icon,
        disabledColor: AppStyles.colorDark2.withOpacity(0.3),
        color: AppStyles.colorDark2,
      ),
    ),
  ); 
}