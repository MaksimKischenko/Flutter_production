// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_claim_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsTpODeleteClaimResponseWrapper _$PsTpODeleteClaimResponseWrapperFromJson(
        Map<String, dynamic> json) =>
    PsTpODeleteClaimResponseWrapper(
      PsTpODeleteClaimResponse.fromJson(
          json['PS_TP_O'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsTpODeleteClaimResponseWrapperToJson(
        PsTpODeleteClaimResponseWrapper instance) =>
    <String, dynamic>{
      'PS_TP_O': instance.psTpO,
    };

PsTpODeleteClaimResponse _$PsTpODeleteClaimResponseFromJson(
        Map<String, dynamic> json) =>
    PsTpODeleteClaimResponse(
      DeleteClaimResponse.fromJson(
          json['DeleteClaimResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsTpODeleteClaimResponseToJson(
        PsTpODeleteClaimResponse instance) =>
    <String, dynamic>{
      'DeleteClaimResponse': instance.response,
    };

DeleteClaimResponse _$DeleteClaimResponseFromJson(Map<String, dynamic> json) =>
    DeleteClaimResponse(
      version: json['Version'] as int,
      key: json['KeyRequest'] as int,
      errorCode: json['ErrorCode'] as int,
      errorText: json['ErrorText'] as String?,
    );

Map<String, dynamic> _$DeleteClaimResponseToJson(
        DeleteClaimResponse instance) =>
    <String, dynamic>{
      'Version': instance.version,
      'KeyRequest': instance.key,
      'ErrorCode': instance.errorCode,
      'ErrorText': instance.errorText,
    };
