import 'package:json_annotation/json_annotation.dart';

import 'mdom_tp_int_base_models.dart';

part 'notify_list_request.g.dart';

@JsonSerializable()
class MdomTpIntNotifyListRequestWrapper {
  @JsonKey(name: 'PS_TP_O_INT')
  final MdomTpIntNotifyListRequest psTpInt;

  MdomTpIntNotifyListRequestWrapper(this.psTpInt);

  factory MdomTpIntNotifyListRequestWrapper.fromJson(
          Map<String, dynamic> json) =>
      _$MdomTpIntNotifyListRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() =>
      _$MdomTpIntNotifyListRequestWrapperToJson(this);
}

@JsonSerializable()
class MdomTpIntNotifyListRequest {
  @JsonKey(name: 'NotificationListRequest')
  final NotificationListRequest request;

  MdomTpIntNotifyListRequest(this.request);

  factory MdomTpIntNotifyListRequest.fromJson(Map<String, dynamic> json) =>
      _$MdomTpIntNotifyListRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MdomTpIntNotifyListRequestToJson(this);
}

@JsonSerializable(includeIfNull: false)
class NotificationListRequest {
  // general part

  @JsonKey(name: 'TerminalId')
  final MdomTpIntTerminalId terminalId;

  @JsonKey(name: 'Version')
  final String version;

  @JsonKey(name: 'KeyRequest')
  final int keyRequest;

  @JsonKey(name: 'Lang')
  final String? lang;

  @JsonKey(name: 'Token')
  final String token;

  // general part END

  @JsonKey(name: 'SupplierId')
  final int? supplierId;

  @JsonKey(name: 'RowCount')
  final NotifyListRequestRowCount? rowCount;

  NotificationListRequest({
    required this.terminalId,
    required this.version,
    required this.keyRequest,
    this.lang,
    required this.token,
    this.supplierId,
    this.rowCount,
  });

  factory NotificationListRequest.fromJson(Map<String, dynamic> json) =>
      _$NotificationListRequestFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationListRequestToJson(this);
}

@JsonSerializable(includeIfNull: false)
class NotifyListRequestRowCount {
  @JsonKey(name: 'value')
  final int value;

  @JsonKey(name: 'id')
  final int? id;

  const NotifyListRequestRowCount({
    required this.value,
    this.id,
  });

  factory NotifyListRequestRowCount.fromJson(Map<String, dynamic> json) =>
      _$NotifyListRequestRowCountFromJson(json);

  Map<String, dynamic> toJson() => _$NotifyListRequestRowCountToJson(this);
}
