// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audit_log_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuditLog _$AuditLogFromJson(Map<String, dynamic> json) => AuditLog(
      logId: json['log_id'] as int?,
      userId: json['user_id'] as int?,
      opDateTime: json['op_datetime'] == null
          ? null
          : DateTime.parse(json['op_datetime'] as String),
      entityId: json['entity_id'] as int?,
      actionId: json['action_id'] as int?,
      opDescr: json['op_descr'] as String?,
      userName: json['user_name'] as String?,
      fullUserName: json['full_user_name'] as String?,
      ipAddress: json['computer_ip_address'] as String?,
      computerName: json['computer_name'] as String?,
      process: json['process'] as String?,
      applicationTypeId: json['application_type_id'] as int?,
      program: json['program'] as String?,
      requestId: json['request_id'] as int?,
      actionResult: json['action_result'] as int?,
      objectId: json['object_id'] as String?,
    );

Map<String, dynamic> _$AuditLogToJson(AuditLog instance) => <String, dynamic>{
      'log_id': instance.logId,
      'user_id': instance.userId,
      'op_datetime': instance.opDateTime?.toIso8601String(),
      'entity_id': instance.entityId,
      'action_id': instance.actionId,
      'op_descr': instance.opDescr,
      'computer_ip_address': instance.ipAddress,
      'computer_name': instance.computerName,
      'user_name': instance.userName,
      'full_user_name': instance.fullUserName,
      'process': instance.process,
      'application_type_id': instance.applicationTypeId,
      'program': instance.program,
      'request_id': instance.requestId,
      'action_result': instance.actionResult,
      'object_id': instance.objectId,
    };
