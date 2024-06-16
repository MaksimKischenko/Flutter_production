import 'package:flutter/material.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:web_cabinet_nkfo/styles.dart';

// class LoadingIndicator extends StatelessWidget {
//   final Color color;
  
//   const LoadingIndicator({
//     Key? key,
//     this.color = AppStyles.mainColor
//   }) : super(key: key);

//   // @override
//   // Widget build(BuildContext context) {
//   //   final isIOS = defaultTargetPlatform == TargetPlatform.iOS;
//   //   return isIOS
//   //       ? const CupertinoActivityIndicator()
//   //       : CircularProgressIndicator(
//   //         valueColor: AlwaysStoppedAnimation<Color>(color),
//   //       );
//   // }
  
//   // @override
//   // Widget build(BuildContext context) => const CupertinoActivityIndicator();

//   @override
//   Widget build(BuildContext context) => CircularProgressIndicator(
//     valueColor: AlwaysStoppedAnimation<Color>(color),
//   );
// }

class LoadingIndicator extends StatelessWidget {
  final Color color;
  final double indicatorsSize;
  
  const LoadingIndicator({
    Key? key,
    this.color = AppStyles.mainColor,
    this.indicatorsSize = 38
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SimpleCircularProgressBar(
      backStrokeWidth: 3,
      progressStrokeWidth: 6,
      animationDuration: 2,
      startAngle: 0,
      size: indicatorsSize,
      mergeMode: true,
      progressColors:  const [AppStyles.mainColor],
      backColor: AppStyles.mainColor,
    );
}