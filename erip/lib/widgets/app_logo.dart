import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppLogo extends StatelessWidget {
  final double size;

  const AppLogo({
    this.size = 180
  });
  
  @override
  Widget build(BuildContext context) => SvgPicture.asset(
    'assets/images/main_logo.svg',
    width: size,
  );
}

