import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:helppay/navigation.dart';
import 'package:helppay/styles.dart';
import 'package:helppay/widgets/widgets.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:intl/intl.dart';

import 'widgets/widgets.dart';

class MdomPeriodScreen extends StatefulWidget {
  final MdomPeriodWrapper periodWrapper;

  const MdomPeriodScreen({
    Key? key,
    required this.periodWrapper
  }): super(key: key);

  @override
  _MdomPeriodScreenState createState() => _MdomPeriodScreenState();
}

class _MdomPeriodScreenState extends State<MdomPeriodScreen> {
  late MdomPeriod _selectedPeriod;

  bool get buttonActive => _selectedPeriod != MdomPeriod.notSet;

  final List<MdomPeriod> _periods = List.from(MdomPeriod.values)
      ..remove(MdomPeriod.notSet);
  
  @override
  void initState() {
    super.initState();

    _selectedPeriod = widget.periodWrapper.period;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: DialogTitle(
      text: context.t.mobileScreens.mdomPediod.title,
    ),
    body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 16),
                separatorBuilder: (context, _) => Divider(
                  color: AppStyles.mainColorDark.withOpacity(0.1),
                ),
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
                }
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
            child: SafeArea(
              child: DoneButton(
                active: buttonActive,
                onPressed: _onDoneTap,
              ),
            ),
          )
        ],
      ),
    ),
  );

  // ignore: avoid_void_async
  void _onPeriodTap(MdomPeriod period) async {
    if (period == MdomPeriod.custom) {
      DateTime? dateFrom;
      DateTime? dateTo;
      if (widget.periodWrapper.period == MdomPeriod.custom) {
        dateFrom = widget.periodWrapper.from;
        dateTo = widget.periodWrapper.to;
      }
      final value = await Navigation.toMdomPeriodCustom(
        context: context,
        dateFrom: dateFrom,
        dateTo: dateTo,
      );
      if (value != null) {
        Navigator.of(context).pop<MdomPeriodWrapper>(value);
      }
    } else {
      setState(() {
        _selectedPeriod = period;
      });
    }
  }

  void _onDoneTap() {
    final date = DateTime.now();
    late MdomPeriodWrapper temp;
    switch (_selectedPeriod) {
      case MdomPeriod.month:
        temp = MdomPeriodWrapper.fromMonth(
          month: date.month,
          year: date.year
        );
        break;
      case MdomPeriod.quarter:
        temp = MdomPeriodWrapper.fromQuarter(
          quarter: DateFormat('Q').format(date).toInt(),
          year: date.year
        );
        break;
      case MdomPeriod.year:
        temp = MdomPeriodWrapper.fromYear(date.year);
        break;
      case MdomPeriod.custom:
        
        break;
      default:
        
    }
    Navigator.of(context).pop<MdomPeriodWrapper>(temp);
  }
}