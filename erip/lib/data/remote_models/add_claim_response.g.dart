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
      claimId: AddClaimResponseClaimId.fromJson(
          json['ClaimId'] as Map<String, dynamic>),
      version: json['Version'] as int,
      key: json['KeyRequest'] as int,
      errorCode: json['ErrorCode'] as int,
      errorText: json['ErrorText'] as String?,
    );

Map<String, dynamic> _$AddClaimResponseToJson(AddClaimResponse instance) =>
    <String, dynamic>{
      'InvoiceDate': instance.invoiceDate,
      'ClaimId': instance.claimId,
      'Version': instance.version,
      'KeyRequest': instance.key,
      'ErrorCode': instance.errorCode,
      'ErrorText': instance.errorText,
    };

AddClaimResponseClaimId _$AddClaimResponseClaimIdFromJson(
        Map<String, dynamic> json) =>
    AddClaimResponseClaimId(
      evalue: json['evalue'] as int,
      accNum: json['@AccNum'] as String?,
      qrCode: json['@QRCode'] as String?,
    );

Map<String, dynamic> _$AddClaimResponseClaimIdToJson(
        AddClaimResponseClaimId instance) =>
    <String, dynamic>{
      'evalue': instance.evalue,
      '@AccNum': instance.accNum,
      '@QRCode': instance.qrCode,
    };
