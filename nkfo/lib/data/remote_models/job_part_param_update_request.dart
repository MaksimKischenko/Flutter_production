import 'package:json_annotation/json_annotation.dart';

part 'job_part_param_update_request.g.dart';

@JsonSerializable(includeIfNull: false)
class JobPartParamUpdateRequest {
  
  @JsonKey(name: 'job_part_param_id')
  int? jobPartParamId;

  @JsonKey(name: 'job_part_id')
  int? jobPartId;

  @JsonKey(name: 'param_name')
  String? name;

  @JsonKey(name: 'is_auto_inc')
  String? isAutoInc;

  @JsonKey(name: 'is_auto_clear_at_new_day')
  String? isAutoClearAtNewDay;

  @JsonKey(name: 'access_type')
  int? accessType;

  @JsonKey(name: 'param_type_id')
  int? paramTypeId;

  @JsonKey(name: 'param_value')
  String? paramValue;

  @JsonKey(name: 'param_type_name')
  String? paramTypeName;

  @JsonKey(name: 'is_auto_inc_name')
  String? isAutoIncName;

  @JsonKey(name: 'is_auto_clear_at_new_day_name')
  String? isAutoClearAtNewDayName;

  @JsonKey(name: 'access_type_name')
  String? accessTypeName;

  @JsonKey(name: 'base_id')
  String? baseId;


  JobPartParamUpdateRequest({
    this.jobPartParamId,
    this.jobPartId,
    this.name,
    this.isAutoInc,
    this.isAutoClearAtNewDay,
    this.accessType,
    this.paramTypeId,
    this.paramValue,
    this.paramTypeName,
    this.isAutoIncName,
    this.isAutoClearAtNewDayName,
    this.accessTypeName,
    this.baseId,
  });

 
  factory JobPartParamUpdateRequest.fromJson(Map<String, dynamic> json) => _$JobPartParamUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$JobPartParamUpdateRequestToJson(this);


  JobPartParamUpdateRequest copyWith({
    int? jobPartParamId,
    int? jobPartId,
    String? name,
    String? isAutoInc,
    String? isAutoClearAtNewDay,
    int? accessType,
    int? paramTypeId,
    String? paramValue,
    String? paramTypeName,
    String? isAutoIncName,
    String? isAutoClearAtNewDayName,
    String? accessTypeName,
    String? baseId,

  }) => JobPartParamUpdateRequest(
      jobPartParamId: jobPartParamId ?? this.jobPartParamId,
      jobPartId: jobPartId ?? this.jobPartId,
      name: name ?? this.name,
      isAutoInc: isAutoInc ?? this.isAutoInc,
      isAutoClearAtNewDay: isAutoClearAtNewDay ?? this.isAutoClearAtNewDay,
      accessType: accessType ?? this.accessType,
      paramTypeId: paramTypeId ?? this.paramTypeId,
      paramValue: paramValue ?? this.paramValue,
      paramTypeName: paramTypeName ?? this.paramTypeName,
      isAutoIncName: isAutoIncName ?? this.isAutoIncName,
      isAutoClearAtNewDayName: isAutoClearAtNewDayName ?? this.isAutoClearAtNewDayName,
      accessTypeName: accessTypeName ?? this.accessTypeName,
      baseId: baseId ?? this.baseId,
    );
}
