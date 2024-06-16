import 'package:bpc/data/data.dart';
import 'package:bpc/models/models.dart';
import 'package:bpc/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaymentItem extends StatelessWidget {
  final Payment item;
  final Function(Payment item) onInfoClick;

  const PaymentItem({
    required this.item,
    required this.onInfoClick
  });

  @override
  Widget build(BuildContext context) {
    //TODO: remove this hack
    final paymentDate = DateFormat(item.paymentDate.length > 10 ? 'dd.MM.yyyy HH:mm:ss' : 'dd.MM.yyyy').parse(item.paymentDate);
    return ListTile(
      onTap: () => onInfoClick(item),
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      title: Container(
        padding: const EdgeInsets.only(left: 8),
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(width: 4, color: item.status.color)
            )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                // '${item.id}',
                item.accNum,
                style: const TextStyle(
                  color: AppStyles.mainColor,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                // "Дата платежа: ${item.paymentDate}",
                "Дата платежа: ${DateFormat('dd.MM.yyyy HH:mm').format(paymentDate)}",
                style: TextStyle(
                  color: AppStyles.mainTextColor.withOpacity(0.7),
                  fontSize: 12
                ),
              )
            ],
          ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      // 'СЧЕТ ПЛАТ-КА',
                      'КОД ПЛАТЕЖА',
                      style: TextStyle(
                        color: AppStyles.mainTextColor.withOpacity(0.7),
                        fontSize: 11
                      ),
                    ),
                    Text(
                      // item.accNum,
                      '${item.id}',
                      style: const TextStyle(
                        color: AppStyles.mainTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12
                      ),
                    )
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'СУММА',
                      style: TextStyle(
                        color: AppStyles.mainTextColor.withOpacity(0.7),
                        fontSize: 11
                      ),
                    ),
                    Text(
                      '${item.paymentSum}',
                      style: const TextStyle(
                        color: AppStyles.mainTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12
                      ),
                    )
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'ОПИСАНИЕ',
                      style: TextStyle(
                        color: AppStyles.mainTextColor.withOpacity(0.7),
                        fontSize: 11
                      ),
                    ),
                    Text(
                      item.productCharacter ?? '',
                      maxLines: 1,
                      style: const TextStyle(
                        color: AppStyles.mainTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}