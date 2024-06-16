import 'package:json_annotation/json_annotation.dart';

part 'user_right_request.g.dart';

@JsonSerializable()
class UserRightRequest {

  @JsonKey(name: 'p_entity_name')
  String? entityName;

  @JsonKey(name: 'p_entity_type')
  String? entityType;

  @JsonKey(name: 'dev')
  bool? dev;


  UserRightRequest({
    this.entityName = '',
    this.entityType = '',
    this.dev = false
  });

  factory UserRightRequest.fromJson(Map<String, dynamic> json) => _$UserRightRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserRightRequestToJson(this);
  
}
