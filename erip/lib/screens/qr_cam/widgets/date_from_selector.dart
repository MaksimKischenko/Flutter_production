import 'package:bpc_nkfo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateFromSelector extends StatelessWidget {
  final DateTime value;
  final Function(DateTime value)? onSelect;

  DateFromSelector({
    required this.value,
    required this.onSelect
  });

  final format = DateFormat('dd.MM.yyyy');

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () => _onPressed(context),
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: const Color(0xffF0F0F0).withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 4),
          Text(
            'с ${format.format(value)}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              letterSpacing: -0.5
            ),
          ),
          const SizedBox(width: 4),
          const Icon(
            Icons.expand_more_rounded,
            size: 22,
          )
        ],
      ),
    ),
  );

  // ignore: avoid_void_async
  void _onPressed(BuildContext context) async {
    final from = await Multiplatform.showdatePicker(
      context: context,
      initialDate: value,
      firstDate: DateTime.now().subtract(const Duration(days: 20000)),
      lastDate: DateTime.now().add(const Duration(days: 20000))
    );
    if (from != null) onSelect?.call(from);
  }
}