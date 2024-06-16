// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsEripConfirmResponseWrapper _$PsEripConfirmResponseWrapperFromJson(
        Map<String, dynamic> json) =>
    PsEripConfirmResponseWrapper(
      PsEripConfirmResponse.fromJson(json['PS_ERIP'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsEripConfirmResponseWrapperToJson(
        PsEripConfirmResponseWrapper instance) =>
    <String, dynamic>{
      'PS_ERIP': instance.psErip,
    };

PsEripConfirmResponse _$PsEripConfirmResponseFromJson(
        Map<String, dynamic> json) =>
    PsEripConfirmResponse(
      ConfirmResponse.fromJson(json['ConfirmResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsEripConfirmResponseToJson(
        PsEripConfirmResponse instance) =>
    <String, dynamic>{
      'ConfirmResponse': instance.response,
    };

ConfirmResponse _$ConfirmResponseFromJson(Map<String, dynamic> json) =>
    ConfirmResponse(
      errorCode: json['ErrorCode'] as int?,
      errorText: json['ErrorText'] as String?,
      payRecord: json['PayRecord'] == null
          ? null
          : ConfirmPayRecordResponse.fromJson(
              json['PayRecord'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ConfirmResponseToJson(ConfirmResponse instance) =>
    <String, dynamic>{
      'ErrorCode': instance.errorCode,
      'ErrorText': instance.errorText,
      'PayRecord': instance.payRecord,
    };

ConfirmPayRecordResponse _$ConfirmPayRecordResponseFromJson(
        Map<String, dynamic> json) =>
    ConfirmPayRecordResponse(
      paymentID: json['@PaymentID'] as int?,
      date: json['@Date'] as String?,
      kioskReceipt: json['@KioskReceipt'] as String?,
      recordID: json['@RecordID'] as int?,
      storn: json['@Storn'] as int?,
      attrRecord: json['@AttrRecord'] == null
          ? null
          : ConfirmAttrRecordResponse.fromJson(
              json['@AttrRecord'] as Map<String, dynamic>),
      check: json['@Check'] == null
          ? null
          : CheckResponse.fromJson(json['@Check'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ConfirmPayRecordResponseToJson(
        ConfirmPayRecordResponse instance) =>
    <String, dynamic>{
      '@PaymentID': instance.paymentID,
      '@Date': instance.date,
      '@KioskReceipt': instance.kioskReceipt,
      '@RecordID': instance.recordID,
      '@Storn': instance.storn,
      '@AttrRecord': instance.attrRecord,
      '@Check': instance.check,
    };

ConfirmAttrRecordResponse _$ConfirmAttrRecordResponseFromJson(
        Map<String, dynamic> json) =>
    ConfirmAttrRecordResponse(
      code: json['@Code'] as int?,
      codeOut: json['@CodeOut'] as int?,
      name: json['@Name'] as String?,
      value: json['@Value'] as String?,
    );

Map<String, dynamic> _$ConfirmAttrRecordResponseToJson(
        ConfirmAttrRecordResponse instance) =>
    <String, dynamic>{
      '@Code': instance.code,
      '@CodeOut': instance.codeOut,
      '@Name': instance.name,
      '@Value': instance.value,
    };
