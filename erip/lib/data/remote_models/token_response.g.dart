// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsTpOTokenResponseWrapper _$PsTpOTokenResponseWrapperFromJson(
        Map<String, dynamic> json) =>
    PsTpOTokenResponseWrapper(
      PsTpOTokenResponse.fromJson(json['PS_TP_O'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsTpOTokenResponseWrapperToJson(
        PsTpOTokenResponseWrapper instance) =>
    <String, dynamic>{
      'PS_TP_O': instance.psTpO,
    };

PsTpOTokenResponse _$PsTpOTokenResponseFromJson(Map<String, dynamic> json) =>
    PsTpOTokenResponse(
      TokenResponse.fromJson(json['TokenResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsTpOTokenResponseToJson(PsTpOTokenResponse instance) =>
    <String, dynamic>{
      'TokenResponse': instance.response,
    };

TokenResponse _$TokenResponseFromJson(Map<String, dynamic> json) =>
    TokenResponse(
      token: json['Token'] == null
          ? null
          : TokenResponseToken.fromJson(json['Token'] as Map<String, dynamic>),
      clientType: json['ClientType'] as String?,
      version: json['Version'] as int,
      key: json['KeyRequest'] as int,
      errorCode: json['ErrorCode'] as int,
      errorText: json['ErrorText'] as String?,
    );

Map<String, dynamic> _$TokenResponseToJson(TokenResponse instance) =>
    <String, dynamic>{
      'Token': instance.token,
      'ClientType': instance.clientType,
      'Version': instance.version,
      'KeyRequest': instance.key,
      'ErrorCode': instance.errorCode,
      'ErrorText': instance.errorText,
    };

TokenResponseToken _$TokenResponseTokenFromJson(Map<String, dynamic> json) =>
    TokenResponseToken(
      evalue: json['evalue'] as String,
      terminalId: json['@TerminalId'] as String,
    );

Map<String, dynamic> _$TokenResponseTokenToJson(TokenResponseToken instance) =>
    <String, dynamic>{
      'evalue': instance.evalue,
      '@TerminalId': instance.terminalId,
    };
