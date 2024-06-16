
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ResponsiveLayoutElement extends StatelessWidget {
  final SizingInformation sizingInformation;
  final List<Widget> children;
  final MainAxisSize mainAxisSize;
  final MainAxisAlignment mainAxisAlignment;

  const ResponsiveLayoutElement({
    required this.sizingInformation,
    required this.children,
    required this.mainAxisSize,
    required this.mainAxisAlignment,
    Key? key,
  }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    if(sizingInformation.screenSize.width > 1200) {
      return Row(
        mainAxisSize: mainAxisSize,
        mainAxisAlignment: mainAxisAlignment,
        children: children.expand((widget) => [
          widget, 
          const SizedBox(
            width:200
          )
        ]).toList(),
      );
    } else {
      return Column(
        mainAxisSize: mainAxisSize,
        mainAxisAlignment: mainAxisAlignment,
        children: children.expand((widget) => [
          widget, 
          const SizedBox(
            height:100
          )
        ]).toList(),
      );
    }
  }
}
