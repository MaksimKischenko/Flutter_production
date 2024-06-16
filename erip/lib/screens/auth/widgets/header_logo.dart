import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HeaderLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SvgPicture.asset(
    'assets/images/main_logo.svg',
    width: 180,
  );
}