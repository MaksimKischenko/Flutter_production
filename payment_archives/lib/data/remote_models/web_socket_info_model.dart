// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'web_socket_info_model.g.dart';

@JsonSerializable()
class WebSocketBodyData {

  @JsonKey(name: 'event')
  final String? eventName;

  @JsonKey(name: 'channel')
  final String? channelName;

  @JsonKey(name: 'payload')
  final String? payloadId;

  WebSocketBodyData({
    this.eventName,
    this.channelName,
    this.payloadId,
  });


  factory WebSocketBodyData.fromJson(Map<String, dynamic> json) =>
      _$WebSocketBodyDataFromJson(json);

  Map<String, dynamic> toJson() => _$WebSocketBodyDataToJson(this);
}

