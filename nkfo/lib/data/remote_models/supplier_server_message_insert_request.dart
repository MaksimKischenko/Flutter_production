import 'package:json_annotation/json_annotation.dart';

part 'supplier_server_message_insert_request.g.dart';

@JsonSerializable()
class ServerMessageInsertRequest {

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
  List<int>? supplierId;

  ServerMessageInsertRequest({
    this.heading,
    this.messageDate,
    this.note,
    this.sendingDate,
    this.sendingImmediately = false,
    this.supplierId,
  });

  factory ServerMessageInsertRequest.fromJson(Map<String, dynamic> json) => _$ServerMessageInsertRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ServerMessageInsertRequestToJson(this);
  

  ServerMessageInsertRequest copyWith({
    String? heading,
    DateTime? messageDate,
    String? note,
    DateTime? sendingDate,
    bool? sendingImmediately,
    List<int>? supplierId,
  }) => ServerMessageInsertRequest(
      heading: heading ?? this.heading,
      messageDate: messageDate ?? this.messageDate,
      note: note ?? this.note,
      sendingDate: sendingDate ?? this.sendingDate,
      sendingImmediately: sendingImmediately ?? this.sendingImmediately,
      supplierId: supplierId ?? this.supplierId,
    );
}
