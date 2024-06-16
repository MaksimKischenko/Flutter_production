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
      terminalId: json['TerminalID'] as String,
      version: json['Version'] as int,
      pan: json['PAN'] == null
          ? null
          : PAN.fromJson(json['PAN'] as Map<String, dynamic>),
      typePan: json['TypePAN'] == null
          ? null
          : TypePAN.fromJson(json['TypePAN'] as Map<String, dynamic>),
      payRecord: (json['PayRecord'] as List<dynamic>?)
          ?.map((e) =>
              ConfirmRequestPayRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ConfirmRequestToJson(ConfirmRequest instance) =>
    <String, dynamic>{
      'TerminalID': instance.terminalId,
      'Version': instance.version,
      'PAN': instance.pan,
      'TypePAN': instance.typePan,
      'PayRecord': instance.payRecord,
    };

ConfirmRequestPayRecord _$ConfirmRequestPayRecordFromJson(
        Map<String, dynamic> json) =>
    ConfirmRequestPayRecord(
      paymentID: json['@PaymentID'] as int?,
      date: json['@Date'] as String?,
      kioskReceipt: json['@KioskReceipt'] as String?,
      recordId: json['@RecordID'] as int?,
      confirmCode: json['@ConfirmCode'] as int,
      cancelReason: json['@CancelReason'] as String?,
    );

Map<String, dynamic> _$ConfirmRequestPayRecordToJson(
        ConfirmRequestPayRecord instance) =>
    <String, dynamic>{
      '@PaymentID': instance.paymentID,
      '@Date': instance.date,
      '@KioskReceipt': instance.kioskReceipt,
      '@RecordID': instance.recordId,
      '@ConfirmCode': instance.confirmCode,
      '@CancelReason': instance.cancelReason,
    };
