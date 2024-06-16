// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_archive_db_response.g.dart';

@JsonSerializable()
class ArchiveDB extends Equatable {

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'caption')
  final String? caption;

  @JsonKey(name: 'create_date')
  final DateTime? createDate;

  @JsonKey(name: 'source_id')
  final int? sourceId;

  @JsonKey(name: 'enabled')
  final bool? enabled;

  @JsonKey(name: 'status_id')
  final int? statusId;

  @JsonKey(name: 'source_archive_id')
  final int? sourceArchiveId;

  @JsonKey(name: 'part_count')
  final int? partCount;

  @JsonKey(name: 'remote_closed')
  final bool? remoteClosed;

  const ArchiveDB({
    required this.id,
    required this.caption,
    required this.createDate,
    required this.sourceId,
    required this.enabled,
    required this.statusId,
    required this.sourceArchiveId,
    required this.partCount,
    required this.remoteClosed,
  });


  factory ArchiveDB.fromJson(Map<String, dynamic> json) => _$ArchiveDBFromJson(json);

  Map<String, dynamic> toJson() => _$ArchiveDBToJson(this);


  @override
  List<Object?> get props => [
    id, caption, createDate, sourceId, enabled, statusId, sourceArchiveId, partCount, remoteClosed
  ];


  ArchiveDB copyWith({
    int? id,
    String? caption,
    DateTime? createDate,
    int? sourceId,
    bool? enabled,
    int? statusId,
    int? sourceArchiveId,
    int? partCount,
    bool? remoteClosed,
  }) => ArchiveDB(
      id: id ?? this.id,
      caption: caption ?? this.caption,
      createDate: createDate ?? this.createDate,
      sourceId: sourceId ?? this.sourceId,
      enabled: enabled ?? this.enabled,
      statusId: statusId ?? this.statusId,
      sourceArchiveId: sourceArchiveId ?? this.sourceArchiveId,
      partCount: partCount ?? this.partCount,
      remoteClosed: remoteClosed ?? this.remoteClosed,
    );

  int get statusSortIndex => (enabled ?? false) ? 1 : 0;    
}

 