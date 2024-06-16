import 'package:flutter/material.dart';
import 'package:isc_web_app/styles.dart';
import 'package:isc_web_app/utils/utils.dart';


class RowCounter extends StatelessWidget {
  final int value;

  const RowCounter(this.value);

  @override
  Widget build(BuildContext context) => Container(
    width: double.maxFinite,
    color: Colors.grey.shade300,
    padding: const EdgeInsets.symmetric(
        horizontal: 16, vertical: 8),
    child: Text(
      'Всего $value ${value.plural("запись", "записи", "записей")}.',
      style: AppStyles.tableHeaderTextStyle
    )
  );
}