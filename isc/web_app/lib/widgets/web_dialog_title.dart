import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:isc_web_app/styles.dart';

class WebDialogTitle extends StatelessWidget
    implements ObstructingPreferredSizeWidget {
  final String text;
  final double height;
  final Widget? actionWidget;

  const WebDialogTitle({
    required this.text,
    this.height = 64,
    this.actionWidget,
  });

  @override
  Widget build(BuildContext context) => PreferredSize(
        preferredSize: Size.fromHeight(height),
        child: SizedBox(
          height: height,
          child: CupertinoNavigationBar(
            leading: Align(
              alignment: Alignment.centerLeft,
              child: FittedBox(
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: AppStyles.mainColorDark,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            // backgroundColor: const Color(0xffFCFCFC),
            padding: const EdgeInsetsDirectional.only(
              start: 40,
              end: 40,
            ),
            border: Border(
              bottom: BorderSide(
                color: AppStyles.mainColorDark.withOpacity(0.1),
              ),
            ),
            trailing: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                actionWidget ?? const SizedBox.shrink(),
                 IconButton(
                  splashRadius: 1,
                  onPressed:() => AutoRouter.of(context).pop(),
                  iconSize: 24,
                  icon: const Icon(CupertinoIcons.clear_fill),
                  color: AppStyles.mainColor,
                ),
              ],
            ),
          ),
        ),
      );

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  bool shouldFullyObstruct(BuildContext context) => true;
}
