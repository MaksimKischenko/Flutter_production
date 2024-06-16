// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_pay_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsEripGetPayListResponseWrapper _$PsEripGetPayListResponseWrapperFromJson(
        Map<String, dynamic> json) =>
    PsEripGetPayListResponseWrapper(
      PsEripGetPayListResponse.fromJson(
          json['PS_ERIP'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsEripGetPayListResponseWrapperToJson(
        PsEripGetPayListResponseWrapper instance) =>
    <String, dynamic>{
      'PS_ERIP': instance.psErip,
    };

PsEripGetPayListResponse _$PsEripGetPayListResponseFromJson(
        Map<String, dynamic> json) =>
    PsEripGetPayListResponse(
      GetPayListResponse.fromJson(
          json['GetPayListResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsEripGetPayListResponseToJson(
        PsEripGetPayListResponse instance) =>
    <String, dynamic>{
      'GetPayListResponse': instance.response,
    };

GetPayListResponse _$GetPayListResponseFromJson(Map<String, dynamic> json) =>
    GetPayListResponse(
      errorCode: json['ErrorCode'] as int?,
      errorText: json['ErrorText'] as String?,
      token: json['Token'] as String?,
      payRecord: (json['PayRecord'] as List<dynamic>?)
          ?.map((e) => PayRecordResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetPayListResponseToJson(GetPayListResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ErrorCode', instance.errorCode);
  writeNotNull('ErrorText', instance.errorText);
  writeNotNull('Token', instance.token);
  writeNotNull('PayRecord', instance.payRecord);
  return val;
}

PayRecordResponse _$PayRecordResponseFromJson(Map<String, dynamic> json) =>
    PayRecordResponse(
      code: json['@Code'] as int,
      name: json['@Name'] as String?,
      codeOut: json['@CodeOut'] as int?,
      diType: json['@DIType'] as int?,
      getPayListType: json['@GetPayListType'] as int?,
      category: json['@Category'] as int?,
      paymentID: json['@PaymentID'] as int?,
      date: json['@Date'] as String?,
      recordID: json['@RecordID'] as int?,
      recordType: json['@RecordType'] as int?,
      stornoMode: json['@StornoMode'] as String?,
      change: json['@Change'] as int?,
      picture: json['Picture'] == null
          ? null
          : Picture.fromJson(json['Picture'] as Map<String, dynamic>),
      payAll: (json['@PayAll'] as num?)?.toDouble(),
      summa: (json['@Summa'] as num?)?.toDouble(),
      min: (json['@Min'] as num?)?.toDouble(),
      max: (json['@Max'] as num?)?.toDouble(),
      nominal: (json['@Nominal'] as num?)?.toDouble(),
      edit: json['@Edit'] as int?,
      view: json['@View'] as int?,
      fine: (json['@Fine'] as num?)?.toDouble(),
      currency: (json['@Currency'] as num?)?.toDouble(),
      payCommission: (json['@PayCommission'] as num?)?.toDouble(),
      sessionId: json['@SessionId'] as String?,
      attrRecord: (json['AttrRecord'] as List<dynamic>?)
          ?.map((e) => AttrRecordResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      lookups: json['Lookups'] == null
          ? null
          : Lookups.fromJson(json['Lookups'] as Map<String, dynamic>),
      check: json['Check'] == null
          ? null
          : CheckResponse.fromJson(json['Check'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PayRecordResponseToJson(PayRecordResponse instance) =>
    <String, dynamic>{
      '@Code': instance.code,
      '@Name': instance.name,
      '@CodeOut': instance.codeOut,
      '@DIType': instance.diType,
      '@GetPayListType': instance.getPayListType,
      '@Category': instance.category,
      '@RecordType': instance.recordType,
      '@StornoMode': instance.stornoMode,
      '@Change': instance.change,
      '@RecordID': instance.recordID,
      'Picture': instance.picture,
      '@PayAll': instance.payAll,
      '@Summa': instance.summa,
      '@Min': instance.min,
      '@Max': instance.max,
      '@Nominal': instance.nominal,
      '@Edit': instance.edit,
      '@View': instance.view,
      '@Fine': instance.fine,
      '@Currency': instance.currency,
      '@PayCommission': instance.payCommission,
      '@SessionId': instance.sessionId,
      '@PaymentID': instance.paymentID,
      '@Date': instance.date,
      'AttrRecord': instance.attrRecord,
      'Lookups': instance.lookups,
      'Check': instance.check,
    };

Picture _$PictureFromJson(Map<String, dynamic> json) => Picture(
      evalue: json['evalue'] as String?,
      url: json['@URL'] as String?,
    );

Map<String, dynamic> _$PictureToJson(Picture instance) => <String, dynamic>{
      'evalue': instance.evalue,
      '@URL': instance.url,
    };

AttrRecordResponse _$AttrRecordResponseFromJson(Map<String, dynamic> json) =>
    AttrRecordResponse(
      code: json['@Code'] as int?,
      name: json['@Name'] as String?,
      lookup: json['@Lookup'] as String?,
      type: json['@Type'] as String?,
      hint: json['@Hint'] as String?,
      codeOut: json['@CodeOut'] as int?,
      minLength: json['@MinLength'] as int?,
      maxLength: json['@MaxLength'] as int?,
      min: (json['@Min'] as num?)?.toDouble(),
      max: (json['@Max'] as num?)?.toDouble(),
      mandatory: json['@Mandatory'] as int?,
      edit: json['@Edit'] as int?,
      view: json['@View'] as int?,
      mask: json['Mask'] as String?,
      value: json['@Value'] as String?,
      change: json['@Change'] as int?,
    );

Map<String, dynamic> _$AttrRecordResponseToJson(AttrRecordResponse instance) =>
    <String, dynamic>{
      '@Code': instance.code,
      '@Name': instance.name,
      '@Lookup': instance.lookup,
      '@Type': instance.type,
      '@Hint': instance.hint,
      '@CodeOut': instance.codeOut,
      '@MinLength': instance.minLength,
      '@MaxLength': instance.maxLength,
      '@Min': instance.min,
      '@Max': instance.max,
      '@Mandatory': instance.mandatory,
      '@Edit': instance.edit,
      '@View': instance.view,
      'Mask': instance.mask,
      '@Value': instance.value,
      '@Change': instance.change,
    };

Lookups _$LookupsFromJson(Map<String, dynamic> json) => Lookups(
      lookupList: (json['Lookup'] as List<dynamic>)
          .map((e) => Lookup.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LookupsToJson(Lookups instance) => <String, dynamic>{
      'Lookup': instance.lookupList,
    };

Lookup _$LookupFromJson(Map<String, dynamic> json) => Lookup(
      name: json['@Name'] as String,
      items: (json['Item'] as List<dynamic>?)
          ?.map((e) => LookupItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LookupToJson(Lookup instance) => <String, dynamic>{
      '@Name': instance.name,
      'Item': instance.items,
    };

LookupItem _$LookupItemFromJson(Map<String, dynamic> json) => LookupItem(
      name: json['@Name'] as String?,
      evalue: json['evalue'] as String?,
    );

Map<String, dynamic> _$LookupItemToJson(LookupItem instance) =>
    <String, dynamic>{
      '@Name': instance.name,
      'evalue': instance.evalue,
    };

CheckResponse _$CheckResponseFromJson(Map<String, dynamic> json) =>
    CheckResponse(
      checkHeader: json['CheckHeader'] == null
          ? null
          : CheckHeaderItem.fromJson(
              json['CheckHeader'] as Map<String, dynamic>),
      checkFooter: json['CheckFooter'] == null
          ? null
          : CheckHeaderItem.fromJson(
              json['CheckFooter'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CheckResponseToJson(CheckResponse instance) =>
    <String, dynamic>{
      'CheckHeader': instance.checkHeader,
      'CheckFooter': instance.checkFooter,
    };

CheckHeaderItem _$CheckHeaderItemFromJson(Map<String, dynamic> json) =>
    CheckHeaderItem(
      count: json['@Count'] as int,
      checkLine: (json['CheckLine'] as List<dynamic>)
          .map((e) => CheckLineItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CheckHeaderItemToJson(CheckHeaderItem instance) =>
    <String, dynamic>{
      '@Count': instance.count,
      'CheckLine': instance.checkLine,
    };

CheckLineItem _$CheckLineItemFromJson(Map<String, dynamic> json) =>
    CheckLineItem(
      idx: json['@Idx'] as int,
      evalue: json['evalue'] as String?,
    );

Map<String, dynamic> _$CheckLineItemToJson(CheckLineItem instance) =>
    <String, dynamic>{
      '@Idx': instance.idx,
      'evalue': instance.evalue,
    };
