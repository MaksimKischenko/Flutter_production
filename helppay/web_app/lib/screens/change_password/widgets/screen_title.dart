import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helppay_web_app/styles.dart';

class ScreenTitle extends StatelessWidget
    implements ObstructingPreferredSizeWidget {
  final String text;
  final double height;
  final Widget actionWidget;

  const ScreenTitle(
      {required this.text, this.height = 64, required this.actionWidget});

  @override
  Widget build(BuildContext context) => PreferredSize(
        preferredSize: Size.fromHeight(height),
        child: SizedBox(
          height: height,
          child: CupertinoNavigationBar(
            backgroundColor: const Color(0xffFCFCFC),
            padding: EdgeInsetsDirectional.zero,
            border: const Border(),
            leading: IconButton(
              onPressed: () => AutoRouter.of(context).pop(),
              icon: SvgPicture.asset(
                'assets/icon/arrow_back.svg',
                colorFilter: const ColorFilter.mode(AppStyles.mainColorDark, BlendMode.srcIn),
              ),
            ),
            middle: Text(
              text,
              style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: AppStyles.mainColorDark),
            ),
            trailing: actionWidget,
          ),
        ),
      );

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  bool shouldFullyObstruct(BuildContext context) => true;
}
