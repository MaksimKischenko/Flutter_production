// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsEripConfirmRequestWrapper _$PsEripConfirmRequestWrapperFromJson(
        Map<String, dynamic> json) =>
    PsEripConfirmRequestWrapper(
      PsEripConfirmRequest.fromJson(json['PS_ERIP'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsEripConfirmRequestWrapperToJson(
        PsEripConfirmRequestWrapper instance) =>
    <String, dynamic>{
      'PS_ERIP': instance.psErip,
    };

PsEripConfirmRequest _$PsEripConfirmRequestFromJson(
        Map<String, dynamic> json) =>
    PsEripConfirmRequest(
      ConfirmRequest.fromJson(json['ConfirmRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsEripConfirmRequestToJson(
        PsEripConfirmRequest instance) =>
    <String, dynamic>{
      'ConfirmRequest': instance.request,
    };

ConfirmRequest _$ConfirmRequestFromJson(Map<String, dynamic> json) =>
    ConfirmRequest(
      terminalID: json['TerminalID'] as String,
      version: json['Version'] as int,
      diType: json['DIType'] as int,
      payRecord: ConfirmRequestPayRecord.fromJson(
          json['PayRecord'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ConfirmRequestToJson(ConfirmRequest instance) =>
    <String, dynamic>{
      'TerminalID': instance.terminalID,
      'DIType': instance.diType,
      'Version': instance.version,
      'PayRecord': instance.payRecord,
    };

ConfirmRequestPayRecord _$ConfirmRequestPayRecordFromJson(
        Map<String, dynamic> json) =>
    ConfirmRequestPayRecord(
      paymentID: json['@PaymentID'] as int,
      date: json['@Date'] as String,
      recordID: json['@RecordID'] as int,
      confirmCode: json['@ConfirmCode'] as int,
      cancelReason: json['@CancelReason'] as String?,
    );

Map<String, dynamic> _$ConfirmRequestPayRecordToJson(
        ConfirmRequestPayRecord instance) =>
    <String, dynamic>{
      '@PaymentID': instance.paymentID,
      '@Date': instance.date,
      '@RecordID': instance.recordID,
      '@ConfirmCode': instance.confirmCode,
      '@CancelReason': instance.cancelReason,
    };
