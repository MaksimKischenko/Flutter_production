import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double size;

  const AppLogo({
    this.size = 130
  });
  
  @override
  Widget build(BuildContext context) => Image.asset(
    'assets/images/main-logo.png',
    width: size,
    height: size,
  );
  //=> SvgPicture.asset(
    // 'assets/images/main_logo.svg',
    // width: size,
  // );
}