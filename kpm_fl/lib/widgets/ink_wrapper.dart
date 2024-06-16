import 'package:flutter/material.dart';

class InkWrapper extends StatelessWidget {
  // final Color splashColor;
  final Widget child;
  final VoidCallback onTap;
  final double borderRadius;

  const InkWrapper({
    // this.splashColor,
    required this.child,
    required this.onTap,
    this.borderRadius = 0,
  });

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(borderRadius),
    child: Stack(
      children: [
        Positioned.fill(child: child),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              // splashColor: splashColor,
              onTap: onTap,
            ),
          ),
        ),
      ],
    ),
  );
}