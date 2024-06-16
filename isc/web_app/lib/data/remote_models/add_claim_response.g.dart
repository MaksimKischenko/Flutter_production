// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_claim_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsTpOAddClaimResponseWrapper _$PsTpOAddClaimResponseWrapperFromJson(
        Map<String, dynamic> json) =>
    PsTpOAddClaimResponseWrapper(
      PsTpOAddClaimResponse.fromJson(json['PS_TP_O'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsTpOAddClaimResponseWrapperToJson(
        PsTpOAddClaimResponseWrapper instance) =>
    <String, dynamic>{
      'PS_TP_O': instance.psTpO,
    };

PsTpOAddClaimResponse _$PsTpOAddClaimResponseFromJson(
        Map<String, dynamic> json) =>
    PsTpOAddClaimResponse(
      AddClaimResponse.fromJson(
          json['AddClaimResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsTpOAddClaimResponseToJson(
        PsTpOAddClaimResponse instance) =>
    <String, dynamic>{
      'AddClaimResponse': instance.response,
    };

AddClaimResponse _$AddClaimResponseFromJson(Map<String, dynamic> json) =>
    AddClaimResponse(
      invoiceDate: json['InvoiceDate'] as String,
      claimId: json['ClaimId'] as int,
      version: json['Version'] as int,
      key: json['KeyRequest'] as int,
      errorCode: json['ErrorCode'] as int,
      errorText: json['ErrorText'] as String?,
    );

Map<String, dynamic> _$AddClaimResponseToJson(AddClaimResponse instance) =>
    <String, dynamic>{
      'Version': instance.version,
      'KeyRequest': instance.key,
      'InvoiceDate': instance.invoiceDate,
      'ClaimId': instance.claimId,
      'ErrorCode': instance.errorCode,
      'ErrorText': instance.errorText,
    };
