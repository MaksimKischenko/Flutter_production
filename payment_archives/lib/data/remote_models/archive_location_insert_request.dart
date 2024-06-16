// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'archive_location_insert_request.g.dart';

@JsonSerializable()
class ArchiveLocationInsertRequest {

  @JsonKey(name: 'create_date')
  DateTime? createDate;

  @JsonKey(name: 'caption')
  String? caption;

  @JsonKey(name: 'connection_host')
  String? connectionHost;

  @JsonKey(name: 'connection_port')
  int? connectionPort;

  @JsonKey(name: 'connection_user')
  String? connectionUser;

  @JsonKey(name: 'connection_password')
  String? connectionPassword;

  @JsonKey(name: 'database_name')
  String? databaseName;

  @JsonKey(name: 'enabled')
  bool? enabled;

  ArchiveLocationInsertRequest({
    this.createDate,
    this.caption,
    this.connectionHost,
    this.connectionPort,
    this.connectionUser,
    this.connectionPassword,
    this.databaseName,
    this.enabled = false,
  });


  factory ArchiveLocationInsertRequest.empty() =>  ArchiveLocationInsertRequest();

  factory ArchiveLocationInsertRequest.fromJson(Map<String, dynamic> json) => _$ArchiveLocationInsertRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ArchiveLocationInsertRequestToJson(this);


  ArchiveLocationInsertRequest copyWith({
    DateTime? createDate,
    String? caption,
    String? connectionHost,
    int? connectionPort,
    String? connectionUser,
    String? connectionPassword,
    String? databaseName,
    bool? enabled,
  }) => ArchiveLocationInsertRequest(
      createDate: createDate ?? this.createDate,
      caption: caption ?? this.caption,
      connectionHost: connectionHost ?? this.connectionHost,
      connectionPort: connectionPort ?? this.connectionPort,
      connectionUser: connectionUser ?? this.connectionUser,
      connectionPassword: connectionPassword ?? this.connectionPassword,
      databaseName: databaseName ?? this.databaseName,
      enabled: enabled ?? this.enabled,
    );
}
