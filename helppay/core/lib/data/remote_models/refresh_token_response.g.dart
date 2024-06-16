// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_token_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MdomRefreshTokenResponseWrapper _$MdomRefreshTokenResponseWrapperFromJson(
        Map<String, dynamic> json) =>
    MdomRefreshTokenResponseWrapper(
      MdomRefreshTokenResponse.fromJson(
          json['UserRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomRefreshTokenResponseWrapperToJson(
        MdomRefreshTokenResponseWrapper instance) =>
    <String, dynamic>{
      'UserRequest': instance.response,
    };

MdomRefreshTokenResponse _$MdomRefreshTokenResponseFromJson(
        Map<String, dynamic> json) =>
    MdomRefreshTokenResponse(
      version: json['Version'] as int?,
      keyRequest: json['KeyRequest'] as int?,
      errorText: json['ErrorText'] as String?,
      errorCode: json['ErrorCode'] == null
          ? null
          : MdomErrorCode.fromJson(json['ErrorCode'] as Map<String, dynamic>),
      token: MdomToken.fromJson(json['Token'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomRefreshTokenResponseToJson(
        MdomRefreshTokenResponse instance) =>
    <String, dynamic>{
      'Version': instance.version,
      'KeyRequest': instance.keyRequest,
      'ErrorCode': instance.errorCode,
      'ErrorText': instance.errorText,
      'Token': instance.token,
    };
