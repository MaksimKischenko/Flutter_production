import 'package:bpc/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScreenTitle extends StatelessWidget implements ObstructingPreferredSizeWidget {
  final String text;
  final double height;
  final Widget actionWidget;

  const ScreenTitle({
    required this.text,
    this.height = 64,
    required this.actionWidget
  });

  @override
  Widget build(BuildContext context) => PreferredSize(
    preferredSize: Size.fromHeight(height),
    child: SizedBox(
      height: height,
      child: CupertinoNavigationBar(
        backgroundColor: AppStyles.scaffoldColor,
        padding: EdgeInsetsDirectional.zero,
        border: const Border(),
        leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(
          Icons.arrow_back,
          color: AppStyles.mainColor,
        )
      ),
        middle: Text(
          text,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: AppStyles.mainTextColor
          ),
        ),
        trailing: actionWidget
      ),
    )
  );

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  bool shouldFullyObstruct(BuildContext context) => true;
}