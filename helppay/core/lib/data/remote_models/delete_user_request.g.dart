// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_user_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MdomDeleteUserRequestWrapper _$MdomDeleteUserRequestWrapperFromJson(
        Map<String, dynamic> json) =>
    MdomDeleteUserRequestWrapper(
      MdomDeleteUserRequest.fromJson(
          json['UserRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomDeleteUserRequestWrapperToJson(
        MdomDeleteUserRequestWrapper instance) =>
    <String, dynamic>{
      'UserRequest': instance.userRequest,
    };

MdomDeleteUserRequest _$MdomDeleteUserRequestFromJson(
        Map<String, dynamic> json) =>
    MdomDeleteUserRequest(
      requestType: json['RequestType'] as String? ?? 'DeleteUser',
      terminalId: json['TerminalId'] as String,
      version: json['Version'] as String,
      token: json['Token'] as String,
      lang: json['Lang'] as String?,
      userId: json['UserId'] as int?,
      login: json['Login'] as String?,
    );

Map<String, dynamic> _$MdomDeleteUserRequestToJson(
    MdomDeleteUserRequest instance) {
  final val = <String, dynamic>{
    'RequestType': instance.requestType,
    'TerminalId': instance.terminalId,
    'Version': instance.version,
    'Token': instance.token,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Lang', instance.lang);
  writeNotNull('Login', instance.login);
  writeNotNull('UserId', instance.userId);
  return val;
}
