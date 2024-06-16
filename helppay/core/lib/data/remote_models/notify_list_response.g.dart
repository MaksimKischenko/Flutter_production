// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notify_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MdomTpIntNotifyListResponseWrapper _$MdomTpIntNotifyListResponseWrapperFromJson(
        Map<String, dynamic> json) =>
    MdomTpIntNotifyListResponseWrapper(
      MdomTpIntNotifyListResponse.fromJson(
          json['PS_TP_O_INT'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomTpIntNotifyListResponseWrapperToJson(
        MdomTpIntNotifyListResponseWrapper instance) =>
    <String, dynamic>{
      'PS_TP_O_INT': instance.psTpInt,
    };

MdomTpIntNotifyListResponse _$MdomTpIntNotifyListResponseFromJson(
        Map<String, dynamic> json) =>
    MdomTpIntNotifyListResponse(
      NotificationListResponse.fromJson(
          json['NotificationListResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomTpIntNotifyListResponseToJson(
        MdomTpIntNotifyListResponse instance) =>
    <String, dynamic>{
      'NotificationListResponse': instance.response,
    };

NotificationListResponse _$NotificationListResponseFromJson(
        Map<String, dynamic> json) =>
    NotificationListResponse(
      version: json['Version'] as int,
      keyRequest: json['KeyRequest'] as int,
      errorCode: json['ErrorCode'] as int,
      errorText: json['ErrorText'] as String?,
      unreadCount: json['UnreadCount'] as int?,
      notification: (json['Notification'] as List<dynamic>?)
          ?.map((e) => ResponseNotification.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NotificationListResponseToJson(
        NotificationListResponse instance) =>
    <String, dynamic>{
      'Version': instance.version,
      'KeyRequest': instance.keyRequest,
      'ErrorCode': instance.errorCode,
      'ErrorText': instance.errorText,
      'UnreadCount': instance.unreadCount,
      'Notification': instance.notification,
    };

ResponseNotification _$ResponseNotificationFromJson(
        Map<String, dynamic> json) =>
    ResponseNotification(
      id: json['@Id'] as int,
      message: json['@Message'] as String,
      status: json['@Status'] as int,
      topic: json['@Topic'] as String,
      stopDate: json['@StopDate'] as String,
    );

Map<String, dynamic> _$ResponseNotificationToJson(
        ResponseNotification instance) =>
    <String, dynamic>{
      '@Id': instance.id,
      '@Message': instance.message,
      '@Status': instance.status,
      '@Topic': instance.topic,
      '@StopDate': instance.stopDate,
    };
