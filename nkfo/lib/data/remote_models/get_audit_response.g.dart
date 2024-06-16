// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_audit_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Audit _$AuditFromJson(Map<String, dynamic> json) => Audit(
      id: json['op_audit_id'] as int,
      clientId: json['client_id'] as int?,
      clientName: json['client_name'] as String?,
      clientLogin: json['client_login'] as String?,
      date: json['op_action_date'] == null
          ? null
          : DateTime.parse(json['op_action_date'] as String),
      description: json['op_descr'] as String?,
      ip: json['computer_ip_address'] as String?,
      application: json['action_arm'] as String?,
      actionName: json['op_action_code'] as String?,
      actionId: json['action_id'] as int?,
      actionNote: json['op_action_note'] as String?,
      actionArmNote: json['action_arm_note'] as int?,
      actionResult: json['action_result'] as String?,
      supplierId: json['supplier_id'] as int?,
      supplierName: json['supplier_name'] as String?,
    );

Map<String, dynamic> _$AuditToJson(Audit instance) => <String, dynamic>{
      'op_audit_id': instance.id,
      'client_id': instance.clientId,
      'client_name': instance.clientName,
      'client_login': instance.clientLogin,
      'op_action_date': instance.date?.toIso8601String(),
      'op_descr': instance.description,
      'computer_ip_address': instance.ip,
      'action_arm': instance.application,
      'op_action_code': instance.actionName,
      'action_id': instance.actionId,
      'op_action_note': instance.actionNote,
      'action_arm_note': instance.actionArmNote,
      'action_result': instance.actionResult,
      'supplier_id': instance.supplierId,
      'supplier_name': instance.supplierName,
    };
