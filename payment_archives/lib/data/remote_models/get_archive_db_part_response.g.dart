// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_archive_db_part_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArchiveDBPart _$ArchiveDBPartFromJson(Map<String, dynamic> json) =>
    ArchiveDBPart(
      archiveId: json['archive_id'] as int,
      partId: json['part_id'] as int,
      createDate: json['create_date'] == null
          ? null
          : DateTime.parse(json['create_date'] as String),
      statusId: json['status_id'] as int?,
      errorText: json['error_text'] as String?,
      updateDate: json['update_date'] == null
          ? null
          : DateTime.parse(json['update_date'] as String),
      rowCount: json['row_count'] as int?,
    );

Map<String, dynamic> _$ArchiveDBPartToJson(ArchiveDBPart instance) =>
    <String, dynamic>{
      'archive_id': instance.archiveId,
      'part_id': instance.partId,
      'create_date': instance.createDate?.toIso8601String(),
      'status_id': instance.statusId,
      'error_text': instance.errorText,
      'update_date': instance.updateDate?.toIso8601String(),
      'row_count': instance.rowCount,
    };
