import 'package:flutter/material.dart';
import 'package:payment_tracking_module/presentation/styles.dart';


class FilterInfoCard extends StatelessWidget {
  final String title;
  final String? subtitle;

  const FilterInfoCard({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) =>  (subtitle == null || subtitle == '') ? const SizedBox.shrink() : Padding(
    padding: const EdgeInsets.all(2),
    child: Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 10, 
            width: 2,
            color: AppStyles.colorGold
          ),
          const SizedBox(width: 4),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppStyles.infoTextStyle.copyWith(fontSize: 10)
              ),
              const SizedBox(height: 4),
              Text(
                subtitle ?? '',
                style: AppStyles.infoTextStyle.copyWith(
                  fontSize: 10, color: AppStyles.mainTextColor.withOpacity(0.5)
                )
              )
            ],
          ),
        ],
      ),
    ),
  );
}