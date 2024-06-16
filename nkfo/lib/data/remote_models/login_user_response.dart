import 'package:json_annotation/json_annotation.dart';

part 'login_user_response.g.dart';

@JsonSerializable()
class LoginUserResponse {

  @JsonKey(name: 'token')
  final String token;

  LoginUserResponse({
    required this.token,
  });

  factory LoginUserResponse.fromJson(Map<String, dynamic> json) => _$LoginUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginUserResponseToJson(this);
  
}
