// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_qr_check_duplicate_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsHelpPayGetQRCheckDuplicateResponseWrapper
    _$PsHelpPayGetQRCheckDuplicateResponseWrapperFromJson(
            Map<String, dynamic> json) =>
        PsHelpPayGetQRCheckDuplicateResponseWrapper(
          PsHelpPayQRCheckDuplicateResponse.fromJson(
              json['PS_HELPPAY'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$PsHelpPayGetQRCheckDuplicateResponseWrapperToJson(
        PsHelpPayGetQRCheckDuplicateResponseWrapper instance) =>
    <String, dynamic>{
      'PS_HELPPAY': instance.psErip,
    };

PsHelpPayQRCheckDuplicateResponse _$PsHelpPayQRCheckDuplicateResponseFromJson(
        Map<String, dynamic> json) =>
    PsHelpPayQRCheckDuplicateResponse(
      GetQRCheckDuplicateResponse.fromJson(
          json['GetQRCheckDuplicateResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsHelpPayQRCheckDuplicateResponseToJson(
        PsHelpPayQRCheckDuplicateResponse instance) =>
    <String, dynamic>{
      'GetQRCheckDuplicateResponse': instance.response,
    };

GetQRCheckDuplicateResponse _$GetQRCheckDuplicateResponseFromJson(
        Map<String, dynamic> json) =>
    GetQRCheckDuplicateResponse(
      errorCode: json['ErrorCode'] as int,
      errorText: json['ErrorText'] as String?,
      terminalId: json['TerminalID'] as String?,
      dateOfPayment: json['PayDate'] as String?,
      paymentSum: (json['PaySumma'] as num?)?.toDouble(),
      receiptNumber: json['KioskReceipt'] as String?,
      receipt: json['Check'] == null
          ? null
          : Receipt.fromJson(json['Check'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetQRCheckDuplicateResponseToJson(
        GetQRCheckDuplicateResponse instance) =>
    <String, dynamic>{
      'ErrorCode': instance.errorCode,
      'ErrorText': instance.errorText,
      'TerminalID': instance.terminalId,
      'PayDate': instance.dateOfPayment,
      'PaySumma': instance.paymentSum,
      'KioskReceipt': instance.receiptNumber,
      'Check': instance.receipt,
    };

Receipt _$ReceiptFromJson(Map<String, dynamic> json) => Receipt(
      numberOfLines: json['Count'] as int,
      checkLine: (json['CheckLine'] as List<dynamic>)
          .map((e) => CheckLine.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReceiptToJson(Receipt instance) => <String, dynamic>{
      'Count': instance.numberOfLines,
      'CheckLine': instance.checkLine,
    };

CheckLine _$CheckLineFromJson(Map<String, dynamic> json) => CheckLine(
      lineIndex: json['Idx'] as int,
      lineValue: json['Value'] as String?,
    );

Map<String, dynamic> _$CheckLineToJson(CheckLine instance) => <String, dynamic>{
      'Idx': instance.lineIndex,
      'Value': instance.lineValue,
    };
