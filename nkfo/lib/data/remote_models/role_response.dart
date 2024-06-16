import 'package:json_annotation/json_annotation.dart';

part 'role_response.g.dart';

@JsonSerializable()
class Role {

  @JsonKey(name: 'user_id')
  final int id;

  @JsonKey(name: 'user_name')
  final String name;

  @JsonKey(name: 'user_kind_id')
  final int kindId;

  @JsonKey(name: 'enabled')
  final bool enabled;


  Role({
    required this.id,
    required this.name,
    required this.kindId,
    required this.enabled
  });

  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);

  Map<String, dynamic> toJson() => _$RoleToJson(this);
  
}
