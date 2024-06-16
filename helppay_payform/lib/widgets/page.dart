import 'package:flutter/material.dart';

class PageWidget extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  final EdgeInsetsGeometry padding; 

  const PageWidget({
    required this.child,
    this.maxWidth = 768,
    this.padding = const EdgeInsets.all(32)
  });
  
  @override
  Widget build(BuildContext context) => Center(
    child: Container(
      constraints: BoxConstraints(maxWidth: maxWidth),
      padding: padding,
      child: child,
    ),
  );
}
