// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_part_param_insert_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobPartParamInsertRequest _$JobPartParamInsertRequestFromJson(
        Map<String, dynamic> json) =>
    JobPartParamInsertRequest(
      jobPartParamId: json['job_part_param_id'] as int?,
      jobPartId: json['job_part_id'] as int?,
      name: json['param_name'] as String?,
      isAutoInc: json['is_auto_inc'] as String?,
      isAutoClearAtNewDay: json['is_auto_clear_at_new_day'] as String?,
      accessType: json['access_type'] as int?,
      paramTypeId: json['param_type_id'] as int?,
      paramValue: json['param_value'] as String?,
      paramTypeName: json['param_type_name'] as String?,
      isAutoIncName: json['is_auto_inc_name'] as String?,
      isAutoClearAtNewDayName: json['is_auto_clear_at_new_day_name'] as String?,
      accessTypeName: json['access_type_name'] as String?,
      baseId: json['base_id'] as String?,
    );

Map<String, dynamic> _$JobPartParamInsertRequestToJson(
        JobPartParamInsertRequest instance) =>
    <String, dynamic>{
      'job_part_param_id': instance.jobPartParamId,
      'job_part_id': instance.jobPartId,
      'param_name': instance.name,
      'is_auto_inc': instance.isAutoInc,
      'is_auto_clear_at_new_day': instance.isAutoClearAtNewDay,
      'access_type': instance.accessType,
      'param_type_id': instance.paramTypeId,
      'param_value': instance.paramValue,
      'param_type_name': instance.paramTypeName,
      'is_auto_inc_name': instance.isAutoIncName,
      'is_auto_clear_at_new_day_name': instance.isAutoClearAtNewDayName,
      'access_type_name': instance.accessTypeName,
      'base_id': instance.baseId,
    };
