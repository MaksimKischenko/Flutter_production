import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helppay_web_app/styles.dart';


class ArrowBack extends StatelessWidget {
  @override
  Widget build(BuildContext context) => IconButton(
    // onPressed: () => Navigator.pop(context),
    onPressed: () => AutoRouter.of(context).navigatorKey.currentState?.pop(),
    icon: SvgPicture.asset(
      'assets/icon/arrow_back.svg',
      colorFilter: const ColorFilter.mode(AppStyles.mainColorDark, BlendMode.srcIn),
    ),
  );
}