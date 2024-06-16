// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payments_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsTpOPaymentsListResponseWrapper _$PsTpOPaymentsListResponseWrapperFromJson(
        Map<String, dynamic> json) =>
    PsTpOPaymentsListResponseWrapper(
      PsTpOPaymentsListResponse.fromJson(
          json['PS_TP_O'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsTpOPaymentsListResponseWrapperToJson(
        PsTpOPaymentsListResponseWrapper instance) =>
    <String, dynamic>{
      'PS_TP_O': instance.psTpO,
    };

PsTpOPaymentsListResponse _$PsTpOPaymentsListResponseFromJson(
        Map<String, dynamic> json) =>
    PsTpOPaymentsListResponse(
      PaymentsListResponse.fromJson(
          json['PaymentsListResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsTpOPaymentsListResponseToJson(
        PsTpOPaymentsListResponse instance) =>
    <String, dynamic>{
      'PaymentsListResponse': instance.response,
    };

PaymentsListResponse _$PaymentsListResponseFromJson(
        Map<String, dynamic> json) =>
    PaymentsListResponse(
      version: json['Version'] as int,
      key: json['KeyRequest'] as int,
      rowNum: json['RowNum'] as int?,
      payments: (json['Payment'] as List<dynamic>?)
          ?.map((e) => PaymentISC.fromJson(e as Map<String, dynamic>))
          .toList(),
      errorCode: json['ErrorCode'] as int,
      errorText: json['ErrorText'] as String?,
    );

Map<String, dynamic> _$PaymentsListResponseToJson(
        PaymentsListResponse instance) =>
    <String, dynamic>{
      'Version': instance.version,
      'KeyRequest': instance.key,
      'RowNum': instance.rowNum,
      'Payment': instance.payments,
      'ErrorCode': instance.errorCode,
      'ErrorText': instance.errorText,
    };

PaymentISC _$PaymentISCFromJson(Map<String, dynamic> json) => PaymentISC(
      id: json['PaymentId'] as int,
      claimId: json['ClaimId'] as int?,
      accNum: json['AccNum'] as String?,
      fio: json['FIO'] as String?,
      address: json['Address'] as String?,
      paymentDate: json['PaymentDate'] as String,
      paymentSum: (json['PaymentSum'] as num).toDouble(),
      productCharacter: json['ProductCharacter'] as String?,
      bankCode: json['BankCode'] as String?,
      account: json['Account'] as String?,
      memDate: json['MemDate'] as String,
      memNumber: json['MemNumber'] as String,
      status: $enumDecode(_$PaymentStatusEnumMap, json['PaymentStatus']),
    );

Map<String, dynamic> _$PaymentISCToJson(PaymentISC instance) =>
    <String, dynamic>{
      'PaymentId': instance.id,
      'ClaimId': instance.claimId,
      'AccNum': instance.accNum,
      'FIO': instance.fio,
      'Address': instance.address,
      'PaymentDate': instance.paymentDate,
      'PaymentSum': instance.paymentSum,
      'ProductCharacter': instance.productCharacter,
      'BankCode': instance.bankCode,
      'Account': instance.account,
      'MemDate': instance.memDate,
      'MemNumber': instance.memNumber,
      'PaymentStatus': _$PaymentStatusEnumMap[instance.status]!,
    };

const _$PaymentStatusEnumMap = {
  PaymentStatus.all: 0,
  PaymentStatus.registered: 1,
  PaymentStatus.paid: 2,
  PaymentStatus.successfullyReversed: -1,
  PaymentStatus.reversalStarted: -2,
  PaymentStatus.registrationStarted: -3,
  PaymentStatus.registrationCanceled: -4,
};
