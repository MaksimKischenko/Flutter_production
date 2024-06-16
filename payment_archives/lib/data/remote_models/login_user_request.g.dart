// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_user_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginUserRequest _$LoginUserRequestFromJson(Map<String, dynamic> json) =>
    LoginUserRequest(
      clientId: json['client_id'] as String,
      login: json['user_name'] as String?,
      password: json['password'] as String?,
      grantType: json['grant_type'] as String,
      refreshToken: json['refresh_token'] as String?,
    );

Map<String, dynamic> _$LoginUserRequestToJson(LoginUserRequest instance) {
  final val = <String, dynamic>{
    'client_id': instance.clientId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('user_name', instance.login);
  writeNotNull('password', instance.password);
  val['grant_type'] = instance.grantType;
  writeNotNull('refresh_token', instance.refreshToken);
  return val;
}
