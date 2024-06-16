// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_connect_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsMtCheckConnectRequestWrapper _$PsMtCheckConnectRequestWrapperFromJson(
        Map<String, dynamic> json) =>
    PsMtCheckConnectRequestWrapper(
      PsMtCheckConnectRequest.fromJson(json['PS_MT'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsMtCheckConnectRequestWrapperToJson(
        PsMtCheckConnectRequestWrapper instance) =>
    <String, dynamic>{
      'PS_MT': instance.psMt,
    };

PsMtCheckConnectRequest _$PsMtCheckConnectRequestFromJson(
        Map<String, dynamic> json) =>
    PsMtCheckConnectRequest(
      CheckConnectRequest.fromJson(
          json['CheckConnectRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsMtCheckConnectRequestToJson(
        PsMtCheckConnectRequest instance) =>
    <String, dynamic>{
      'CheckConnectRequest': instance.request,
    };

CheckConnectRequest _$CheckConnectRequestFromJson(Map<String, dynamic> json) =>
    CheckConnectRequest(
      terminalId: json['TerminalID'] as String,
      version: json['Version'] as int,
      resultUpdate: json['ResultUpdate'] as int?,
      ip: json['Ip'] as String?,
    );

Map<String, dynamic> _$CheckConnectRequestToJson(CheckConnectRequest instance) {
  final val = <String, dynamic>{
    'TerminalID': instance.terminalId,
    'Version': instance.version,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ResultUpdate', instance.resultUpdate);
  writeNotNull('Ip', instance.ip);
  return val;
}
