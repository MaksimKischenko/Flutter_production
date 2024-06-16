import 'package:json_annotation/json_annotation.dart';

part 'supplier_server_message_update_request.g.dart';

@JsonSerializable(includeIfNull: false)
class ServerMessageUpdateRequest {

  @JsonKey(name: 'heading')
  String? heading;

  @JsonKey(name: 'message_date')
  DateTime? messageDate;

  @JsonKey(name: 'note')
  String? note;

  @JsonKey(name: 'sending_date')
  DateTime? sendingDate;

  @JsonKey(name: 'sending_immediately')
  bool sendingImmediately;

  @JsonKey(name: 'supplier_id')
  final List<int>? supplierId;

  ServerMessageUpdateRequest({
    this.heading,
    this.messageDate,
    this.note,
    this.sendingDate,
    this.sendingImmediately = false,
    this.supplierId,
  });

  factory ServerMessageUpdateRequest.fromJson(Map<String, dynamic> json) => _$ServerMessageUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ServerMessageUpdateRequestToJson(this);
  
}
