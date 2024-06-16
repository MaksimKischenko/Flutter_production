// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/presentation/styles.dart';

class PaymentsLoadLimitPicker extends StatelessWidget {
  final List<PaymentLoadedLimit> items;
  final PaymentLoadedLimit? selected;
  final Function(PaymentLoadedLimit item) onTap;

  const PaymentsLoadLimitPicker({
    Key? key,
    required this.items,
    required this.onTap,
    this.selected,
  }) : super(key: key);
  

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Кол-во загружаемых записей:',
        style: AppStyles.infoTextStyle
      ),
      const SizedBox(height: 10),
      Expanded(
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: items.length,
          separatorBuilder: (context, index) => const SizedBox(width: 4),
          itemBuilder: (context, index) => _limitItem(items[index], index),
        ),
      )
    ],
  );

  Widget _limitItem(PaymentLoadedLimit item, int index) {
    final selectedItem = selected == items[index];
    return Ink(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: selectedItem ? null : () => onTap(item),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: AppStyles.colorGold2),
            color: selectedItem
                ? AppStyles.colorGold2
                : Colors.transparent,
            borderRadius: BorderRadius.circular(16)
          ),
          child: Center(
            child: Text('${item.count}', 
              style: selectedItem? AppStyles.tableHeaderTextStyle : 
              AppStyles.tableHeaderTextStyle.copyWith(color: AppStyles.colorGold2)
            )),
        ),
      ),
    );
  }
}
