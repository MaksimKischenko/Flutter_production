// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_pay_list_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPayListRequest _$GetPayListRequestFromJson(Map<String, dynamic> json) =>
    GetPayListRequest(
      payCode: GetPayListRequestPayCode.fromJson(
          json['PayCode'] as Map<String, dynamic>),
      diType: json['DIType'] as int,
      filter: json['Filter'] == null
          ? null
          : GetPayListRequestFilter.fromJson(
              json['Filter'] as Map<String, dynamic>),
      sessionId: json['SessionId'] as String?,
      attrRecord: (json['AttrRecord'] as List<dynamic>?)
          ?.map((e) => AttrRecordRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
      paySumma: json['PaySumma'] == null
          ? null
          : GetPayListRequestPaySumma.fromJson(
              json['PaySumma'] as Map<String, dynamic>),
      properties: (json['Property'] as List<dynamic>?)
          ?.map((e) => RequestProperty.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetPayListRequestToJson(GetPayListRequest instance) {
  final val = <String, dynamic>{
    'PayCode': instance.payCode,
    'DIType': instance.diType,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Filter', instance.filter);
  writeNotNull('SessionId', instance.sessionId);
  writeNotNull('AttrRecord', instance.attrRecord);
  writeNotNull('PaySumma', instance.paySumma);
  writeNotNull('Property', instance.properties);
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

GetPayListRequestPayCode _$GetPayListRequestPayCodeFromJson(
        Map<String, dynamic> json) =>
    GetPayListRequestPayCode(
      evalue: json['evalue'] as int,
      type: json['@Type'] as String?,
    );

Map<String, dynamic> _$GetPayListRequestPayCodeToJson(
    GetPayListRequestPayCode instance) {
  final val = <String, dynamic>{
    'evalue': instance.evalue,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('@Type', instance.type);
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
