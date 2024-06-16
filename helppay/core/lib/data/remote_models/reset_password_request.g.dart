// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MdomResetPasswordRequestWrapper _$MdomResetPasswordRequestWrapperFromJson(
        Map<String, dynamic> json) =>
    MdomResetPasswordRequestWrapper(
      MdomResetPasswordRequest.fromJson(
          json['UserRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomResetPasswordRequestWrapperToJson(
        MdomResetPasswordRequestWrapper instance) =>
    <String, dynamic>{
      'UserRequest': instance.userRequest,
    };

MdomResetPasswordRequest _$MdomResetPasswordRequestFromJson(
        Map<String, dynamic> json) =>
    MdomResetPasswordRequest(
      requestType: json['RequestType'] as String? ?? 'ResetPassword',
      login: json['Login'] == null
          ? null
          : MdomResetPasswordLogin.fromJson(
              json['Login'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomResetPasswordRequestToJson(
    MdomResetPasswordRequest instance) {
  final val = <String, dynamic>{
    'RequestType': instance.requestType,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Login', instance.login);
  return val;
}

MdomResetPasswordLogin _$MdomResetPasswordLoginFromJson(
        Map<String, dynamic> json) =>
    MdomResetPasswordLogin(
      login: json['evalue'] as String?,
      email: json['@EMail'] as String?,
      phone: json['@PhoneNumber'] as String?,
    );

Map<String, dynamic> _$MdomResetPasswordLoginToJson(
        MdomResetPasswordLogin instance) =>
    <String, dynamic>{
      'evalue': instance.login,
      '@EMail': instance.email,
      '@PhoneNumber': instance.phone,
    };
