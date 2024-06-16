

import 'package:flutter/material.dart';
import 'package:isc_web_app/styles.dart';

class NoSplashButton extends StatelessWidget {

  final Function() onTap;
  final String text;
  final bool withAddIcon;

  const NoSplashButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.withAddIcon = true
  }) : super(key: key);


  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    behavior: HitTestBehavior.translucent,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: withAddIcon? Row(
        children: [
          const Icon(
            Icons.add, 
            size: 18, 
            color: AppStyles.mainColor
          ),
          const SizedBox(width: 4),                                        
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppStyles.mainColor,
            ),
          ),
        ],
    ) : Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppStyles.mainColor,
          ),
       ),
    ),
  );
}