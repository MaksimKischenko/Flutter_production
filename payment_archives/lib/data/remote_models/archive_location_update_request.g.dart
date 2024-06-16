// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'archive_location_update_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArchiveLocationUpdateRequest _$ArchiveLocationUpdateRequestFromJson(
        Map<String, dynamic> json) =>
    ArchiveLocationUpdateRequest(
      id: json['id'] as int?,
      createDate: json['create_date'] == null
          ? null
          : DateTime.parse(json['create_date'] as String),
      caption: json['caption'] as String?,
      connectionHost: json['connection_host'] as String?,
      connectionPort: json['connection_port'] as int?,
      connectionUser: json['connection_user'] as String?,
      connectionPassword: json['connection_password'] as String?,
      databaseName: json['database_name'] as String?,
      enabled: json['enabled'] as bool?,
    );

Map<String, dynamic> _$ArchiveLocationUpdateRequestToJson(
    ArchiveLocationUpdateRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('create_date', instance.createDate?.toIso8601String());
  writeNotNull('caption', instance.caption);
  writeNotNull('connection_host', instance.connectionHost);
  writeNotNull('connection_port', instance.connectionPort);
  writeNotNull('connection_user', instance.connectionUser);
  writeNotNull('connection_password', instance.connectionPassword);
  writeNotNull('database_name', instance.databaseName);
  writeNotNull('enabled', instance.enabled);
  return val;
}
