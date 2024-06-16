import 'package:flutter/material.dart';
import 'package:payment_tracking_module/presentation/styles.dart';


class MainAppBar extends StatelessWidget implements PreferredSizeWidget  {

 final String appBartitle;

 const MainAppBar({
    required this.appBartitle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(appBartitle, style: AppStyles.headerStyle),
        ],
      ),
    );

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
