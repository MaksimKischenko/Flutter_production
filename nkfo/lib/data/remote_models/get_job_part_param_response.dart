import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:web_cabinet_nkfo/models/models.dart';

part 'get_job_part_param_response.g.dart';

@JsonSerializable()
class JobPartParam extends Equatable {
  
  
  @JsonKey(name: 'job_part_param_id')
  final int jobPartParamId;

  @JsonKey(name: 'job_part_id')
  final int jobPartId;

  @JsonKey(name: 'param_name')
  final String? name;

  @JsonKey(name: 'is_auto_inc')
  final String? isAutoInc;

  @JsonKey(name: 'is_auto_clear_at_new_day')
  final String? isAutoClearAtNewDay;

  @JsonKey(name: 'access_type')
  final int? accessType;

  @JsonKey(name: 'param_type_id')
  final int? paramTypeId;

  @JsonKey(name: 'param_value')
  final String? paramValue;

  @JsonKey(name: 'param_type_name')
  final String? paramTypeName;

  @JsonKey(name: 'is_auto_inc_name')
  final String? isAutoIncName;

  @JsonKey(name: 'is_auto_clear_at_new_day_name')
  final String? isAutoClearAtNewDayName;

  @JsonKey(name: 'access_type_name')
  final String? accessTypeName;

  @JsonKey(name: 'base_id')
  final String? baseId;

  const JobPartParam({
    required this.jobPartParamId,
    required this.jobPartId,
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


  factory JobPartParam.fromJson(Map<String, dynamic> json) => _$JobPartParamFromJson(json);

  Map<String, dynamic> toJson() => _$JobPartParamToJson(this);

  @override
  String toString() => 'JobPartParam($jobPartParamId)';

  AccessTypeStatus get accessTypeEnum => AccessTypeStatusExtension.fromInt(accessType);

  ParamTypeStatus get paramTypeEnum => ParamTypeStatusExtension.fromInt(paramTypeId);


  JobPartParam copyWith({
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

  }) => JobPartParam(
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

  @override
  List<Object?> get props => [
    jobPartParamId,
    jobPartId,
    name,
    isAutoInc,
    isAutoClearAtNewDay,
    accessType,
    paramTypeId,
    paramValue,
    paramTypeName,
    isAutoIncName,
    isAutoClearAtNewDayName,
    accessTypeName,
    baseId
  ];
}
