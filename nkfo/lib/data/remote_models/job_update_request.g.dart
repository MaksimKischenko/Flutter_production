// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_update_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobUpdateRequest _$JobUpdateRequestFromJson(Map<String, dynamic> json) =>
    JobUpdateRequest(
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

Map<String, dynamic> _$JobUpdateRequestToJson(JobUpdateRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('job_name', instance.name);
  writeNotNull('start_date', instance.startDate?.toIso8601String());
  writeNotNull('is_once', instance.isOnce);
  writeNotNull('num', instance.isNvalue);
  writeNotNull('is_minute', instance.isMinute);
  writeNotNull('is_from_to_time', instance.isFromToTime);
  writeNotNull('is_day', instance.isDay);
  writeNotNull('is_everyn_day', instance.isEveryNDay);
  writeNotNull('is_work_day', instance.isWorkDay);
  writeNotNull('is_week', instance.isWeek);
  writeNotNull('is_daymonth', instance.isDayMonth);
  writeNotNull('min_time_from', instance.fromTime?.toIso8601String());
  writeNotNull('min_time_to', instance.toTime?.toIso8601String());
  writeNotNull('is_last_month_day', instance.isLastMonthDay);
  writeNotNull('is_break_job_part', instance.isBreakJobPart);
  writeNotNull('everyn_week', instance.isEveryNWeek);
  writeNotNull('is_on', instance.isOn);
  writeNotNull('is_more_one_job_in_queue', instance.isMoreThanOneJobInQueue);
  writeNotNull('process_count', instance.processCount);
  writeNotNull('out_server_id', instance.outServerId);
  writeNotNull('minute_num', instance.everyNMin);
  writeNotNull('some_day', instance.someDay);
  return val;
}
