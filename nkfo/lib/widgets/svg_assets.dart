import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgAssets extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;

  const SvgAssets(
    this.path, {
    this.width,
    this.height
  });

  String get appender =>  'assets/';  //kIsWeb ? '' :

  @override
  Widget build(BuildContext context) => SvgPicture.asset(
    '$appender$path',
    width: width,
    height: height,
  );
}