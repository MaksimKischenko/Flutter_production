import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:web_cabinet_nkfo/models/models.dart';

part 'get_jobs_response.g.dart';

@JsonSerializable()
class Job extends Equatable {

  @JsonKey(name: 'job_id')
  final int id;

  @JsonKey(name: 'job_name')
  final String? name;

  @JsonKey(name: 'start_date')
  final DateTime? startDate;

  @JsonKey(name: 'is_once')
  final String? isOnce;

  @JsonKey(name: 'num')
  final int? everyN;

  @JsonKey(name: 'is_minute')
  final String? isMinute;

  @JsonKey(name: 'is_from_to_time')
  final String? isFromToTime;

  @JsonKey(name: 'min_time_from')
  final DateTime? fromTime;

  @JsonKey(name: 'min_time_to')
  final DateTime? toTime;

  @JsonKey(name: 'is_day')
  final String? isDay;

  @JsonKey(name: 'is_everyn_day')
  final String? isEveryNDay;

  @JsonKey(name: 'is_work_day')
  final String? isWorkDay;

  @JsonKey(name: 'is_week')
  final String? isWeek;

  @JsonKey(name: 'is_daymonth')
  final String? isDayMonth;

  @JsonKey(name: 'is_last_month_day')
  final String? isLastMonthDay;

  @JsonKey(name: 'is_break_job_part')
  final String? isBreakJobPart;

  @JsonKey(name: 'everyn_week')
  final int? isEveryNWeek;

  @JsonKey(name: 'some_day')
  final String? someDay;

  @JsonKey(name: 'last_exec')
  final DateTime? lastExec;

  @JsonKey(name: 'is_more_one_job_in_queue')
  final String? isMoreThanOneJobInQueue;

  @JsonKey(name: 'is_on')
  final String? isOn;

  @JsonKey(name: 'error_msg')
  final String? errorMsg;

  @JsonKey(name: 'process_count')
  final int? processCount;

  @JsonKey(name: 'out_server_id')
  final int? outServerId;

  @JsonKey(name: 'minute_num')
  final int? everyNMin;

  @JsonKey(name: 'run_mode')
  final int? runMode;

  @JsonKey(name: 'job_config')
  final String? jobConfig;

  @JsonKey(name: 'exists_errors')
  final int? existsErrors;

  @JsonKey(name: 'exists_running')
  final int? existsRunning;

  @JsonKey(name: 'exists_success')
  final int? existsSuccess;

  @JsonKey(name: 'is_break_job_part_name')
  final String? isBreakJobPartName;

  @JsonKey(name: 'is_once_name')
  final String? isOnceName;

  @JsonKey(name: 'is_minute_name')
  final String? isMinuteName;

  @JsonKey(name: 'is_from_to_time_name')
  final String? isFromToTimeName;

  @JsonKey(name: 'is_day_name')
  final String? isDayName;

  @JsonKey(name: 'is_everyn_day_name')
  final String? isEverynDayName;

  @JsonKey(name: 'is_work_day_name')
  final String? isWorkDayName;

  @JsonKey(name: 'is_week_name')
  final String? isWeekName;

  @JsonKey(name: 'is_on_name')
  final String? isOnName;

  @JsonKey(name: 'is_daymonth_name')
  final String? isDayMonthName;

  @JsonKey(name: 'is_last_month_day_name')
  final String? isLastMonthDayName;

  @JsonKey(name: 'error_datetime')
  final DateTime? errorDateTime;

  @JsonKey(name: 'error_text')
  final String? errorText;

  @JsonKey(name: 'st')
  final int? jobStatus;

  const Job({
    required this.id,
    this.name,
    this.startDate,
    this.isOnce,
    this.everyN,
    this.isMinute,
    this.isFromToTime,
    this.fromTime,
    this.toTime,
    this.isDay,
    this.isEveryNDay,
    this.isWorkDay,
    this.isWeek,
    this.isDayMonth,
    this.isLastMonthDay,
    this.isBreakJobPart,
    this.isEveryNWeek,
    this.someDay,
    this.lastExec,
    this.isMoreThanOneJobInQueue,
    this.isOn,
    this.errorMsg,
    this.processCount,
    this.outServerId,
    this.everyNMin,
    this.runMode,
    this.jobConfig,
    this.existsErrors,
    this.existsRunning,
    this.existsSuccess,
    this.isBreakJobPartName,
    this.isOnceName,
    this.isMinuteName,
    this.isFromToTimeName,
    this.isDayName,
    this.isEverynDayName,
    this.isWorkDayName,
    this.isWeekName,
    this.isOnName,
    this.isDayMonthName,
    this.isLastMonthDayName,
    this.errorDateTime,
    this.errorText,
    this.jobStatus
  });

  factory Job.fromJson(Map<String, dynamic> json) => _$JobFromJson(json);

  Map<String, dynamic> toJson() => _$JobToJson(this);

  @override
  String toString() => 'Job($id)';

  @override
  List<Object?> get props => [
    id,
    name,
    startDate,
    isOnce,
    everyN,
    isMinute,
    isFromToTime,
    fromTime,
    toTime,
    isDay,
    isEveryNDay,
    isWorkDay,
    isWeek,
    isDayMonth,
    isLastMonthDay,
    isBreakJobPart,
    isEveryNWeek,
    someDay,
    lastExec,
    isMoreThanOneJobInQueue,
    isOn,
    errorMsg,
    processCount,
    outServerId,
    everyNMin,
    runMode,
    jobConfig,
    existsErrors,
    existsRunning,
    existsSuccess,
    isBreakJobPartName,
    isOnceName,
    isMinuteName,
    isFromToTimeName,
    isDayName,
    isEverynDayName,
    isWorkDayName,
    isWeekName,
    isOnName,
    isDayMonthName,
    isLastMonthDayName,
    errorDateTime,
    errorText,
    jobStatus
  ];

  ProcessingRequestsServerIdStatus get outServerIdEnum => ProcessingRequestsServerIdStatusExtension.fromInt(outServerId);

  IsOnOfStatus get isOnOffEnum => IsOnOfStatusExtension.fromInt(isOn);
}

 