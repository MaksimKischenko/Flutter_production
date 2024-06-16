// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_archive_db_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArchiveDB _$ArchiveDBFromJson(Map<String, dynamic> json) => ArchiveDB(
      id: json['id'] as int,
      caption: json['caption'] as String?,
      createDate: json['create_date'] == null
          ? null
          : DateTime.parse(json['create_date'] as String),
      sourceId: json['source_id'] as int?,
      enabled: json['enabled'] as bool?,
      statusId: json['status_id'] as int?,
      sourceArchiveId: json['source_archive_id'] as int?,
      partCount: json['part_count'] as int?,
      remoteClosed: json['remote_closed'] as bool?,
    );

Map<String, dynamic> _$ArchiveDBToJson(ArchiveDB instance) => <String, dynamic>{
      'id': instance.id,
      'caption': instance.caption,
      'create_date': instance.createDate?.toIso8601String(),
      'source_id': instance.sourceId,
      'enabled': instance.enabled,
      'status_id': instance.statusId,
      'source_archive_id': instance.sourceArchiveId,
      'part_count': instance.partCount,
      'remote_closed': instance.remoteClosed,
    };
