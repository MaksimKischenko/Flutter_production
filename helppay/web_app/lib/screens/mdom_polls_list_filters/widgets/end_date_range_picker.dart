import 'package:flutter/material.dart';

import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/navigation.dart';
import 'package:helppay_web_app/styles.dart';

class EndDateRangePicker extends StatelessWidget {
  final TextEditingController controller;
  final DateTime from;
  final DateTime to;
  final Function(DateTime from, DateTime to) onChanged;

  const EndDateRangePicker({
    Key? key,
    required this.controller,
    required this.from,
    required this.to,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => TextFormField(
    onTap: () => _onTap(context),
    controller: controller,
    autocorrect: false,
    readOnly: true,
    decoration: InputDecoration(
      labelText: context.t.mobileScreens.mdomPollsListFilters.endDateRangePicker.title,
      // hintText: hint,
      counterText: '',
      alignLabelWithHint: true,
      labelStyle: AppStyles.inputLabelUnderlineStyle,
      focusedBorder: AppStyles.inputBorderUnderline,
      enabledBorder: AppStyles.inputBorderUnderline,
      border: AppStyles.inputBorderUnderline,
      isDense: true,
      suffixIcon: Icon(
        Icons.date_range_rounded,
        color: AppStyles.mainColorDark.withOpacity(0.6),
      )
    ),
    // onChanged: (value) {
    //   try {
    //     final date = DateFormat('dd/MM/yyyy').parse(value);
    //     return onChanged?.call(date);
    //   } catch (e) {}
    // },
  );

  // ignore: avoid_void_async
  void _onTap(BuildContext context) async {
    final value = await Navigation.toMdomPeriodCustom(
      context: context,
      title: t.mobileScreens.mdomPollsListFilters.endDateRangePicker.calendarModalTitle,
      dateFrom: from,
      dateTo: to,
    );

    if (value != null) {
      onChanged(value.from!, value.to!);
    }
  }
}