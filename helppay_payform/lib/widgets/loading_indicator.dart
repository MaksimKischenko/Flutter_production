import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helppay_payform_app/styles.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

class LoadingIndicator extends StatelessWidget {
  final Color color;

  const LoadingIndicator({Key? key, this.color = AppStyles.mainColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) =>
      ResponsiveBuilder(builder: (context, sizingInformation) {
        final isDevise =
            sizingInformation.isMobile || sizingInformation.isTablet;
        return SizedBox(
          width: isDevise ? 45 : 90,
          height: isDevise ? 45 : 90,
          child: CircularProgressIndicator(
            color: AppStyles.mainColor,
            valueColor: AlwaysStoppedAnimation(color),
          ),
        );
        // return SimpleCircularProgressBar(
        //   backStrokeWidth: 4,
        //   progressStrokeWidth: 8,
        //   animationDuration: 10,
        //   startAngle: 0,
        //   size: isDevise ? 45 : 90,
        //   // mergeMode: true,
        //   progressColors: const [AppStyles.mainColor],
        //   backColor: AppStyles.mainColor,
        // );
      });
}
