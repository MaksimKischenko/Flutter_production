// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_insert_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobInsertRequest _$JobInsertRequestFromJson(Map<String, dynamic> json) =>
    JobInsertRequest(
      name: json['job_name'] as String?,
      startDate: json['start_date'] == null
          ? null
          : DateTime.parse(json['start_date'] as String),
      isOnce: json['is_once'] as String?,
      isNvalue: json['num'] as int?,
      isMinute: json['is_minute'] as String?,
      isFromToTime: json['is_from_to_time'] as String?,
      isDay: json['is_day'] as String?,
      isEveryNDay: json['is_everyn_day'] as String?,
      isWorkDay: json['is_work_day'] as String?,
      isWeek: json['is_week'] as String?,
      isDayMonth: json['is_daymonth'] as String?,
      fromTime: json['min_time_from'] == null
          ? null
          : DateTime.parse(json['min_time_from'] as String),
      toTime: json['min_time_to'] == null
          ? null
          : DateTime.parse(json['min_time_to'] as String),
      isLastMonthDay: json['is_last_month_day'] as String?,
      isBreakJobPart: json['is_break_job_part'] as String?,
      isEveryNWeek: json['everyn_week'] as int?,
      isOn: json['is_on'] as String?,
      isMoreThanOneJobInQueue: json['is_more_one_job_in_queue'] as String?,
      processCount: json['process_count'] as int?,
      outServerId: json['out_server_id'] as int?,
      everyNMin: json['minute_num'] as int?,
      someDay: json['some_day'] as String?,
    );

Map<String, dynamic> _$JobInsertRequestToJson(JobInsertRequest instance) =>
    <String, dynamic>{
      'job_name': instance.name,
      'start_date': instance.startDate?.toIso8601String(),
      'is_once': instance.isOnce,
      'num': instance.isNvalue,
      'is_minute': instance.isMinute,
      'is_from_to_time': instance.isFromToTime,
      'is_day': instance.isDay,
      'is_everyn_day': instance.isEveryNDay,
      'is_work_day': instance.isWorkDay,
      'is_week': instance.isWeek,
      'is_daymonth': instance.isDayMonth,
      'min_time_from': instance.fromTime?.toIso8601String(),
      'min_time_to': instance.toTime?.toIso8601String(),
      'is_last_month_day': instance.isLastMonthDay,
      'is_break_job_part': instance.isBreakJobPart,
      'everyn_week': instance.isEveryNWeek,
      'is_on': instance.isOn,
      'is_more_one_job_in_queue': instance.isMoreThanOneJobInQueue,
      'process_count': instance.processCount,
      'out_server_id': instance.outServerId,
      'minute_num': instance.everyNMin,
      'some_day': instance.someDay,
    };
