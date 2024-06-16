import 'package:flutter/material.dart';
import 'package:helppay_core/helppay_core.dart';

import 'widgets.dart';

class PeriodPicker extends StatefulWidget {
  final TextEditingController fromController;
  final TextEditingController toController;

  const PeriodPicker({
    required this.fromController,
    required this.toController,
  });

  @override
  _PeriodPickerState createState() => _PeriodPickerState();
}

class _PeriodPickerState extends State<PeriodPicker> {
  DateTime get dateFrom => widget.fromController.text.toDateFormatted();
  DateTime get dateTo => widget.toController.text.toDateFormatted();

  @override
  Widget build(BuildContext context) => Row(
        children: [
          DateField(
            prefix: context
                .t.mobileScreens.paymentsHistoryFilters.dateFromField.tilte,
            controller: widget.fromController,
            lastDate: dateTo,
            validator: (value) {
              if (dateFrom.isAfter(dateTo)) {
                return context.t.mobileScreens.paymentsHistoryFilters
                    .dateFromField.errors.dateIsAfter;
              }
              return null;
            },
            onPicked: () {
              setState(() {});
            },
          ),
          const SizedBox(width: 24),
          DateField(
            prefix: context
                .t.mobileScreens.paymentsHistoryFilters.dateToField.tilte,
            controller: widget.toController,
            firstDate: dateFrom,
            validator: (value) {
              if (dateTo.isBefore(dateFrom)) {
                return context.t.mobileScreens.paymentsHistoryFilters
                    .dateToField.errors.dateIsBefore;
              }
              return null;
            },
            onPicked: () {
              setState(() {});
            },
          ),
        ],
      );
}
