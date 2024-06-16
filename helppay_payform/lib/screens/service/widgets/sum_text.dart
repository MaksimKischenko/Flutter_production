import 'package:flutter/material.dart';
import 'package:helppay_payform_app/config.dart';

import 'service_result_item.dart';

class SumText extends StatelessWidget {
  final double sum;
  final int currency;

  const SumText({
    required this.sum,
    required this.currency
  });

  // @override
  // Widget build(BuildContext context) => RichText(
  //   text: TextSpan(
  //     text: 'К оплате: ',
  //     style: const TextStyle(
  //       fontSize: 20,
  //       color: AppStyles.mainTextColor,
  //       letterSpacing: -1.4
  //     ),
  //     children: [
  //       TextSpan(
  //         text: '$sum ${currencyName(currency)}',
  //         style: const TextStyle(
  //           fontSize: 22,
  //           color: AppStyles.mainTextColor,
  //           letterSpacing: -1.4
  //         ),
  //       )
  //     ]
  //   ),
  // );

  @override
  Widget build(BuildContext context) => ServiceResultItem(
    title: 'К оплате',
    subtitle: '$sum ${currencyName(currency)}',
  );

  String currencyName(int code) => AppConfig.mapCurrencyToName[code] ?? '';
}