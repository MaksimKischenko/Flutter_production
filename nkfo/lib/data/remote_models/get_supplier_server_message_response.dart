import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:web_cabinet_nkfo/models/models.dart';

part 'get_supplier_server_message_response.g.dart';

@JsonSerializable()
class ServerMessage {

  @JsonKey(name: 'message_id')
  final int id;

  @JsonKey(name: 'message_date')
  final DateTime? date;

  @JsonKey(name: 'note')
  final String? note;

  @JsonKey(name: 'status')
  final int? status;

  @JsonKey(name: 'state_name')
  String? statusName;

  @JsonKey(name: 'state_id')
  int? statusId;

  @JsonKey(name: 'heading')
  final String? heading;

  @JsonKey(name: 'sending_date')
  final DateTime? sendingDate;

  @JsonKey(name: 'supplier_id')
  final List<int>? supplierId;

  ServerMessage({
    required this.id,
    this.date,
    this.note,
    this.status,
    this.statusName,
    this.statusId,
    this.heading,
    this.sendingDate,
    this.supplierId
  });

  factory ServerMessage.fromJson(Map<String, dynamic> json) => _$ServerMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ServerMessageToJson(this);

  ServerMessageStatus get statusEnum => ServerMessageStatusExtension.fromInt(statusId);

  Color? get statusColor {
   
    if(statusId == 1 ){
      return CupertinoColors.black;
    } else if(statusId == 2) {
      return CupertinoColors.systemGreen;
    } else if(statusId == 3 ) {
      return CupertinoColors.systemYellow;
    }
    return null;
  }
}
