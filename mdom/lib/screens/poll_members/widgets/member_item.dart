import 'package:bpc/data/data.dart';
import 'package:bpc/styles.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';

class MemberItem extends StatelessWidget {
  final Member item;

  const MemberItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              item.clientAccount,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                letterSpacing: .1
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            item.confirmed == 1
                ? 'Подтвержден'
                : 'Не подтвержден',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              letterSpacing: .1,
              color: item.confirmed == 1
                  ? const Color(0xff18AF5F)
                  : null,
            ),
          )
        ],
      ),
      if (item.fio.isNotNullOrEmpty)
      Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text(
          item.fio!
        ),
      ),
      if (item.address.isNotNullOrEmpty)
      Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text(
          item.address!,
          style: TextStyle(
            fontSize: 13,
            color: AppStyles.mainTextColor.withOpacity(.5),
          ),
        ),
      ),
      if (item.phone.toString().isNotNullOrEmpty || item.email.isNotNullOrEmpty)
      Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Row(
          children: [
            if (item.phone != null && item.phone.toString().isNotEmpty)
            Text(
              item.phone.toString(),
              style: TextStyle(
                fontSize: 13,
                color: AppStyles.mainTextColor.withOpacity(.5),
              ),
            ) else const SizedBox(width:0),
            if (item.phone != null && item.phone.toString().isNotEmpty && item.email.isNotNullOrEmpty)
            const SizedBox(width: 12),
            if (item.email.isNotNullOrEmpty)
            Text(
              item.email ?? '',
              style: TextStyle(
                fontSize: 13,
                color: AppStyles.mainTextColor.withOpacity(.5),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}