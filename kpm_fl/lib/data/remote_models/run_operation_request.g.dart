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
      terminalId: json['TerminalID'] as String,
      version: json['Version'] as int,
      lang: json['Lang'] as String,
      payDate: json['PayDate'] as String,
      kioskReceipt: json['KioskReceipt'] as String,
      payRecord: (json['PayRecord'] as List<dynamic>?)
          ?.map((e) => PayRecordRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
      pan: json['PAN'] == null
          ? null
          : PAN.fromJson(json['PAN'] as Map<String, dynamic>),
      typePAN: json['TypePAN'] == null
          ? null
          : TypePAN.fromJson(json['TypePAN'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RunOperationRequestToJson(RunOperationRequest instance) {
  final val = <String, dynamic>{
    'TerminalID': instance.terminalId,
    'Version': instance.version,
    'Lang': instance.lang,
    'PayDate': instance.payDate,
    'KioskReceipt': instance.kioskReceipt,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('PayRecord', instance.payRecord);
  writeNotNull('PAN', instance.pan);
  writeNotNull('TypePAN', instance.typePAN);
  return val;
}
