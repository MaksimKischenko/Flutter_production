import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payment_tracking_module/presentation/styles.dart';

class DialogTitle extends StatelessWidget
    implements ObstructingPreferredSizeWidget {
  final String text;
  final double height;

  const DialogTitle({
    required this.text,
    this.height = 64,
  });

  @override
  Widget build(BuildContext context) => PreferredSize(
        preferredSize: Size.fromHeight(height),
        child: SizedBox(
          height: height,
          child: CupertinoNavigationBar(
            automaticallyImplyLeading: false,
            trailing: Ink(
              child: InkWell(
                onTap: () {
                  if(AutoRouter.of(context).canPop()) {
                    AutoRouter.of(context).pop();
                  }                 
                },
                child: const Icon(Icons.close, color: AppStyles.mainTextColor, size: 24)),
            ),
            middle: Align(
              alignment: Alignment.center,
              child: FittedBox(
                child: Text(
                  text,
                  style: AppStyles.headerTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            padding: const EdgeInsetsDirectional.only(
              start: 40,
              end: 40,
            ),
            border: Border(
              bottom: BorderSide(
                color: AppStyles.mainTextColor.withOpacity(0.1),
              ),
            ),
          ),
        ),
      );

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  bool shouldFullyObstruct(BuildContext context) => true;
}
