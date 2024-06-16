import 'package:fl_qr_module/navigation.dart';
import 'package:fl_qr_module/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ArrowBack extends StatelessWidget {
  @override
  Widget build(BuildContext context) => IconButton(
        // onPressed: () => Navigator.pop(context),
        onPressed: () => Navigation.navigatorKey.currentState?.pop(),
        icon: SvgPicture.asset(
          'assets/icon/arrow_back.svg',
          colorFilter:
              const ColorFilter.mode(AppStyles.mainColorDark, BlendMode.srcIn),
        ),
      );
}
