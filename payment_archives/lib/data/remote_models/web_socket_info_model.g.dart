// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_socket_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebSocketBodyData _$WebSocketBodyDataFromJson(Map<String, dynamic> json) =>
    WebSocketBodyData(
      eventName: json['event'] as String?,
      channelName: json['channel'] as String?,
      payloadId: json['payload'] as String?,
    );

Map<String, dynamic> _$WebSocketBodyDataToJson(WebSocketBodyData instance) =>
    <String, dynamic>{
      'event': instance.eventName,
      'channel': instance.channelName,
      'payload': instance.payloadId,
    };
