// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_pay_list_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsEripGetPayListRequestWrapper _$PsEripGetPayListRequestWrapperFromJson(
        Map<String, dynamic> json) =>
    PsEripGetPayListRequestWrapper(
      PsEripGetPayListRequest.fromJson(json['PS_ERIP'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsEripGetPayListRequestWrapperToJson(
        PsEripGetPayListRequestWrapper instance) =>
    <String, dynamic>{
      'PS_ERIP': instance.psErip,
    };

PsEripGetPayListRequest _$PsEripGetPayListRequestFromJson(
        Map<String, dynamic> json) =>
    PsEripGetPayListRequest(
      GetPayListRequest.fromJson(
          json['GetPayListRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsEripGetPayListRequestToJson(
        PsEripGetPayListRequest instance) =>
    <String, dynamic>{
      'GetPayListRequest': instance.request,
    };

GetPayListRequest _$GetPayListRequestFromJson(Map<String, dynamic> json) =>
    GetPayListRequest(
      terminalID: json['TerminalID'] as String,
      diType: json['DIType'] as int,
      version: json['Version'] as int,
      token: json['Token'] as String,
      filter: json['Filter'] == null
          ? null
          : FilterQr.fromJson(json['Filter'] as Map<String, dynamic>),
      payCode: json['PayCode'] as int?,
      sessionId: json['SessionId'] as String?,
      attrRecord: (json['AttrRecord'] as List<dynamic>?)
          ?.map((e) => AttrRecordRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetPayListRequestToJson(GetPayListRequest instance) {
  final val = <String, dynamic>{
    'TerminalID': instance.terminalID,
    'DIType': instance.diType,
    'Version': instance.version,
    'Token': instance.token,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Filter', instance.filter);
  writeNotNull('PayCode', instance.payCode);
  writeNotNull('SessionId', instance.sessionId);
  writeNotNull('AttrRecord', instance.attrRecord);
  return val;
}

AttrRecordRequest _$AttrRecordRequestFromJson(Map<String, dynamic> json) =>
    AttrRecordRequest(
      code: json['@Code'] as int,
      name: json['@Name'] as String?,
      codeOut: json['@CodeOut'] as int?,
      value: json['@Value'] as String?,
      change: json['@Change'] as int?,
    );

Map<String, dynamic> _$AttrRecordRequestToJson(AttrRecordRequest instance) {
  final val = <String, dynamic>{
    '@Code': instance.code,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('@Name', instance.name);
  writeNotNull('@CodeOut', instance.codeOut);
  writeNotNull('@Value', instance.value);
  writeNotNull('@Change', instance.change);
  return val;
}

FilterQr _$FilterQrFromJson(Map<String, dynamic> json) => FilterQr(
      attrRecordQr: (json['AttrRecord'] as List<dynamic>)
          .map((e) => AttrRecordQr.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FilterQrToJson(FilterQr instance) => <String, dynamic>{
      'AttrRecord': instance.attrRecordQr,
    };

AttrRecordQr _$AttrRecordQrFromJson(Map<String, dynamic> json) => AttrRecordQr(
      attrCode: json['@Code'] as String?,
      value: json['@Value'] as String?,
    );

Map<String, dynamic> _$AttrRecordQrToJson(AttrRecordQr instance) =>
    <String, dynamic>{
      '@Code': instance.attrCode,
      '@Value': instance.value,
    };
