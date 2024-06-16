// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'archive_location_insert_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArchiveLocationInsertRequest _$ArchiveLocationInsertRequestFromJson(
        Map<String, dynamic> json) =>
    ArchiveLocationInsertRequest(
      createDate: json['create_date'] == null
          ? null
          : DateTime.parse(json['create_date'] as String),
      caption: json['caption'] as String?,
      connectionHost: json['connection_host'] as String?,
      connectionPort: json['connection_port'] as int?,
      connectionUser: json['connection_user'] as String?,
      connectionPassword: json['connection_password'] as String?,
      databaseName: json['database_name'] as String?,
      enabled: json['enabled'] as bool? ?? false,
    );

Map<String, dynamic> _$ArchiveLocationInsertRequestToJson(
        ArchiveLocationInsertRequest instance) =>
    <String, dynamic>{
      'create_date': instance.createDate?.toIso8601String(),
      'caption': instance.caption,
      'connection_host': instance.connectionHost,
      'connection_port': instance.connectionPort,
      'connection_user': instance.connectionUser,
      'connection_password': instance.connectionPassword,
      'database_name': instance.databaseName,
      'enabled': instance.enabled,
    };
