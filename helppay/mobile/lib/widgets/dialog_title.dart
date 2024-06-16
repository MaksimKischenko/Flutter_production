import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helppay/styles.dart';
import 'package:helppay/widgets/widgets.dart';

class DialogTitle extends StatelessWidget implements ObstructingPreferredSizeWidget {
  final String text;
  final double height;

  const DialogTitle({
    required this.text,
    this.height = 64
  });

  @override
  Widget build(BuildContext context) => PreferredSize(
    preferredSize: Size.fromHeight(height),
    child: SizedBox(
      height: height,
      child: AppBar(
        backgroundColor: const Color(0xffFCFCFC),
        automaticallyImplyLeading: false,
        // padding: EdgeInsetsDirectional.zero,
        // border: const Border(),
        leading: ArrowBack(),
        title: Text(
          text,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: AppStyles.mainColorDark
          ),
          // textAlign: TextAlign.center,
        ),
      ),
    ),
  );

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  bool shouldFullyObstruct(BuildContext context) => true;
}