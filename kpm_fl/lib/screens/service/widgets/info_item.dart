import 'package:flutter/material.dart';
import 'package:kpm_fl/data/data.dart';

class InfoItem extends StatelessWidget {
  final ResponseClaimProperty item;

  const InfoItem(this.item);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.name ?? '',
          style: const TextStyle(
            fontWeight: FontWeight.w600
          ),
        ),
        const SizedBox(height: 2),
        Text(item.evalue ?? '')
      ],
    ),
  );
}