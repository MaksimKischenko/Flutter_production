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
      terminalId: json['TerminalID'] as String,
      version: json['Version'] as int,
      pan: json['PAN'] == null
          ? null
          : PAN.fromJson(json['PAN'] as Map<String, dynamic>),
      typePan: json['TypePAN'] == null
          ? null
          : TypePAN.fromJson(json['TypePAN'] as Map<String, dynamic>),
      payCode: json['PayCode'] as int,
      attrRecord: (json['AttrRecord'] as List<dynamic>?)
          ?.map((e) => AttrRecordRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
      paySumma: json['PaySumma'] == null
          ? null
          : GetPayListRequestPaySumma.fromJson(
              json['PaySumma'] as Map<String, dynamic>),
      sessionId: json['SessionId'] as String?,
    );

Map<String, dynamic> _$GetPayListRequestToJson(GetPayListRequest instance) {
  final val = <String, dynamic>{
    'TerminalID': instance.terminalId,
    'Version': instance.version,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('PAN', instance.pan);
  writeNotNull('TypePAN', instance.typePan);
  val['PayCode'] = instance.payCode;
  writeNotNull('AttrRecord', instance.attrRecord);
  writeNotNull('PaySumma', instance.paySumma);
  writeNotNull('SessionId', instance.sessionId);
  return val;
}

GetPayListRequestFilter _$GetPayListRequestFilterFromJson(
        Map<String, dynamic> json) =>
    GetPayListRequestFilter(
      attrRecords: (json['AttrRecord'] as List<dynamic>?)
          ?.map((e) => FilterAttrRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetPayListRequestFilterToJson(
    GetPayListRequestFilter instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('AttrRecord', instance.attrRecords);
  return val;
}

FilterAttrRecord _$FilterAttrRecordFromJson(Map<String, dynamic> json) =>
    FilterAttrRecord(
      code: json['@Code'] as int,
      value: json['@Value'] as String?,
    );

Map<String, dynamic> _$FilterAttrRecordToJson(FilterAttrRecord instance) {
  final val = <String, dynamic>{
    '@Code': instance.code,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('@Value', instance.value);
  return val;
}

GetPayListRequestPaySumma _$GetPayListRequestPaySummaFromJson(
        Map<String, dynamic> json) =>
    GetPayListRequestPaySumma(
      evalue: (json['evalue'] as num?)?.toDouble(),
      currency: json['@Currency'] as int?,
    );

Map<String, dynamic> _$GetPayListRequestPaySummaToJson(
    GetPayListRequestPaySumma instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('evalue', instance.evalue);
  writeNotNull('@Currency', instance.currency);
  return val;
}
