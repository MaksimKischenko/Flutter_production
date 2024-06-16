import 'package:json_annotation/json_annotation.dart';

part 'user_role_request.g.dart';

@JsonSerializable()
class UserRoleRequest {

  @JsonKey(name: 'p_user_name')
  final String? userName;

  UserRoleRequest({
   required this.userName,
  });

  factory UserRoleRequest.fromJson(Map<String, dynamic> json) => _$UserRoleRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserRoleRequestToJson(this);
  
}
