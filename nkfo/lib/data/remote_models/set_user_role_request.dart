import 'package:json_annotation/json_annotation.dart';


part 'set_user_role_request.g.dart';

@JsonSerializable()
class SetUserRoleRequest {

  @JsonKey(name: 'p_user_name')
  final String? userName;

  @JsonKey(name: 'p_role_ids')
  final List<int> userRolesIds;

  SetUserRoleRequest({
    required this.userName,
    required this.userRolesIds,
  });

  factory SetUserRoleRequest.fromJson(Map<String, dynamic> json) => _$SetUserRoleRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SetUserRoleRequestToJson(this);
  
}
