// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_right_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRight _$UserRightFromJson(Map<String, dynamic> json) => UserRight(
      entityName: $enumDecode(_$EntityNameEnumMap, json['entity_name'],
          unknownValue: EntityName.unknown),
      entityType: json['entity_type'] as String,
      methods: (json['methods'] as List<dynamic>)
          .map((e) => $enumDecode(_$EntityMethodEnumMap, e,
              unknownValue: EntityMethod.unknown))
          .toList(),
    );

Map<String, dynamic> _$UserRightToJson(UserRight instance) => <String, dynamic>{
      'entity_name': _$EntityNameEnumMap[instance.entityName]!,
      'entity_type': instance.entityType,
      'methods':
          instance.methods.map((e) => _$EntityMethodEnumMap[e]!).toList(),
    };

const _$EntityNameEnumMap = {
  EntityName.supplier: 'supplier',
  EntityName.supplierAccount: 'supplier_account',
  EntityName.user: 'user_',
  EntityName.userType: 'user_type',
  EntityName.userResetPassword: 'reset_password',
  EntityName.audit: 'op_audit',
  EntityName.auditApplication: 'audit_application',
  EntityName.auditAction: 'audit_action',
  EntityName.auditArchive: 'op_audit_archive_day',
  EntityName.serverMessage: 'supplier_server_message',
  EntityName.changePassword: 'change_password',
  EntityName.job: 'job_config',
  EntityName.jobRun: 'job_execute',
  EntityName.jobPart: 'job_part',
  EntityName.jobPartRun: 'job_part_execute',
  EntityName.jobPartParam: 'job_part_param',
  EntityName.messageType: 'message_type',
  EntityName.startMessage: 'start_message_reset',
  EntityName.unknown: 'unknown',
};

const _$EntityMethodEnumMap = {
  EntityMethod.getM: 'GET',
  EntityMethod.postM: 'POST',
  EntityMethod.patchM: 'PATCH',
  EntityMethod.deleteM: 'DELETE',
  EntityMethod.unknown: 'unknown',
};
