// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_token_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsTpODeleteTokenResponseWrapper _$PsTpODeleteTokenResponseWrapperFromJson(
        Map<String, dynamic> json) =>
    PsTpODeleteTokenResponseWrapper(
      PsTpODeleteTokenResponse.fromJson(
          json['PS_TP_O'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsTpODeleteTokenResponseWrapperToJson(
        PsTpODeleteTokenResponseWrapper instance) =>
    <String, dynamic>{
      'PS_TP_O': instance.psTpO,
    };

PsTpODeleteTokenResponse _$PsTpODeleteTokenResponseFromJson(
        Map<String, dynamic> json) =>
    PsTpODeleteTokenResponse(
      DeleteTokenResponse.fromJson(
          json['DeleteTokenResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsTpODeleteTokenResponseToJson(
        PsTpODeleteTokenResponse instance) =>
    <String, dynamic>{
      'DeleteTokenResponse': instance.response,
    };

DeleteTokenResponse _$DeleteTokenResponseFromJson(Map<String, dynamic> json) =>
    DeleteTokenResponse(
      version: json['Version'] as int,
      key: json['KeyRequest'] as int,
      errorCode: json['ErrorCode'] as int,
      errorText: json['ErrorText'] as String?,
    );

Map<String, dynamic> _$DeleteTokenResponseToJson(
        DeleteTokenResponse instance) =>
    <String, dynamic>{
      'Version': instance.version,
      'KeyRequest': instance.key,
      'ErrorCode': instance.errorCode,
      'ErrorText': instance.errorText,
    };
