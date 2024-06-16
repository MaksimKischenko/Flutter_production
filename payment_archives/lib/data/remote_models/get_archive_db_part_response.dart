// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_archive_db_part_response.g.dart';

@JsonSerializable()
class ArchiveDBPart extends Equatable {

  @JsonKey(name: 'archive_id')
  final int archiveId;

  @JsonKey(name: 'part_id')
  final int partId;

  @JsonKey(name: 'create_date')
  final DateTime? createDate;

  @JsonKey(name: 'status_id')
  final int? statusId;

  @JsonKey(name: 'error_text')
  final String? errorText;

  @JsonKey(name: 'update_date')
  final DateTime? updateDate;

  @JsonKey(name: 'row_count')
  final int? rowCount;

  const ArchiveDBPart({
    required this.archiveId,
    required this.partId,
    required this.createDate,
    required this.statusId,
    required this.errorText,
    required this.updateDate,
    required this.rowCount,
  });

  factory ArchiveDBPart.fromJson(Map<String, dynamic> json) => _$ArchiveDBPartFromJson(json);

  Map<String, dynamic> toJson() => _$ArchiveDBPartToJson(this);


  @override
  List<Object?> get props => [
    archiveId, partId, createDate, statusId, errorText, updateDate, rowCount
  ];


  ArchiveDBPart copyWith({
    int? archiveId,
    int? partId,
    DateTime? createDate,
    int? statusId,
    String? errorText,
    DateTime? updateDate,
    int? rowCount,
  }) => ArchiveDBPart(
      archiveId: archiveId ?? this.archiveId,
      partId: partId ?? this.partId,
      createDate: createDate ?? this.createDate,
      statusId: statusId ?? this.statusId,
      errorText: errorText ?? this.errorText,
      updateDate: updateDate ?? this.updateDate,
      rowCount: rowCount ?? this.rowCount,
    );
}

 