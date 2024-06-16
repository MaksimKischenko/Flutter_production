import 'package:flutter/material.dart';
import 'package:kpm_fl/styles.dart';

class LoadingIndicator extends StatelessWidget {
  final Color color;
  
  const LoadingIndicator({
    Key? key,
    this.color = AppStyles.mainColor
  }) : super(key: key);

  // @override
  // Widget build(BuildContext context) {
  //   final isIOS = defaultTargetPlatform == TargetPlatform.iOS;
  //   return isIOS
  //       ? const CupertinoActivityIndicator()
  //       : CircularProgressIndicator(
  //         valueColor: AlwaysStoppedAnimation<Color>(color),
  //       );
  // }
  
  // @override
  // Widget build(BuildContext context) => const CupertinoActivityIndicator();

  @override
  Widget build(BuildContext context) => CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation<Color>(color),
  );
}