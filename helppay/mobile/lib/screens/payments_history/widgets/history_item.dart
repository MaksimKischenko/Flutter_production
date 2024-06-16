import 'package:flutter/material.dart';
import 'package:helppay/styles.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class HistoryItem extends StatelessWidget {
  final Payment item;

  late String name;
  late String date;
  late String sum;

  HistoryItem({
    required this.item
  }) {
    name = item.payName;
    final initialDate = DateFormat('dd/MM/yyyy HH:mm:ss').parse(item.dateTime);
    date = DateFormat('dd.MM.yyyy HH:mm').format(initialDate);
    sum = '-${item.amount.evalue.format()} BYN';
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon( 
          Icons.check_circle,
          color: AppStyles.secondaryColor,
          size: 16,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: AppStyles.mainColorDark,
                  // letterSpacing: -0.5
                  // fontSize: 14
                ),
              ),
              const SizedBox(height: 6),
              Text(
                date,
                style: TextStyle(
                  fontSize: 12,
                  color: AppStyles.mainColorDark.withOpacity(0.6),
                ),
              )
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(
          sum,
          style: const TextStyle(
            color: Color(0xffFF3B30),
            fontSize: 16
          ),
        )
      ],
    ),
  );
}