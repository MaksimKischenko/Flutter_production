import 'package:flutter/material.dart';

class AppBarProgressIndicator extends SizedBox implements PreferredSizeWidget {
  static const double _appBarProgressIndicatorHeight = 4;

  const AppBarProgressIndicator({
    Key? key
  }) : super(
    key: key,
    height: _appBarProgressIndicatorHeight,
    child: const LinearProgressIndicator()
  );

  @override
  Size get preferredSize => const Size(
    double.infinity,
    _appBarProgressIndicatorHeight
  );
}