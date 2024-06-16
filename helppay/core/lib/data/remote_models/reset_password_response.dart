import 'package:json_annotation/json_annotation.dart';

part 'reset_password_response.g.dart';

@JsonSerializable()
class MdomResetPasswordResponseWrapper {

  @JsonKey(name: 'UserResponse')
  final MdomResetPasswordResponse userResponse;

  MdomResetPasswordResponseWrapper(this.userResponse);

  factory MdomResetPasswordResponseWrapper.fromJson(Map<String, dynamic> json) => _$MdomResetPasswordResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$MdomResetPasswordResponseWrapperToJson(this);
  
}

@JsonSerializable()
class MdomResetPasswordResponse {

  @JsonKey(name: 'RequestType')
  final String requestType;

  @JsonKey(name: 'ErrorCode')
  final MdomResetPasswordErrorCode errorCode;

  @JsonKey(name: 'Token')
  final String? token;


  MdomResetPasswordResponse({
    required this.errorCode,
    this.requestType = 'ResetPassword',
    this.token,
  });


  factory MdomResetPasswordResponse.fromJson(Map<String, dynamic> json) => _$MdomResetPasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MdomResetPasswordResponseToJson(this);
  
}


@JsonSerializable()
class MdomResetPasswordErrorCode {
  @JsonKey(name: 'evalue')
  final int evalue;

  @JsonKey(name: '@ErrorText')
  final String? errorText;

  MdomResetPasswordErrorCode({
    required this.evalue,
    this.errorText,
  });


  factory MdomResetPasswordErrorCode.fromJson(Map<String, dynamic> json) =>
      _$MdomResetPasswordErrorCodeFromJson(json);

  Map<String, dynamic> toJson() => _$MdomResetPasswordErrorCodeToJson(this);
}
