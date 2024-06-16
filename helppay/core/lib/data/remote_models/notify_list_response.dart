import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notify_list_response.g.dart';

@JsonSerializable()
class MdomTpIntNotifyListResponseWrapper {
  @JsonKey(name: 'PS_TP_O_INT')
  final MdomTpIntNotifyListResponse psTpInt;

  MdomTpIntNotifyListResponseWrapper(this.psTpInt);

  factory MdomTpIntNotifyListResponseWrapper.fromJson(
          Map<String, dynamic> json) =>
      _$MdomTpIntNotifyListResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() =>
      _$MdomTpIntNotifyListResponseWrapperToJson(this);
}

@JsonSerializable()
class MdomTpIntNotifyListResponse {
  @JsonKey(name: 'NotificationListResponse')
  final NotificationListResponse response;

  MdomTpIntNotifyListResponse(this.response);

  factory MdomTpIntNotifyListResponse.fromJson(Map<String, dynamic> json) =>
      _$MdomTpIntNotifyListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MdomTpIntNotifyListResponseToJson(this);
}

@JsonSerializable()
class NotificationListResponse {
  // general part

  @JsonKey(name: 'Version')
  final int version;

  @JsonKey(name: 'KeyRequest')
  final int keyRequest;

  @JsonKey(name: 'ErrorCode')
  final int errorCode;

  @JsonKey(name: 'ErrorText')
  final String? errorText;

  // general part END

  @JsonKey(name: 'UnreadCount')
  final int? unreadCount;

  @JsonKey(name: 'Notification')
  final List<ResponseNotification>? notification;

  NotificationListResponse({
    required this.version,
    required this.keyRequest,
    required this.errorCode,
    this.errorText,
    this.unreadCount,
    this.notification,
  });

  factory NotificationListResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationListResponseToJson(this);
}

@JsonSerializable()
class ResponseNotification extends Equatable {
  @JsonKey(name: '@Id')
  final int id;

  @JsonKey(name: '@Message')
  final String message;

  @JsonKey(name: '@Status')
  final int status;

  @JsonKey(name: '@Topic')
  final String topic;

  @JsonKey(name: '@StopDate')
  final String stopDate;

  const ResponseNotification({
    required this.id,
    required this.message,
    required this.status,
    required this.topic,
    required this.stopDate,
  });

  factory ResponseNotification.fromJson(Map<String, dynamic> json) =>
      _$ResponseNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseNotificationToJson(this);

  @override
  List<Object?> get props => [id, message, status, topic, stopDate];

  ResponseNotification copyWith({
    int? id,
    String? message,
    int? status,
    String? topic,
    String? stopDate,
  }) =>
      ResponseNotification(
        id: id ?? this.id,
        message: message ?? this.message,
        status: status ?? this.status,
        topic: topic ?? this.topic,
        stopDate: stopDate ?? this.stopDate,
      );
}
