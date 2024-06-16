 // ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'data_source_update_request.g.dart';

@JsonSerializable(includeIfNull: false)
class DataSourceUpdateRequest {

  @JsonKey(name: 'create_date')
  final DateTime? createDate;

  @JsonKey(name: 'caption')
  final String? caption;

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

  DataSourceUpdateRequest({
    this.createDate,
    this.caption,
    this.login,
    this.password,
    this.dataScale,
    this.enabled,
    this.blocked,
  });


  factory DataSourceUpdateRequest.empty() =>  DataSourceUpdateRequest();

  factory DataSourceUpdateRequest.fromJson(Map<String, dynamic> json) => _$DataSourceUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DataSourceUpdateRequestToJson(this);
  
  DataSourceUpdateRequest copyWith({
    DateTime? createDate,
    String? caption,
    String? login,
    String? password,
    int? dataScale,
    bool? enabled,
    bool? blocked,
  }) => DataSourceUpdateRequest(
      createDate: createDate ?? this.createDate,
      caption: caption ?? this.caption,
      login: login ?? this.login,
      password: password ?? this.password,
      dataScale: dataScale ?? this.dataScale,
      enabled: enabled ?? this.enabled,
      blocked: blocked ?? this.blocked,
    );
}

 
 
 
 
 
