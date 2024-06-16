import 'package:json_annotation/json_annotation.dart';


part 'get_user_type_response.g.dart';

@JsonSerializable()
class UserType {

  @JsonKey(name: 'type_id')
  final int id;

  @JsonKey(name: 'type_name')
  final String name;

  UserType({
    required this.id,
    required this.name,
  });

  factory UserType.fromJson(Map<String, dynamic> json) => _$UserTypeFromJson(json);

  Map<String, dynamic> toJson() => _$UserTypeToJson(this);
  
}
