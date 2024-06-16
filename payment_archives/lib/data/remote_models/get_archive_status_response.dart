// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_archive_status_response.g.dart';

@JsonSerializable()
class ArchiveStatus extends Equatable {

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'caption')
  final String caption;

  const ArchiveStatus({
    required this.id,
    required this.caption,
  });


  factory ArchiveStatus.fromJson(Map<String, dynamic> json) => _$ArchiveStatusFromJson(json);

  Map<String, dynamic> toJson() => _$ArchiveStatusToJson(this);


  @override
  List<Object?> get props => [id, caption];


  ArchiveStatus copyWith({
    int? id,
    String? caption,
  }) => ArchiveStatus(
      id: id ?? this.id,
      caption: caption ?? this.caption,
    );
}
