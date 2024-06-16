// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notify_read_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MdomTpIntNotifyReadResponseWrapper _$MdomTpIntNotifyReadResponseWrapperFromJson(
        Map<String, dynamic> json) =>
    MdomTpIntNotifyReadResponseWrapper(
      MdomTpIntNotifyReadResponse.fromJson(
          json['PS_TP_O_INT'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomTpIntNotifyReadResponseWrapperToJson(
        MdomTpIntNotifyReadResponseWrapper instance) =>
    <String, dynamic>{
      'PS_TP_O_INT': instance.psTpInt,
    };

MdomTpIntNotifyReadResponse _$MdomTpIntNotifyReadResponseFromJson(
        Map<String, dynamic> json) =>
    MdomTpIntNotifyReadResponse(
      NotificationReadResponse.fromJson(
          json['NotificationReadResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomTpIntNotifyReadResponseToJson(
        MdomTpIntNotifyReadResponse instance) =>
    <String, dynamic>{
      'NotificationReadResponse': instance.response,
    };

NotificationReadResponse _$NotificationReadResponseFromJson(
        Map<String, dynamic> json) =>
    NotificationReadResponse(
      version: json['Version'] as int,
      keyRequest: json['KeyRequest'] as int,
      errorCode: json['ErrorCode'] as int,
      errorText: json['ErrorText'] as String?,
    );

Map<String, dynamic> _$NotificationReadResponseToJson(
    NotificationReadResponse instance) {
  final val = <String, dynamic>{
    'Version': instance.version,
    'KeyRequest': instance.keyRequest,
    'ErrorCode': instance.errorCode,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ErrorText', instance.errorText);
  return val;
}
