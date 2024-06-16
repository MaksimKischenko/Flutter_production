import 'package:flutter/material.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/styles.dart';

import 'widgets.dart';

class PaymentsList extends StatelessWidget {
  final List<Payment> list;

  const PaymentsList({
    required this.list
  });

  @override
  Widget build(BuildContext context) => ListView.separated(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    padding: const EdgeInsets.only(top: 16, bottom: 64),
    itemBuilder: (context, index) => HistoryItem(item: list[index]),
    separatorBuilder: (context, _) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Divider(
        color: AppStyles.mainColorDark.withOpacity(0.1),
        height: 1
      ),
    ),
    itemCount: list.length
  );
}