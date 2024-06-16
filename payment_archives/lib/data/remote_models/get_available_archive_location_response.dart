// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_available_archive_location_response.g.dart';

@JsonSerializable()
class AvailableArchiveLocation extends Equatable {

  @JsonKey(name: 'source_id')
  final int? sourceId;

  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'create_date')
  final DateTime? createDate;

  @JsonKey(name: 'caption')
  final String? caption;

  @JsonKey(name: 'connection_host')
  final String? connectionHost;

  @JsonKey(name: 'connection_port')
  final int? connectionPort;

  @JsonKey(name: 'connection_user')
  final String? connectionUser;

  @JsonKey(name: 'database_name')
  final String? databaseName;

  @JsonKey(name: 'enabled')
  final bool? enabled;

  const AvailableArchiveLocation({
    required this.sourceId,
    required this.id,
    required this.createDate,
    required this.caption,
    required this.connectionHost,
    required this.connectionPort,
    required this.connectionUser,
    required this.databaseName,
    required this.enabled,
  });


  factory AvailableArchiveLocation.fromJson(Map<String, dynamic> json) => _$AvailableArchiveLocationFromJson(json);

  Map<String, dynamic> toJson() => _$AvailableArchiveLocationToJson(this);


  @override
  List<Object?> get props => [
    sourceId, id, caption, createDate, connectionHost, connectionPort, connectionUser, databaseName, enabled, 
  ];


  AvailableArchiveLocation copyWith({
    int? sourceId,
    int? id,
    DateTime? createDate,
    String? caption,
    String? connectionHost,
    int? connectionPort,
    String? connectionUser,
    String? databaseName,
    bool? enabled,
  }) => AvailableArchiveLocation(
      sourceId: sourceId ?? this.sourceId,
      id: id ?? this.id,
      createDate: createDate ?? this.createDate,
      caption: caption ?? this.caption,
      connectionHost: connectionHost ?? this.connectionHost,
      connectionPort: connectionPort ?? this.connectionPort,
      connectionUser: connectionUser ?? this.connectionUser,
      databaseName: databaseName ?? this.databaseName,
      enabled: enabled ?? this.enabled,
    );
    int get statusSortIndex => (enabled ?? false) ? 1 : 0;  
}
