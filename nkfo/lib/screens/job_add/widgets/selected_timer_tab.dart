import 'package:flutter/material.dart';
import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/models/models.dart';
import 'package:web_cabinet_nkfo/screens/job_add/widgets/widgets.dart';

class SelectedTimerTab extends StatelessWidget {
  final PeriodStatus status;
  final JobInsertRequest job;

  const SelectedTimerTab({
    required this.status,
    required this.job,
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    if (status == PeriodStatus.isMinute) {
      return OnMinuteTab(
        request: job
      );
    } else if (status == PeriodStatus.isDay) {
      return OnDayTab(
        request: job
      );
    } else if (status == PeriodStatus.isWeek) {
      return OnWeekTab(
        request: job
      );
    } else if (status == PeriodStatus.isMonth) {
      return OMonthTab(
        request: job
      );
    }
    return Container();
  }
}


  // Widget _selectedTimerTab(PeriodStatus status) {
  //   if (status == PeriodStatus.isMinute) {
  //     return OnMinuteTab(
  //       request: _job
  //     );
  //   } else if (status == PeriodStatus.isDay) {
  //     return OnDayTab(
  //       request: _job
  //     );
  //   } else if (status == PeriodStatus.isWeek) {
  //     return OnWeekTab(
  //       request: _job
  //     );
  //   } else if (status == PeriodStatus.isMonth) {
  //     return OMonthTab(
  //       request: _job
  //     );
  //   }
  //   return Container();
  // }
  