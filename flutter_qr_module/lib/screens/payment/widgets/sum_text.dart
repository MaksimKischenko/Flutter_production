import 'package:fl_qr_module/styles.dart';
import 'package:flutter/material.dart';

class SumText extends StatelessWidget {
  final double sum;

  const SumText(this.sum);

  @override
  Widget build(BuildContext context) => RichText(
        text: TextSpan(
            text: 'К оплате: ',
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
                    letterSpacing: -1.4),
              )
            ]),
      );
}
