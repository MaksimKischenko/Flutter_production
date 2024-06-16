import 'package:json_annotation/json_annotation.dart';

part 'change_password_request.g.dart';

@JsonSerializable()
class ChangePasswordRequest {

  @JsonKey(name: 'app_user')
  final String user;

  @JsonKey(name: 'pass')
  final String password;

  @JsonKey(name: 'pass_new')
  final String newPassword;

  ChangePasswordRequest({
    required this.user,
    required this.password,
    required this.newPassword,
  });

  factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) => _$ChangePasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePasswordRequestToJson(this);
  
}
