import 'package:json_annotation/json_annotation.dart';

part 'login_user_request.g.dart';

@JsonSerializable()
class LoginUserRequest {

  @JsonKey(name: 'app_user')
  final String user;

  @JsonKey(name: 'pass')
  final String password;

  LoginUserRequest({
    required this.user,
    required this.password,
  });

  factory LoginUserRequest.fromJson(Map<String, dynamic> json) => _$LoginUserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginUserRequestToJson(this);
  
}
