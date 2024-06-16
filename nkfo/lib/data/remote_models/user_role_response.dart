import 'package:json_annotation/json_annotation.dart';

part 'user_role_response.g.dart';

@JsonSerializable()
class UserRole {

  @JsonKey(name: 'role_id')
  final int? id;

  @JsonKey(name: 'role_name')
  final String? name;

  UserRole({
   required this.id,
   required this.name
  });

  factory UserRole.fromJson(Map<String, dynamic> json) => _$UserRoleFromJson(json);

  Map<String, dynamic> toJson() => _$UserRoleToJson(this);
  
}
