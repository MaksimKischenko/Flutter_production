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
      payments: (json['Payment'] as List<dynamic>?)
          ?.map((e) => Payment.fromJson(e as Map<String, dynamic>))
          .toList(),
      version: json['Version'] as int,
      key: json['KeyRequest'] as int,
      errorCode: json['ErrorCode'] as int,
      errorText: json['ErrorText'] as String?,
    );

Map<String, dynamic> _$PaymentsListResponseToJson(
        PaymentsListResponse instance) =>
    <String, dynamic>{
      'Payment': instance.payments,
      'Version': instance.version,
      'KeyRequest': instance.key,
      'ErrorCode': instance.errorCode,
      'ErrorText': instance.errorText,
    };

Payment _$PaymentFromJson(Map<String, dynamic> json) => Payment(
      id: json['PaymentId'] as int,
      claimId: json['ClaimId'] as int?,
      accNum: json['AccNum'] as String,
      fio: json['FIO'] as String?,
      address: json['Address'] == null
          ? null
          : Address.fromJson(json['Address'] as Map<String, dynamic>),
      paymentDate: json['PaymentDate'] as String,
      device: json['Device'] == null
          ? null
          : Devices.fromJson(json['Device'] as Map<String, dynamic>),
      paymentSum: (json['PaymentSum'] as num).toDouble(),
      transferSum: (json['TransferSum'] as num?)?.toDouble(),
      commissionSum: (json['CommissionSum'] as num?)?.toDouble(),
      productCharacter: json['ProductCharacter'] as String?,
      providerOperId: json['ProviderOperId'] as int?,
      paymentStatus: json['PaymentStatus'] as int,
      memDate: json['MemDate'] as String,
      memNumber: json['MemNumber'] as String,
      bankCode: json['BankCode'] as String?,
      authorizationType: json['AuthorizationType'] as String,
    );

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
      'PaymentId': instance.id,
      'ClaimId': instance.claimId,
      'AccNum': instance.accNum,
      'FIO': instance.fio,
      'Address': instance.address,
      'PaymentDate': instance.paymentDate,
      'Device': instance.device,
      'PaymentSum': instance.paymentSum,
      'TransferSum': instance.transferSum,
      'CommissionSum': instance.commissionSum,
      'ProductCharacter': instance.productCharacter,
      'ProviderOperId': instance.providerOperId,
      'PaymentStatus': instance.paymentStatus,
      'MemDate': instance.memDate,
      'MemNumber': instance.memNumber,
      'BankCode': instance.bankCode,
      'AuthorizationType': instance.authorizationType,
    };
