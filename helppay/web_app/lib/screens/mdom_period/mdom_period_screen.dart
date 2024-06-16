import 'package:auto_route/auto_route.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/widgets/date_picker_widget.dart';
import 'package:helppay_web_app/widgets/web_dialog_window.dart';
import 'package:intl/intl.dart';

import 'widgets/widgets.dart';

class MdomPeriodScreen extends StatefulWidget {
  final MdomPeriodWrapper periodWrapper;

  const MdomPeriodScreen({Key? key, required this.periodWrapper})
      : super(key: key);

  @override
  _MdomPeriodScreenState createState() => _MdomPeriodScreenState();
}

class _MdomPeriodScreenState extends State<MdomPeriodScreen> {
  late MdomPeriod _selectedPeriod;
  DateTime? dateFrom;
  DateTime? dateTo;
  bool get buttonActive => _selectedPeriod != MdomPeriod.notSet;

  final List<MdomPeriod> _periods = List.from(MdomPeriod.values)
    ..remove(MdomPeriod.notSet);

  @override
  void initState() {
    super.initState();
    dateFrom = widget.periodWrapper.from;
    dateTo = widget.periodWrapper.to;
    _selectedPeriod = widget.periodWrapper.period;
  }

  @override
  Widget build(BuildContext context) => WebDialogWindow(
        buttonTitle: context.t.mobileScreens.mdomPediod.doneButton,
        useSpacer: true,
        title: context.t.mobileScreens.mdomPediod.title,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Выберите период за который будут отображаться начисления',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  height: 20 / 16,
                  color: Color(0xff7E7E8C),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _periods.length,
                  itemBuilder: (context, index) {
                    final period = _periods[index];
                    return PeriodItem(
                      period: period,
                      selected: _selectedPeriod == period,
                      onTap: _onPeriodTap,
                    );
                  },
                ),
              ),
            ),
            if (_selectedPeriod == MdomPeriod.custom) ...[
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  children: [
                    WebDatePicker(
                      labelText: 'с',
                      onChange: (value) => dateFrom = value,
                      needValidation: false,
                    ),
                    const SizedBox(width: 4),
                    const Text('-'),
                    const SizedBox(width: 4),
                    WebDatePicker(
                      labelText: 'по',
                      onChange: (value) => dateTo = value,
                      needValidation: false,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
        buttonActive: buttonActive,
        onPressed: _onDoneTap,
      );

  // ignore: avoid_void_async
  void _onPeriodTap(MdomPeriod period) async {
    setState(() {
      _selectedPeriod = period;
    });
  }

  void _onDoneTap() {
    final date = DateTime.now();
    late MdomPeriodWrapper temp;
    switch (_selectedPeriod) {
      case MdomPeriod.month:
        temp = MdomPeriodWrapper.fromMonth(month: date.month, year: date.year);
        break;
      case MdomPeriod.quarter:
        temp = MdomPeriodWrapper.fromQuarter(
            quarter: DateFormat('Q').format(date).toInt(), year: date.year);
        break;
      case MdomPeriod.year:
        temp = MdomPeriodWrapper.fromYear(date.year);
        break;
      case MdomPeriod.custom:
        temp = MdomPeriodWrapper.custom(from: dateFrom!, to: dateTo!);
        break;
      default:
    }
    AutoRouter.of(context).pop<MdomPeriodWrapper>(temp);
  }
}
