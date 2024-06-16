import 'package:flutter/cupertino.dart';
import 'package:isc_web_app/styles.dart';

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
      child: CupertinoNavigationBar(
        backgroundColor: const Color(0xffFCFCFC),
        padding: EdgeInsetsDirectional.zero,
        border: const Border(),
      //   leading: IconButton(
      //   onPressed: () => Navigator.pop,
      //   icon: SvgPicture.asset(
      //     'assets/icon/arrow_back.svg',
      //     color: AppStyles.mainColorDark
      //   ),
      // ),
        middle: Text(
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