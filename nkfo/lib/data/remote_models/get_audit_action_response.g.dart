// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_audit_action_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuditAction _$AuditActionFromJson(Map<String, dynamic> json) => AuditAction(
      id: json['action_id'] as int,
      name: json['action_code'] as String,
    );

Map<String, dynamic> _$AuditActionToJson(AuditAction instance) =>
    <String, dynamic>{
      'action_id': instance.id,
      'action_code': instance.name,
    };
