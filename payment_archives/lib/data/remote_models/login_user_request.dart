// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'login_user_request.g.dart';

@JsonSerializable(includeIfNull: false)
class LoginUserRequest {

  @JsonKey(name: 'client_id')
  final String clientId;

  @JsonKey(name: 'user_name')
  final String? login;

  @JsonKey(name: 'password')
  final String? password;

  @JsonKey(name: 'grant_type')
  final String grantType;

  @JsonKey(name: 'refresh_token')
  final String? refreshToken;

  const LoginUserRequest({
    required this.clientId,
    required this.login,
    required this.password,
    required this.grantType,
    this.refreshToken,
  });


  factory LoginUserRequest.fromJson(Map<String, dynamic> json) => _$LoginUserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginUserRequestToJson(this);
  
}
