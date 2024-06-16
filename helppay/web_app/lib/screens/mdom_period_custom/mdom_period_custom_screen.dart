import 'package:auto_route/auto_route.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/styles.dart';
import 'package:helppay_web_app/widgets/widgets.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'widgets/widgets.dart';

class MdomPeriodCustomScreen extends StatefulWidget {
  final String? title;
  final DateTime? initialDateFrom;
  final DateTime? initialDateTo;

  const MdomPeriodCustomScreen({
    Key? key,
    this.title,
    required this.initialDateFrom,
    required this.initialDateTo,
  }) : super(key: key);

  @override
  _MdomPeriodCustomScreenState createState() => _MdomPeriodCustomScreenState();
}

class _MdomPeriodCustomScreenState extends State<MdomPeriodCustomScreen> {
  final _dateFromController = TextEditingController();
  final _dateToController = TextEditingController();

  DateTime? _dateFrom;
  DateTime? _dateTo;

  final _now = DateTime.now();

  bool get buttonActive => _dateFrom != null && _dateTo != null;

  bool isManual = false;

  final _dateFormatter = DateFormat('dd/MM/yyyy');
  final _dateMask =
      RegExp(r'^(0?[1-9]|[12][0-9]|3[01])\/(0?[1-9]|1[012])\/\d{4}$');

  @override
  void initState() {
    super.initState();

    _dateFromController.addListener(() {
      final text = _dateFromController.text;
      if (text.length == 10) {
        final date = _checkDate(text);

        if (date != null) {
          if (_dateTo?.isBefore(date) ?? false) {
            _dateTo = null;
            _dateToController.clear();
          }
          _dateFrom = date;
          setState(() {});
        } else {
          _dateFromController.clear();
        }
      } else if (text.isEmpty) {
        setState(() => _dateFrom = null);
      }
    });

    _dateToController.addListener(() {
      final text = _dateToController.text;
      if (text.length == 10) {
        final date = _checkDate(text);

        if (date != null && (_dateFrom?.isBefore(date) ?? false)) {
          setState(() => _dateTo = date);
        } else {
          _dateToController.clear();
        }
      } else if (text.isEmpty) {
        setState(() => _dateTo = null);
      }
    });

    if (widget.initialDateFrom != null && widget.initialDateTo != null) {
      _dateFrom = widget.initialDateFrom;
      _dateTo = widget.initialDateTo;

      _dateFromController.text = _dateFormatter.format(_dateFrom!);
      _dateToController.text = _dateFormatter.format(_dateTo!);
    }
  }

  @override
  void dispose() {
    _dateFromController.dispose();
    _dateToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
      navigationBar: DialogTitleAction(
        text: widget.title ?? context.t.mobileScreens.mdomPeriodCustom.title,
        action: IconButton(
            icon: Icon(isManual ? Icons.date_range : Icons.text_fields),
            iconSize: 24,
            onPressed: () => setState(() => isManual = !isManual)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          if (isManual)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    DateField(
                        controller: _dateFromController,
                        label: context.t.mobileScreens.mdomPeriodCustom
                            .dateFromField.tilte,
                        hint: context.t.mobileScreens.mdomPeriodCustom
                            .dateFromField.hint,
                        onChanged: (date) => setState(() => _dateFrom = date),
                        validator: (date) {
                          // if (date.isAfter(_dateFormat.parse(_dateToController.text))) {
                          if (_dateFrom!.isAfter(_dateTo!)) {
                            return t.mobileScreens.mdomPeriodCustom
                                .dateFromField.errors.dateIsAfter;
                          }
                          return null;
                        }),
                    const SizedBox(height: 8),
                    DateField(
                        controller: _dateToController,
                        label: context
                            .t.mobileScreens.mdomPeriodCustom.dateToField.tilte,
                        hint: context
                            .t.mobileScreens.mdomPeriodCustom.dateToField.hint,
                        onChanged: (date) => setState(() => _dateTo = date),
                        validator: (date) {
                          // if (date.isBefore(_dateFormat.parse(_dateFromController.text))) {
                          if (_dateTo!.isBefore(_dateFrom!)) {
                            return t.mobileScreens.mdomPeriodCustom.dateToField
                                .errors.dateIsBefore;
                          }
                          return null;
                        }),
                  ],
                ),
              ),
            ),
          if (!isManual)
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    constraints: const BoxConstraints(maxHeight: 430),
                    child: SfDateRangePicker(
                      selectionMode: DateRangePickerSelectionMode.range,
                      minDate: _now.subtract(const Duration(days: 20000)),
                      maxDate: _now.add(const Duration(days: 20000)),
                      view: DateRangePickerView.month,
                      initialDisplayDate: _dateFrom,
                      initialSelectedRange: PickerDateRange(_dateFrom, _dateTo),
                      onSelectionChanged: (args) {
                        if (args.value is PickerDateRange) {
                          final dateFrom = args.value?.startDate as DateTime?;
                          final dateTo = args.value?.endDate as DateTime?;
                          if (dateFrom != null && dateTo != null) {
                            _dateFromController.text =
                                _dateFormatter.format(dateFrom);
                            _dateToController.text =
                                _dateFormatter.format(dateTo);
                          } else {
                            _dateFromController.clear();
                            _dateToController.clear();
                          }
                          setState(() {
                            _dateFrom = dateFrom;
                            _dateTo = dateTo;
                          });
                        }
                      },
                      showNavigationArrow: true,
                      monthCellStyle: const DateRangePickerMonthCellStyle(
                          weekendTextStyle:
                              TextStyle(color: CupertinoColors.systemRed)),
                      startRangeSelectionColor: AppStyles.mainColor,
                      // rangeSelectionColor: AppStyles.mainColor.withOpacity(0.1),
                      endRangeSelectionColor: AppStyles.mainColor,
                      monthViewSettings: const DateRangePickerMonthViewSettings(
                          enableSwipeSelection: false, firstDayOfWeek: 1),
                      navigationDirection:
                          DateRangePickerNavigationDirection.vertical,
                      // enableMultiView: true,
                      viewSpacing: 0,
                    ),
                  ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
            child: SafeArea(
              child: DoneButton(
                active: buttonActive,
                onPressed: _onDoneTap,
                title: context.t.mobileScreens.mdomPeriodCustom.doneButton,
              ),
            ),
          )
        ],
      ));

  DateTime? _checkDate(String text) {
    try {
      final date = _dateFormatter.parse(text);
      // regural: check month
      if (!_dateMask.hasMatch(text)) throw Exception();
      // check day
      final originalDay = text.substring(0, 2).toInt();
      final originalMonth = text.substring(3, 5).toInt();

      final finalDay = date.day;
      final finalMonth = date.month;
      if (originalDay != finalDay || originalMonth != finalMonth) {
        throw Exception();
      }

      return date;
    } on Exception catch (_) {
      return null;
    }
  }

  void _onDoneTap() {
    final period = MdomPeriodWrapper.custom(from: _dateFrom!, to: _dateTo!);
    AutoRouter.of(context).pop<MdomPeriodWrapper>(period);
  }
}
