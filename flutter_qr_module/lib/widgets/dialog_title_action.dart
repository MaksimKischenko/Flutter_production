import 'package:fl_qr_module/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DialogTitleAction extends StatelessWidget
    implements ObstructingPreferredSizeWidget {
  final String? text;
  final double height;
  final Widget action;

  const DialogTitleAction({
    this.text,
    this.height = 64,
    required this.action,
  });

  @override
  Widget build(BuildContext context) => PreferredSize(
      preferredSize: Size.fromHeight(height),
      child: SizedBox(
        height: height,
        child: AppBar(
          backgroundColor: const Color(0xffFCFCFC),
          // padding: EdgeInsetsDirectional.zero,
          // border: const Border(),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: SvgPicture.asset(
              'assets/icon/arrow_back.svg',
              colorFilter: const ColorFilter.mode(
                  AppStyles.mainColorDark, BlendMode.srcIn),
            ),
          ),
          title: Text(
            text ?? '',
            style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: AppStyles.mainColorDark),
          ),
          actions: [
            DefaultTextStyle(
              style: const TextStyle(
                  color: AppStyles.mainColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w300),
              child: action,
            )
          ],
        ),
      ));

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  bool shouldFullyObstruct(BuildContext context) => true;
}
