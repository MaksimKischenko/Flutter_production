import 'package:flutter/material.dart';
import 'package:helppay_web_app/styles.dart';
import 'package:helppay_web_app/widgets/widgets.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.max,
    // mainAxisSize: MainAxisSize.min,
    children: [
      const MultiplatformIndicator(),
      const SizedBox(height: 16),
      Text(
        'Пожалуйста, подождите',
        style: TextStyle(
          color: AppStyles.mainColorDark.withOpacity(0.5),
          fontSize: 16,
          // fontWeight: FontWeight.w600
        ),
      )
    ],
  );
}