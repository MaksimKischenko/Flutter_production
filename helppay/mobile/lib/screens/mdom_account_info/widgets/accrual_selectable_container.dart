
import 'package:flutter/material.dart';
import 'package:helppay/styles.dart';

class AccrualSelectableContainer extends StatelessWidget {

  final Function() onTap;
  final Widget child;

  const AccrualSelectableContainer({
    Key? key,
    required this.onTap,
    required this.child,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) => GestureDetector(
    behavior: HitTestBehavior.translucent,
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: AppStyles.mainColor.withOpacity(0.1),
          blurRadius: 15,
          offset: const Offset(0, 4)
        )
      ]
    ),
      child: child,
    ),
  );
}
