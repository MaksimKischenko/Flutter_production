// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_part_param_update_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobPartParamUpdateRequest _$JobPartParamUpdateRequestFromJson(
        Map<String, dynamic> json) =>
    JobPartParamUpdateRequest(
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

Map<String, dynamic> _$JobPartParamUpdateRequestToJson(
    JobPartParamUpdateRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('job_part_param_id', instance.jobPartParamId);
  writeNotNull('job_part_id', instance.jobPartId);
  writeNotNull('param_name', instance.name);
  writeNotNull('is_auto_inc', instance.isAutoInc);
  writeNotNull('is_auto_clear_at_new_day', instance.isAutoClearAtNewDay);
  writeNotNull('access_type', instance.accessType);
  writeNotNull('param_type_id', instance.paramTypeId);
  writeNotNull('param_value', instance.paramValue);
  writeNotNull('param_type_name', instance.paramTypeName);
  writeNotNull('is_auto_inc_name', instance.isAutoIncName);
  writeNotNull(
      'is_auto_clear_at_new_day_name', instance.isAutoClearAtNewDayName);
  writeNotNull('access_type_name', instance.accessTypeName);
  writeNotNull('base_id', instance.baseId);
  return val;
}
