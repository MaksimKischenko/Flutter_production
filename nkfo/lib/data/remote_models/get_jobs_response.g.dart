// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_jobs_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Job _$JobFromJson(Map<String, dynamic> json) => Job(
      id: json['job_id'] as int,
      name: json['job_name'] as String?,
      startDate: json['start_date'] == null
          ? null
          : DateTime.parse(json['start_date'] as String),
      isOnce: json['is_once'] as String?,
      everyN: json['num'] as int?,
      isMinute: json['is_minute'] as String?,
      isFromToTime: json['is_from_to_time'] as String?,
      fromTime: json['min_time_from'] == null
          ? null
          : DateTime.parse(json['min_time_from'] as String),
      toTime: json['min_time_to'] == null
          ? null
          : DateTime.parse(json['min_time_to'] as String),
      isDay: json['is_day'] as String?,
      isEveryNDay: json['is_everyn_day'] as String?,
      isWorkDay: json['is_work_day'] as String?,
      isWeek: json['is_week'] as String?,
      isDayMonth: json['is_daymonth'] as String?,
      isLastMonthDay: json['is_last_month_day'] as String?,
      isBreakJobPart: json['is_break_job_part'] as String?,
      isEveryNWeek: json['everyn_week'] as int?,
      someDay: json['some_day'] as String?,
      lastExec: json['last_exec'] == null
          ? null
          : DateTime.parse(json['last_exec'] as String),
      isMoreThanOneJobInQueue: json['is_more_one_job_in_queue'] as String?,
      isOn: json['is_on'] as String?,
      errorMsg: json['error_msg'] as String?,
      processCount: json['process_count'] as int?,
      outServerId: json['out_server_id'] as int?,
      everyNMin: json['minute_num'] as int?,
      runMode: json['run_mode'] as int?,
      jobConfig: json['job_config'] as String?,
      existsErrors: json['exists_errors'] as int?,
      existsRunning: json['exists_running'] as int?,
      existsSuccess: json['exists_success'] as int?,
      isBreakJobPartName: json['is_break_job_part_name'] as String?,
      isOnceName: json['is_once_name'] as String?,
      isMinuteName: json['is_minute_name'] as String?,
      isFromToTimeName: json['is_from_to_time_name'] as String?,
      isDayName: json['is_day_name'] as String?,
      isEverynDayName: json['is_everyn_day_name'] as String?,
      isWorkDayName: json['is_work_day_name'] as String?,
      isWeekName: json['is_week_name'] as String?,
      isOnName: json['is_on_name'] as String?,
      isDayMonthName: json['is_daymonth_name'] as String?,
      isLastMonthDayName: json['is_last_month_day_name'] as String?,
      errorDateTime: json['error_datetime'] == null
          ? null
          : DateTime.parse(json['error_datetime'] as String),
      errorText: json['error_text'] as String?,
      jobStatus: json['st'] as int?,
    );

Map<String, dynamic> _$JobToJson(Job instance) => <String, dynamic>{
      'job_id': instance.id,
      'job_name': instance.name,
      'start_date': instance.startDate?.toIso8601String(),
      'is_once': instance.isOnce,
      'num': instance.everyN,
      'is_minute': instance.isMinute,
      'is_from_to_time': instance.isFromToTime,
      'min_time_from': instance.fromTime?.toIso8601String(),
      'min_time_to': instance.toTime?.toIso8601String(),
      'is_day': instance.isDay,
      'is_everyn_day': instance.isEveryNDay,
      'is_work_day': instance.isWorkDay,
      'is_week': instance.isWeek,
      'is_daymonth': instance.isDayMonth,
      'is_last_month_day': instance.isLastMonthDay,
      'is_break_job_part': instance.isBreakJobPart,
      'everyn_week': instance.isEveryNWeek,
      'some_day': instance.someDay,
      'last_exec': instance.lastExec?.toIso8601String(),
      'is_more_one_job_in_queue': instance.isMoreThanOneJobInQueue,
      'is_on': instance.isOn,
      'error_msg': instance.errorMsg,
      'process_count': instance.processCount,
      'out_server_id': instance.outServerId,
      'minute_num': instance.everyNMin,
      'run_mode': instance.runMode,
      'job_config': instance.jobConfig,
      'exists_errors': instance.existsErrors,
      'exists_running': instance.existsRunning,
      'exists_success': instance.existsSuccess,
      'is_break_job_part_name': instance.isBreakJobPartName,
      'is_once_name': instance.isOnceName,
      'is_minute_name': instance.isMinuteName,
      'is_from_to_time_name': instance.isFromToTimeName,
      'is_day_name': instance.isDayName,
      'is_everyn_day_name': instance.isEverynDayName,
      'is_work_day_name': instance.isWorkDayName,
      'is_week_name': instance.isWeekName,
      'is_on_name': instance.isOnName,
      'is_daymonth_name': instance.isDayMonthName,
      'is_last_month_day_name': instance.isLastMonthDayName,
      'error_datetime': instance.errorDateTime?.toIso8601String(),
      'error_text': instance.errorText,
      'st': instance.jobStatus,
    };
