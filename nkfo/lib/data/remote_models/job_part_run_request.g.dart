// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_part_run_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobPartRunRequest _$JobPartRunRequestFromJson(Map<String, dynamic> json) =>
    JobPartRunRequest(
      jobId: json['p_job_id'] as int,
      jobPartId: json['p_job_part_id'] as int,
      params: (json['params'] as List<dynamic>)
          .map((e) => JobPartRunParam.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$JobPartRunRequestToJson(JobPartRunRequest instance) =>
    <String, dynamic>{
      'p_job_id': instance.jobId,
      'p_job_part_id': instance.jobPartId,
      'params': instance.params,
    };
