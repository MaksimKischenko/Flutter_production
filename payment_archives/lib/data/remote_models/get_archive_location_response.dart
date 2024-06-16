// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_archive_location_response.g.dart';

@JsonSerializable()
class ArchiveLocation extends Equatable {

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

  @JsonKey(name: 'connection_password')
  final String? password;

  const ArchiveLocation({
    this.id,
    this.createDate,
    this.caption,
    this.connectionHost,
    this.connectionPort,
    this.connectionUser,
    this.databaseName,
    this.enabled,
    this.password,
  });

  factory ArchiveLocation.empty() =>  const ArchiveLocation();

  factory ArchiveLocation.fromJson(Map<String, dynamic> json) => _$ArchiveLocationFromJson(json);

  Map<String, dynamic> toJson() => _$ArchiveLocationToJson(this);


  @override
  List<Object?> get props => [
   password, id, caption, createDate, connectionHost, connectionPort, connectionUser, databaseName, enabled, 
  ];



  int get statusSortIndex => (enabled ?? false) ? 1 : 0;   

  ArchiveLocation copyWith({
    int? id,
    DateTime? createDate,
    String? caption,
    String? connectionHost,
    int? connectionPort,
    String? connectionUser,
    String? databaseName,
    bool? enabled,
    String? password,
  }) => ArchiveLocation(
      id: id ?? this.id,
      createDate: createDate ?? this.createDate,
      caption: caption ?? this.caption,
      connectionHost: connectionHost ?? this.connectionHost,
      connectionPort: connectionPort ?? this.connectionPort,
      connectionUser: connectionUser ?? this.connectionUser,
      databaseName: databaseName ?? this.databaseName,
      enabled: enabled ?? this.enabled,
      password: password ?? this.password,
    );
}
