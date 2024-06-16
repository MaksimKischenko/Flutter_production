// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_part_run_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobPartRunParam _$JobPartRunParamFromJson(Map<String, dynamic> json) =>
    JobPartRunParam(
      name: json['param_name'] as String?,
      paramValue: json['param_value'] as String?,
      paramType: json['param_type_id'] as int?,
      accessType: json['access_type'] as int?,
    );

Map<String, dynamic> _$JobPartRunParamToJson(JobPartRunParam instance) =>
    <String, dynamic>{
      'param_name': instance.name,
      'param_value': instance.paramValue,
      'param_type_id': instance.paramType,
      'access_type': instance.accessType,
    };
