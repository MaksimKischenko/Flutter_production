// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsTpOTokenRequestWrapper _$PsTpOTokenRequestWrapperFromJson(
        Map<String, dynamic> json) =>
    PsTpOTokenRequestWrapper(
      PsTpOTokenRequest.fromJson(json['PS_TP_O'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsTpOTokenRequestWrapperToJson(
        PsTpOTokenRequestWrapper instance) =>
    <String, dynamic>{
      'PS_TP_O': instance.psTpO,
    };

PsTpOTokenRequest _$PsTpOTokenRequestFromJson(Map<String, dynamic> json) =>
    PsTpOTokenRequest(
      TokenRequest.fromJson(json['TokenRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsTpOTokenRequestToJson(PsTpOTokenRequest instance) =>
    <String, dynamic>{
      'TokenRequest': instance.request,
    };

TokenRequest _$TokenRequestFromJson(Map<String, dynamic> json) => TokenRequest(
      login: TokenRequestLoginName.fromJson(
          json['LoginName'] as Map<String, dynamic>),
      password: json['Password'] as String,
      version: json['Version'] as int,
      key: json['KeyRequest'] as int,
    );

Map<String, dynamic> _$TokenRequestToJson(TokenRequest instance) =>
    <String, dynamic>{
      'LoginName': instance.login,
      'Password': instance.password,
      'Version': instance.version,
      'KeyRequest': instance.key,
    };

TokenRequestLoginName _$TokenRequestLoginNameFromJson(
        Map<String, dynamic> json) =>
    TokenRequestLoginName(
      evalue: json['evalue'] as String,
      deviceType: json['@DeviceType'] as String,
    );

Map<String, dynamic> _$TokenRequestLoginNameToJson(
        TokenRequestLoginName instance) =>
    <String, dynamic>{
      'evalue': instance.evalue,
      '@DeviceType': instance.deviceType,
    };
