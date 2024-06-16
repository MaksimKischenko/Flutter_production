import 'package:json_annotation/json_annotation.dart';

part 'job_insert_request.g.dart';

@JsonSerializable()
class JobInsertRequest {

  @JsonKey(name: 'job_name')
  String? name;

  @JsonKey(name: 'start_date')
  DateTime? startDate;

  @JsonKey(name: 'is_once')
  String? isOnce;

  @JsonKey(name: 'num')
  int? isNvalue;

  @JsonKey(name: 'is_minute')
  String? isMinute;

  @JsonKey(name: 'is_from_to_time')
  String? isFromToTime;

  @JsonKey(name: 'is_day')
  String? isDay;

  @JsonKey(name: 'is_everyn_day')
  String? isEveryNDay;

  @JsonKey(name: 'is_work_day')
  String? isWorkDay;

  @JsonKey(name: 'is_week')
  String? isWeek;

  @JsonKey(name: 'is_daymonth')
  String? isDayMonth;

  @JsonKey(name: 'min_time_from')
  DateTime? fromTime;

  @JsonKey(name: 'min_time_to')
  DateTime? toTime;

  @JsonKey(name: 'is_last_month_day')
  String? isLastMonthDay;

  @JsonKey(name: 'is_break_job_part')
  String? isBreakJobPart;

  @JsonKey(name: 'everyn_week')
  int? isEveryNWeek;

  @JsonKey(name: 'is_on')
  String? isOn;

  @JsonKey(name: 'is_more_one_job_in_queue')
  String? isMoreThanOneJobInQueue;

  @JsonKey(name: 'process_count')
  int? processCount;

  @JsonKey(name: 'out_server_id')
  int? outServerId;

  @JsonKey(name: 'minute_num')
  int? everyNMin;

  @JsonKey(name: 'some_day')
  String? someDay;


  JobInsertRequest({
    this.name,
    this.startDate,
    this.isOnce,
    this.isNvalue,
    this.isMinute,
    this.isFromToTime,
    this.isDay,
    this.isEveryNDay,
    this.isWorkDay,
    this.isWeek,
    this.isDayMonth,
    this.fromTime,
    this.toTime,
    this.isLastMonthDay,
    this.isBreakJobPart,
    this.isEveryNWeek,
    this.isOn,
    this.isMoreThanOneJobInQueue,
    this.processCount,
    this.outServerId,
    this.everyNMin,
    this.someDay,
  });

  
  factory JobInsertRequest.fromJson(Map<String, dynamic> json) => _$JobInsertRequestFromJson(json);

  Map<String, dynamic> toJson() => _$JobInsertRequestToJson(this);

 


  JobInsertRequest copyWith({
    String? name,
    DateTime? startDate,
    String? isOnce,
    int? isNvalue,
    String? isMinute,
    String? isFromToTime,
    String? isDay,
    String? isEveryNDay,
    String? isWorkDay,
    String? isWeek,
    String? isDayMonth,
    DateTime? fromTime,
    DateTime? toTime,
    String? isLastMonthDay,
    String? isBreakJobPart,
    int? isEveryNWeek,
    String? isOn,
    String? isMoreThanOneJobInQueue,
    int? processCount,
    int? outServerId,
    int? everyNMin,
    String? someDay,
    
  }) => JobInsertRequest(
      name: name ?? this.name,
      startDate: startDate ?? this.startDate,
      isOnce: isOnce ?? this.isOnce,
      isNvalue: isNvalue ?? this.isNvalue,
      isMinute: isMinute ?? this.isMinute,
      isFromToTime: isFromToTime ?? this.isFromToTime,
      isDay: isDay ?? this.isDay,
      isEveryNDay: isEveryNDay ?? this.isEveryNDay,
      isWorkDay: isWorkDay ?? this.isWorkDay,
      isWeek: isWeek ?? this.isWeek,
      isDayMonth: isDayMonth ?? this.isDayMonth,
      fromTime: fromTime ?? this.fromTime,
      toTime: toTime ?? this.toTime,
      isLastMonthDay: isLastMonthDay ?? this.isLastMonthDay,
      isBreakJobPart: isBreakJobPart ?? this.isBreakJobPart,
      isEveryNWeek: isEveryNWeek ?? this.isEveryNWeek,
      isOn: isOn ?? this.isOn,
      isMoreThanOneJobInQueue: isMoreThanOneJobInQueue ?? this.isMoreThanOneJobInQueue,
      processCount: processCount ?? this.processCount,
      outServerId: outServerId ?? this.outServerId,
      everyNMin: everyNMin ?? this.everyNMin,
      someDay: someDay ?? this.someDay,
    );
}
