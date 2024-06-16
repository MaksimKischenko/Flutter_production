  
import 'package:flutter/material.dart';

import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/models/models.dart';
import 'package:web_cabinet_nkfo/screens/job_edit/widgets/widgets.dart';

class SelectedTimerTab extends StatelessWidget {

  final PeriodStatus status;
  final JobUpdateRequest jobUpdate;
  final TextEditingController everyNminController;
  final TextEditingController everyNweekController;
  final TextEditingController everyNController;
  final DateTime? fromTime;
  final DateTime? toTime;

  const SelectedTimerTab({
    required this.status,
    required this.jobUpdate,
    required this.everyNminController,
    required this.everyNweekController,
    required this.everyNController,
    required this.fromTime,
    required this.toTime,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (status == PeriodStatus.isMinute) {
      return OnMinuteTab(
        request: jobUpdate,
        everyNminController: everyNminController,
        fromTime: fromTime,
        toTime: toTime,
      );
    } else if (status == PeriodStatus.isDay) {
      return OnDayTab(
        request: jobUpdate,
        everyNController: everyNController,
        everyNminController: everyNminController,
        fromTime: fromTime,
        toTime: toTime,
      );
    } else if (status == PeriodStatus.isWeek) {
      if(jobUpdate.someDay?.length !=7) {
        jobUpdate.someDay = '0000000';
      }
      return OnWeekTab(
        request: jobUpdate,
        everyNweekController: everyNweekController,
      );
    } else if (status == PeriodStatus.isMonth) {

      return OMonthTab(
        request: jobUpdate,
        everyNController: everyNController,
        everyNweekController: everyNweekController,
      );
    }
    return Container();
  }
}
 
  
  
  
  
  // Widget _selectedTimerTab(PeriodStatus status) {
  //   if (status == PeriodStatus.isMinute) {
  //     return OnMinuteTab(
  //       request: _jobUpdate,
  //       everyNminController: _everyNminController,
  //       fromTime: _fromTime,
  //       toTime: _toTime,
  //     );
  //   } else if (status == PeriodStatus.isDay) {
  //     return OnDayTab(
  //       request: _jobUpdate,
  //       everyNController: _everyNController,
  //       everyNminController: _everyNminController,
  //       fromTime: _fromTime,
  //       toTime: _toTime,
  //     );
  //   } else if (status == PeriodStatus.isWeek) {
  //     if(_jobUpdate.someDay?.length !=7) {
  //       _jobUpdate.someDay = '0000000';
  //     }
  //     return OnWeekTab(
  //       request: _jobUpdate,
  //       everyNweekController: _everyNweekController,
  //     );
  //   } else if (status == PeriodStatus.isMonth) {

  //     return OMonthTab(
  //       request: _jobUpdate,
  //       everyNController: _everyNController,
  //       everyNweekController: _everyNweekController,
  //     );
  //   }
  //   return Container();
  // }