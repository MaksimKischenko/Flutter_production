import 'package:bpc/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final Color color;
  
  const LoadingIndicator({
    Key? key,
    this.color = AppStyles.mainColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isIOS = defaultTargetPlatform == TargetPlatform.iOS;
    return isIOS
        ? const CupertinoActivityIndicator()
        : CircularProgressIndicator(
          valueColor:
          AlwaysStoppedAnimation<Color>(color),
        );
  }
}