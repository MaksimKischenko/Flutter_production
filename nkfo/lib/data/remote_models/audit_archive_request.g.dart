// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audit_archive_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuditArchiveRequest _$AuditArchiveRequestFromJson(Map<String, dynamic> json) =>
    AuditArchiveRequest(
      actions: json['p_arm'] as String,
      dateFrom: json['p_day'] == null
          ? null
          : DateTime.parse(json['p_day'] as String),
    );

Map<String, dynamic> _$AuditArchiveRequestToJson(
        AuditArchiveRequest instance) =>
    <String, dynamic>{
      'p_arm': instance.actions,
      'p_day': instance.dateFrom?.toIso8601String(),
    };
