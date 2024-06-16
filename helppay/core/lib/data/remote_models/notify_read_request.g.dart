// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notify_read_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MdomTpIntNotifyReadRequestWrapper _$MdomTpIntNotifyReadRequestWrapperFromJson(
        Map<String, dynamic> json) =>
    MdomTpIntNotifyReadRequestWrapper(
      MdomTpIntNotifyReadRequest.fromJson(
          json['PS_TP_O_INT'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomTpIntNotifyReadRequestWrapperToJson(
        MdomTpIntNotifyReadRequestWrapper instance) =>
    <String, dynamic>{
      'PS_TP_O_INT': instance.psTpInt,
    };

MdomTpIntNotifyReadRequest _$MdomTpIntNotifyReadRequestFromJson(
        Map<String, dynamic> json) =>
    MdomTpIntNotifyReadRequest(
      NotificationReadRequest.fromJson(
          json['NotificationReadRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomTpIntNotifyReadRequestToJson(
        MdomTpIntNotifyReadRequest instance) =>
    <String, dynamic>{
      'NotificationReadRequest': instance.request,
    };

NotificationReadRequest _$NotificationReadRequestFromJson(
        Map<String, dynamic> json) =>
    NotificationReadRequest(
      terminalId: MdomTpIntTerminalId.fromJson(
          json['TerminalId'] as Map<String, dynamic>),
      version: json['Version'] as String,
      keyRequest: json['KeyRequest'] as int,
      lang: json['Lang'] as String?,
      token: json['Token'] as String,
      lastNotificationIndicator: json['Id'] as int?,
    );

Map<String, dynamic> _$NotificationReadRequestToJson(
    NotificationReadRequest instance) {
  final val = <String, dynamic>{
    'TerminalId': instance.terminalId,
    'Version': instance.version,
    'KeyRequest': instance.keyRequest,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Lang', instance.lang);
  val['Token'] = instance.token;
  writeNotNull('Id', instance.lastNotificationIndicator);
  return val;
}
