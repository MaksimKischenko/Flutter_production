// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claims_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsTpOClaimsListResponseWrapper _$PsTpOClaimsListResponseWrapperFromJson(
        Map<String, dynamic> json) =>
    PsTpOClaimsListResponseWrapper(
      PsTpOClaimsListResponse.fromJson(json['PS_TP_O'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsTpOClaimsListResponseWrapperToJson(
        PsTpOClaimsListResponseWrapper instance) =>
    <String, dynamic>{
      'PS_TP_O': instance.psTpO,
    };

PsTpOClaimsListResponse _$PsTpOClaimsListResponseFromJson(
        Map<String, dynamic> json) =>
    PsTpOClaimsListResponse(
      ClaimsListResponse.fromJson(
          json['ClaimsListResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsTpOClaimsListResponseToJson(
        PsTpOClaimsListResponse instance) =>
    <String, dynamic>{
      'ClaimsListResponse': instance.response,
    };

ClaimsListResponse _$ClaimsListResponseFromJson(Map<String, dynamic> json) =>
    ClaimsListResponse(
      claims: (json['Claim'] as List<dynamic>?)
          ?.map((e) => Claim.fromJson(e as Map<String, dynamic>))
          .toList(),
      version: json['Version'] as int,
      key: json['KeyRequest'] as int,
      errorCode: json['ErrorCode'] as int,
      errorText: json['ErrorText'] as String?,
    );

Map<String, dynamic> _$ClaimsListResponseToJson(ClaimsListResponse instance) =>
    <String, dynamic>{
      'Version': instance.version,
      'KeyRequest': instance.key,
      'Claim': instance.claims,
      'ErrorCode': instance.errorCode,
      'ErrorText': instance.errorText,
    };

Claim _$ClaimFromJson(Map<String, dynamic> json) => Claim(
      id: json['ClaimId'] as int,
      accNum: json['AccNum'] as String,
      invoiceDate: json['InvoiceDate'] as String,
      dueDate: json['DueDate'] as String,
      status: $enumDecode(_$ClaimStatusEnumMap, json['Status']),
      fio: json['FIO'] as String?,
      productCharacter: json['ProductCharacter'] as String?,
      sum: (json['Sum'] as num).toDouble(),
      paymentSum: (json['PaymentSum'] as num).toDouble(),
      qrCode: json['QRCode'] as String,
    );

Map<String, dynamic> _$ClaimToJson(Claim instance) => <String, dynamic>{
      'ClaimId': instance.id,
      'AccNum': instance.accNum,
      'InvoiceDate': instance.invoiceDate,
      'DueDate': instance.dueDate,
      'Status': _$ClaimStatusEnumMap[instance.status]!,
      'FIO': instance.fio,
      'ProductCharacter': instance.productCharacter,
      'Sum': instance.sum,
      'PaymentSum': instance.paymentSum,
      'QRCode': instance.qrCode,
    };

const _$ClaimStatusEnumMap = {
  ClaimStatus.all: 0,
  ClaimStatus.unpaid: 1,
  ClaimStatus.fullyPaid: 2,
  ClaimStatus.partiallyPaid: 3,
  ClaimStatus.overdue: 4,
};
