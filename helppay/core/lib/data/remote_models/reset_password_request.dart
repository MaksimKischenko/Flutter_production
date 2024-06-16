import 'package:json_annotation/json_annotation.dart';

part 'reset_password_request.g.dart';

@JsonSerializable()
class MdomResetPasswordRequestWrapper {
  @JsonKey(name: 'UserRequest')
  final MdomResetPasswordRequest userRequest;

  MdomResetPasswordRequestWrapper(this.userRequest);

  factory MdomResetPasswordRequestWrapper.fromJson(Map<String, dynamic> json) =>
      _$MdomResetPasswordRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() =>
      _$MdomResetPasswordRequestWrapperToJson(this);
}

@JsonSerializable(includeIfNull: false)
class MdomResetPasswordRequest {
  @JsonKey(name: 'RequestType')
  final String requestType;

  @JsonKey(name: 'Login')
  final MdomResetPasswordLogin? login;

  MdomResetPasswordRequest({this.requestType = 'ResetPassword', this.login});

  factory MdomResetPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$MdomResetPasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MdomResetPasswordRequestToJson(this);
}

@JsonSerializable()
class MdomResetPasswordLogin {
  @JsonKey(name: 'evalue')
  final String? login;

  @JsonKey(name: '@EMail')
  final String? email;

  @JsonKey(name: '@PhoneNumber')
  final String? phone;

  MdomResetPasswordLogin({
    required this.login,
    required this.email,
    required this.phone,
  });

  factory MdomResetPasswordLogin.fromJson(Map<String, dynamic> json) =>
      _$MdomResetPasswordLoginFromJson(json);

  Map<String, dynamic> toJson() => _$MdomResetPasswordLoginToJson(this);
}
