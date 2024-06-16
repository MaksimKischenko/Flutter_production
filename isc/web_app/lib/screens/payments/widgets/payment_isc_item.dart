import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:isc_web_app/data/data.dart';
import 'package:isc_web_app/styles.dart';

class PaymentISCItem extends StatelessWidget {
  final PaymentISC item;
  final Function(PaymentISC item) onInfoClick;

  const PaymentISCItem({
    required this.item,
    required this.onInfoClick
  });

  @override
  Widget build(BuildContext context) {
    final paymentDate = DateFormat(item.paymentDate.length > 10 ? 'dd.MM.yyyy HH:mm:ss' : 'dd.MM.yyyy').parse(item.paymentDate);
    return ListTile(
      onTap: () => onInfoClick(item),
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      title: Container(
        padding: const EdgeInsets.only(left: 8),
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(width: 4, color: item.status.paymentStatusColor)
            )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.accNum ?? '',
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