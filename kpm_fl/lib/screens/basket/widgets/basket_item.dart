import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kpm_fl/data/data.dart';
import 'package:kpm_fl/models/models.dart';
import 'package:kpm_fl/utils/utils.dart';

class BasketItem extends StatefulWidget {
  final BasketItemWrapper item;
  final Function(PayRecordResponse item) onDelete;

  const BasketItem({
    Key? key,
    required this.item,
    required this.onDelete
  }) : super(key: key);

  @override
  State<BasketItem> createState() => _BasketItemState();
}

class _BasketItemState extends State<BasketItem> {
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 8,
                spreadRadius: 0
              )
            ]
          ),
          // elevation: 30,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 23),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _item('№ в ЕРИП', widget.item.payment.code?.toString() ?? ''),
                const SizedBox(height: 4),
                _item('Дата', widget.item.payment.date ?? ''),
                const SizedBox(height: 4),
                _item('Наименование', widget.item.serviceName),
                const SizedBox(height: 4),
                _item(widget.item.accNumName, widget.item.payment.attrRecord?.firstOrNullWhere((e) => e.code == 745)?.value ?? ''),
                const SizedBox(height: 4),
                _item('Сумма', widget.item.payment.summa?.toString() ?? ''),
              ],
            ),
          ),
        ),
        Positioned(
          right: -16,
          top: -28,
          child: IconButton(
            iconSize: 42,
            padding: const EdgeInsets.all(8),
            onPressed: _onDeleleTap,
            icon: Container(
              // padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 8,
                    spreadRadius: 0
                  )
                ]
              ),
              child: const Icon(
                Icons.close,
                // size: 48,
              ),
            ),
            color: CupertinoColors.destructiveRed,
          ),
        )
      ],
    ),
  );

  Widget _item(String title, dynamic subtitle) => Row(
    children: [
      Expanded(
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18
          ),
        ),
      ),
      Expanded(
        child: Text(
          subtitle.toString(),
          textAlign: TextAlign.end,
          style: const TextStyle(
            fontSize: 18
          ),
        ),
      ),
    ],
  );

  void _onDeleleTap() {
    Multiplatform.showDecisionMessage(
      context: context,
      message: '',
      action: () => widget.onDelete(widget.item.payment),
      dialogTitle: 'Уверены, что хотите удалить платеж?',
      buttonTitle: 'Удалить',
      cancelButtonTitle: 'Нет'
    );
  }
}