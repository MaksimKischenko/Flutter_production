// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_audit_applications_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuditApplication _$AuditApplicationFromJson(Map<String, dynamic> json) =>
    AuditApplication(
      name: json['application_name'] as String?,
      typeId: json['type_id'] as int?,
    );

Map<String, dynamic> _$AuditApplicationToJson(AuditApplication instance) =>
    <String, dynamic>{
      'type_id': instance.typeId,
      'application_name': instance.name,
    };
