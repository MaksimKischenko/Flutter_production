import 'package:bpc/data/data.dart';
import 'package:bpc/styles.dart';
import 'package:flutter/material.dart';

class ServiceListItem extends StatelessWidget {
  final Service service;

  const ServiceListItem(this.service);
  
  @override
  Widget build(BuildContext context) => ListTile(
    title: Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Text(
        service.name,
        style: TextStyle(
          color: AppStyles.mainColor.withOpacity(0.8),
          fontSize: 16,
          fontWeight: FontWeight.bold
        ),
      ),
    ),
    subtitle: Column(
      children: [
        Row(
          // mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  'Код',
                  style: TextStyle(
                    color: AppStyles.mainTextColor.withOpacity(0.7),
                    fontSize: 14
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${service.code}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppStyles.mainTextColor,
                    fontSize: 16
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  'Макс. сумма',
                  style: TextStyle(
                    color: AppStyles.mainTextColor.withOpacity(0.7),
                    fontSize: 14
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  (service.claimSumMax ?? 0.0) == 0.0
                    ? '-'
                    : '${service.claimSumMax}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppStyles.mainTextColor,
                    fontSize: 16
                  ),
                ),
              ],
            ),
          ],
        ),
        if ((service.needGenerateAccNum ?? 0) == 1)
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Icon(
                Icons.info_outline,
                color: AppStyles.mainColor,
                size: 18,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Номер лицевого счета присваивается автоматически',
                  style: TextStyle(
                    color: AppStyles.mainTextColor.withOpacity(0.7),
                    fontSize: 14
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    dense: true
  );
}