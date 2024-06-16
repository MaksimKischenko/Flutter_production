// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'run_operation_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsEripRunOperationRequestWrapper _$PsEripRunOperationRequestWrapperFromJson(
        Map<String, dynamic> json) =>
    PsEripRunOperationRequestWrapper(
      PsEripRunOperationRequest.fromJson(
          json['PS_ERIP'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsEripRunOperationRequestWrapperToJson(
        PsEripRunOperationRequestWrapper instance) =>
    <String, dynamic>{
      'PS_ERIP': instance.psErip,
    };

PsEripRunOperationRequest _$PsEripRunOperationRequestFromJson(
        Map<String, dynamic> json) =>
    PsEripRunOperationRequest(
      RunOperationRequest.fromJson(
          json['RunOperationRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsEripRunOperationRequestToJson(
        PsEripRunOperationRequest instance) =>
    <String, dynamic>{
      'RunOperationRequest': instance.request,
    };

RunOperationRequest _$RunOperationRequestFromJson(Map<String, dynamic> json) =>
    RunOperationRequest(
      terminalID: json['TerminalID'] as String,
      version: json['Version'] as int,
      diType: json['DIType'] as int?,
      token: json['Token'] as String,
      kioskReceipt: json['KioskReceipt'] as int?,
      payDate: json['PayDate'] as String,
      payRecordCount: json['PayRecordCount'] as int?,
      payRecord: json['PayRecord'] == null
          ? null
          : PayRecordRequest.fromJson(
              json['PayRecord'] as Map<String, dynamic>),
      pan: json['PAN'] == null
          ? null
          : Pan.fromJson(json['PAN'] as Map<String, dynamic>),
      typePan: json['TypePAN'] == null
          ? null
          : TypePan.fromJson(json['TypePAN'] as Map<String, dynamic>),
      lang: json['Lang'] == null
          ? null
          : Lang.fromJson(json['Lang'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RunOperationRequestToJson(RunOperationRequest instance) {
  final val = <String, dynamic>{
    'TerminalID': instance.terminalID,
    'Version': instance.version,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('DIType', instance.diType);
  writeNotNull('PayRecordCount', instance.payRecordCount);
  val['Token'] = instance.token;
  val['PayDate'] = instance.payDate;
  writeNotNull('KioskReceipt', instance.kioskReceipt);
  writeNotNull('PayRecord', instance.payRecord);
  writeNotNull('PAN', instance.pan);
  writeNotNull('TypePAN', instance.typePan);
  writeNotNull('Lang', instance.lang);
  return val;
}

PayRecordRequest _$PayRecordRequestFromJson(Map<String, dynamic> json) =>
    PayRecordRequest(
      code: json['@Code'] as int,
      attrRecord: (json['AttrRecord'] as List<dynamic>)
          .map((e) => AttrRecordRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
      codeOut: json['@CodeOut'] as int?,
      recordID: json['@RecordID'] as String?,
      nameOut: json['@NameOut'] as String?,
      summa: (json['@Summa'] as num?)?.toDouble(),
      payCommission: (json['@PayCommission'] as num?)?.toDouble(),
      fine: (json['@Fine'] as num?)?.toDouble(),
      currency: (json['@Currency'] as num?)?.toDouble(),
      sessionId: json['@SessionId'] as String?,
    );

Map<String, dynamic> _$PayRecordRequestToJson(PayRecordRequest instance) {
  final val = <String, dynamic>{
    '@Code': instance.code,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('@RecordID', instance.recordID);
  writeNotNull('@CodeOut', instance.codeOut);
  writeNotNull('@NameOut', instance.nameOut);
  writeNotNull('@Summa', instance.summa);
  writeNotNull('@PayCommission', instance.payCommission);
  writeNotNull('@Fine', instance.fine);
  writeNotNull('@Currency', instance.currency);
  writeNotNull('@SessionId', instance.sessionId);
  val['AttrRecord'] = instance.attrRecord;
  return val;
}
