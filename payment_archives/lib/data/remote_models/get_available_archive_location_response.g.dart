// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_available_archive_location_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvailableArchiveLocation _$AvailableArchiveLocationFromJson(
        Map<String, dynamic> json) =>
    AvailableArchiveLocation(
      sourceId: json['source_id'] as int?,
      id: json['id'] as int?,
      createDate: json['create_date'] == null
          ? null
          : DateTime.parse(json['create_date'] as String),
      caption: json['caption'] as String?,
      connectionHost: json['connection_host'] as String?,
      connectionPort: json['connection_port'] as int?,
      connectionUser: json['connection_user'] as String?,
      databaseName: json['database_name'] as String?,
      enabled: json['enabled'] as bool?,
    );

Map<String, dynamic> _$AvailableArchiveLocationToJson(
        AvailableArchiveLocation instance) =>
    <String, dynamic>{
      'source_id': instance.sourceId,
      'id': instance.id,
      'create_date': instance.createDate?.toIso8601String(),
      'caption': instance.caption,
      'connection_host': instance.connectionHost,
      'connection_port': instance.connectionPort,
      'connection_user': instance.connectionUser,
      'database_name': instance.databaseName,
      'enabled': instance.enabled,
    };
