// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_qr_operations_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsHelpPayQROperationResponseWrapper
    _$PsHelpPayQROperationResponseWrapperFromJson(Map<String, dynamic> json) =>
        PsHelpPayQROperationResponseWrapper(
          PsHelpPayQROperationResponse.fromJson(
              json['PS_HELPPAY'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$PsHelpPayQROperationResponseWrapperToJson(
        PsHelpPayQROperationResponseWrapper instance) =>
    <String, dynamic>{
      'PS_HELPPAY': instance.psErip,
    };

PsHelpPayQROperationResponse _$PsHelpPayQROperationResponseFromJson(
        Map<String, dynamic> json) =>
    PsHelpPayQROperationResponse(
      GetQROperationResponse.fromJson(
          json['GetQROperationResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsHelpPayQROperationResponseToJson(
        PsHelpPayQROperationResponse instance) =>
    <String, dynamic>{
      'GetQROperationResponse': instance.response,
    };

GetQROperationResponse _$GetQROperationResponseFromJson(
        Map<String, dynamic> json) =>
    GetQROperationResponse(
      errorCode: json['ErrorCode'] as int,
      errorText: json['ErrorText'] as String?,
      paymentList: TransactiontList.fromJson(
          json['PaymentList'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetQROperationResponseToJson(
        GetQROperationResponse instance) =>
    <String, dynamic>{
      'ErrorCode': instance.errorCode,
      'ErrorText': instance.errorText,
      'PaymentList': instance.paymentList,
    };

TransactiontList _$TransactiontListFromJson(Map<String, dynamic> json) =>
    TransactiontList(
      operationsCount: json['Count'] as int,
      qrTransaction: (json['Payment'] as List<dynamic>?)
          ?.map((e) => QRTransaction.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TransactiontListToJson(TransactiontList instance) =>
    <String, dynamic>{
      'Count': instance.operationsCount,
      'Payment': instance.qrTransaction,
    };

QRTransaction _$QRTransactionFromJson(Map<String, dynamic> json) =>
    QRTransaction(
      paymentId: json['PaymentID'] as int?,
      status: json['StatusCode'] as int,
      requestId: json['RequestId'] as int,
      transactionDate: json['DateTime'] as String,
      transactionStatus: json['ResultDescription'] as String,
      transactionInfo: json['Note'] as String?,
      amount: Amount.fromJson(json['Amount'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$QRTransactionToJson(QRTransaction instance) =>
    <String, dynamic>{
      'PaymentID': instance.paymentId,
      'RequestId': instance.requestId,
      'DateTime': instance.transactionDate,
      'ResultDescription': instance.transactionStatus,
      'StatusCode': instance.status,
      'Note': instance.transactionInfo,
      'Amount': instance.amount,
    };

Amount _$AmountFromJson(Map<String, dynamic> json) => Amount(
      currency: json['Currency'] as int,
      value: json['Value'] as num,
    );

Map<String, dynamic> _$AmountToJson(Amount instance) => <String, dynamic>{
      'Currency': instance.currency,
      'Value': instance.value,
    };
