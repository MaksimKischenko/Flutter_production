// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_token_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MdomRefreshTokenRequestWrapper _$MdomRefreshTokenRequestWrapperFromJson(
        Map<String, dynamic> json) =>
    MdomRefreshTokenRequestWrapper(
      MdomRefreshTokenRequest.fromJson(
          json['UserRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomRefreshTokenRequestWrapperToJson(
        MdomRefreshTokenRequestWrapper instance) =>
    <String, dynamic>{
      'UserRequest': instance.request,
    };

MdomRefreshTokenRequest _$MdomRefreshTokenRequestFromJson(
        Map<String, dynamic> json) =>
    MdomRefreshTokenRequest(
      terminalId: json['TerminalId'] as String,
      version: json['Version'] as String,
      token: json['Token'] as String,
      lang: json['Lang'] as String?,
      requestType: json['RequestType'] as String? ?? 'RefreshToken',
    );

Map<String, dynamic> _$MdomRefreshTokenRequestToJson(
    MdomRefreshTokenRequest instance) {
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
  return val;
}
