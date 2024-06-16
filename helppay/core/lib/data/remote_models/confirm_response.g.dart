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

Map<String, dynamic> _$ConfirmResponseToJson(ConfirmResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ErrorCode', instance.errorCode);
  writeNotNull('ErrorText', instance.errorText);
  writeNotNull('PayRecord', instance.payRecord);
  return val;
}

ConfirmPayRecordResponse _$ConfirmPayRecordResponseFromJson(
        Map<String, dynamic> json) =>
    ConfirmPayRecordResponse(
      paymentID: json['@PaymentID'] as int,
      date: json['@Date'] as String,
      kioskReceipt: json['@KioskReceipt'] as String,
      recordID: json['@RecordID'] as int,
      storn: json['@Storn'] as int?,
      attrRecord: json['@AttrRecord'] == null
          ? null
          : ConfirmAttrRecordResponse.fromJson(
              json['@AttrRecord'] as Map<String, dynamic>),
      check: json['@Check'] == null
          ? null
          : ConfirmCheckResponse.fromJson(
              json['@Check'] as Map<String, dynamic>),
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
      code: json['@Code'] as int,
      codeOut: json['@CodeOut'] as int?,
      name: json['@Name'] as String,
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

ConfirmCheckResponse _$ConfirmCheckResponseFromJson(
        Map<String, dynamic> json) =>
    ConfirmCheckResponse(
      checkFooter: json['CheckFooter'] == null
          ? null
          : CheckFooterItem.fromJson(
              json['CheckFooter'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ConfirmCheckResponseToJson(
        ConfirmCheckResponse instance) =>
    <String, dynamic>{
      'CheckFooter': instance.checkFooter,
    };

CheckFooterItem _$CheckFooterItemFromJson(Map<String, dynamic> json) =>
    CheckFooterItem(
      count: json['@Count'] as int,
      checkLine: (json['CheckLine'] as List<dynamic>)
          .map((e) => CheckLineFooterItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CheckFooterItemToJson(CheckFooterItem instance) =>
    <String, dynamic>{
      '@Count': instance.count,
      'CheckLine': instance.checkLine,
    };

CheckLineFooterItem _$CheckLineFooterItemFromJson(Map<String, dynamic> json) =>
    CheckLineFooterItem(
      idx: json['@Idx'] as int,
      evalue: json['evalue'] as String,
      doubleHeightSymbol: json['@DoubleHeightSymbol'] as int?,
      doubleWidthSymbol: json['@DoubleWidthSymbol'] as int?,
      inverseSymbol: json['@InverseSymbol'] as int?,
    );

Map<String, dynamic> _$CheckLineFooterItemToJson(
        CheckLineFooterItem instance) =>
    <String, dynamic>{
      '@Idx': instance.idx,
      'evalue': instance.evalue,
      '@DoubleHeightSymbol': instance.doubleHeightSymbol,
      '@DoubleWidthSymbol': instance.doubleWidthSymbol,
      '@InverseSymbol': instance.inverseSymbol,
    };
