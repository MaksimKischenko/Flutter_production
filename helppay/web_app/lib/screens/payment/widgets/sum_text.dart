import 'package:flutter/material.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/styles.dart';

class SumText extends StatelessWidget {
  final double sum;

  const SumText(this.sum);

  @override
  Widget build(BuildContext context) => RichText(
        text: TextSpan(
          text: context.t.mobileScreens.payment.sumText,
          style: const TextStyle(
              fontSize: 20,
              color: AppStyles.mainColorDark,
              letterSpacing: -1.4),
          children: [
            TextSpan(
              text: '$sum BYN',
              style: const TextStyle(
                fontSize: 22,
                color: AppStyles.mainColorDark,
                letterSpacing: -1.4,
              ),
            )
          ],
        ),
      );
}
