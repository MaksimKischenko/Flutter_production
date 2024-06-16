// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_statement_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MdomAccountStatementResponseWrapper
    _$MdomAccountStatementResponseWrapperFromJson(Map<String, dynamic> json) =>
        MdomAccountStatementResponseWrapper(
          MdomAccountStatementResponse.fromJson(
              json['TPInfoResponse'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$MdomAccountStatementResponseWrapperToJson(
        MdomAccountStatementResponseWrapper instance) =>
    <String, dynamic>{
      'TPInfoResponse': instance.response,
    };

MdomAccountStatementResponse _$MdomAccountStatementResponseFromJson(
        Map<String, dynamic> json) =>
    MdomAccountStatementResponse(
      requestType: json['RequestType'] as String?,
      errorCode: json['ErrorCode'] == null
          ? null
          : MdomTpInfoErrorCode.fromJson(
              json['ErrorCode'] as Map<String, dynamic>),
      token: json['Token'] as String,
      params: json['Params'] == null
          ? null
          : MdomTpInfoResponseParams.fromJson(
              json['Params'] as Map<String, dynamic>),
      lookups: json['Lookups'] == null
          ? null
          : MdomTpInfoLookups.fromJson(json['Lookups'] as Map<String, dynamic>),
      periods: (json['PeriodInfo'] as List<dynamic>?)
          ?.map(
              (e) => AccountStatementPeriod.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MdomAccountStatementResponseToJson(
        MdomAccountStatementResponse instance) =>
    <String, dynamic>{
      'RequestType': instance.requestType,
      'ErrorCode': instance.errorCode,
      'Token': instance.token,
      'Params': instance.params,
      'Lookups': instance.lookups,
      'PeriodInfo': instance.periods,
    };

AccountStatementPeriod _$AccountStatementPeriodFromJson(
        Map<String, dynamic> json) =>
    AccountStatementPeriod(
      value: json['@Period'] as String,
      servicesWrapper: json['Services'] == null
          ? null
          : ServicesWrapper.fromJson(json['Services'] as Map<String, dynamic>),
      paymentsWrapper: json['Payments'] == null
          ? null
          : PaymentsWrapper.fromJson(json['Payments'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AccountStatementPeriodToJson(
        AccountStatementPeriod instance) =>
    <String, dynamic>{
      '@Period': instance.value,
      'Services': instance.servicesWrapper,
      'Payments': instance.paymentsWrapper,
    };

ServicesWrapper _$ServicesWrapperFromJson(Map<String, dynamic> json) =>
    ServicesWrapper(
      services: (json['Service'] as List<dynamic>?)
          ?.map((e) => MdomService.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ServicesWrapperToJson(ServicesWrapper instance) =>
    <String, dynamic>{
      'Service': instance.services,
    };

MdomService _$MdomServiceFromJson(Map<String, dynamic> json) => MdomService(
      id: json['@ID'] as int?,
      name: json['@Name'] as String,
      unit: json['@Unit'] as String?,
      claimId: json['@ClaimId'] as int?,
      dateBegin: json['@DateBegin'] as String?,
      dateEnd: json['@DateEnd'] as String?,
      payAmount: (json['@PayAmount'] as num?)?.toDouble(),
      volume: (json['@Volume'] as num?)?.toDouble(),
      tariff: (json['@Tariff'] as num?)?.toDouble(),
      balance: (json['@Balance'] as num?)?.toDouble(),
      accrued: (json['@Accrued'] as num).toDouble(),
      benefit: (json['@Benefit'] as num?)?.toDouble(),
      recalculated: (json['@Recalculated'] as num?)?.toDouble(),
      fine: (json['@Fine'] as num?)?.toDouble(),
      total: (json['@Total'] as num).toDouble(),
    );

Map<String, dynamic> _$MdomServiceToJson(MdomService instance) =>
    <String, dynamic>{
      '@ID': instance.id,
      '@Name': instance.name,
      '@Unit': instance.unit,
      '@ClaimId': instance.claimId,
      '@DateBegin': instance.dateBegin,
      '@DateEnd': instance.dateEnd,
      '@PayAmount': instance.payAmount,
      '@Volume': instance.volume,
      '@Tariff': instance.tariff,
      '@Balance': instance.balance,
      '@Accrued': instance.accrued,
      '@Benefit': instance.benefit,
      '@Recalculated': instance.recalculated,
      '@Fine': instance.fine,
      '@Total': instance.total,
    };

PaymentsWrapper _$PaymentsWrapperFromJson(Map<String, dynamic> json) =>
    PaymentsWrapper(
      payments: (json['Payment'] as List<dynamic>?)
          ?.map((e) => PaymentBilling.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PaymentsWrapperToJson(PaymentsWrapper instance) =>
    <String, dynamic>{
      'Payment': instance.payments,
    };

PaymentBilling _$PaymentBillingFromJson(Map<String, dynamic> json) =>
    PaymentBilling(
      id: json['@PaymentId'] as String,
      datePay: json['@DatePay'] as String,
      claimId: json['@ClaimId'] as int?,
      infoPay: json['@InfoPay'] as String?,
      amount: (json['@Amount'] as num).toDouble(),
      fineAmount: (json['@FineAmount'] as num).toDouble(),
      serviceAmount: (json['@ServiceAmount'] as num).toDouble(),
    );

Map<String, dynamic> _$PaymentBillingToJson(PaymentBilling instance) =>
    <String, dynamic>{
      '@PaymentId': instance.id,
      '@DatePay': instance.datePay,
      '@ClaimId': instance.claimId,
      '@InfoPay': instance.infoPay,
      '@Amount': instance.amount,
      '@FineAmount': instance.fineAmount,
      '@ServiceAmount': instance.serviceAmount,
    };
