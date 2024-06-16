 // ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'data_source_insert_request.g.dart';

@JsonSerializable()
class DataSourceInsertRequest {

  @JsonKey(name: 'create_date')
  final DateTime? createDate;

  @JsonKey(name: 'caption')
  final String? caption;

  @JsonKey(name: 'user_id')
  final int? userId;

  @JsonKey(name: 'login')
  final String? login;

  @JsonKey(name: 'password')
  final String? password;

  @JsonKey(name: 'data_scale')
  final int? dataScale;

  @JsonKey(name: 'enabled')
  final bool? enabled;

  @JsonKey(name: 'blocked')
  final bool? blocked;

  DataSourceInsertRequest({
    this.createDate,
    this.caption,
    this.userId,
    this.login,
    this.password,
    this.dataScale,
    this.enabled = true,
    this.blocked = false,
  });

 

  factory DataSourceInsertRequest.empty() =>  DataSourceInsertRequest();

  factory DataSourceInsertRequest.fromJson(Map<String, dynamic> json) => _$DataSourceInsertRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DataSourceInsertRequestToJson(this);
  

  DataSourceInsertRequest copyWith({
    DateTime? createDate,
    String? caption,
    int? userId,
    String? login,
    int? dataScale,
    String? password,
    bool? enabled,
    bool? blocked,
  }) => DataSourceInsertRequest(
      createDate: createDate ?? this.createDate,
      caption: caption ?? this.caption,
      userId: userId ?? this.userId,
      login: login ?? this.login,
      password: password ?? this.password,
      dataScale: dataScale ?? this.dataScale,
      enabled: enabled ?? this.enabled,
      blocked: blocked ?? this.blocked,
    );
}

 
 
 
 
 
