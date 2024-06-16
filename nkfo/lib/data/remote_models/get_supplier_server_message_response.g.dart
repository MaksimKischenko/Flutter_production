// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_supplier_server_message_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerMessage _$ServerMessageFromJson(Map<String, dynamic> json) =>
    ServerMessage(
      id: json['message_id'] as int,
      date: json['message_date'] == null
          ? null
          : DateTime.parse(json['message_date'] as String),
      note: json['note'] as String?,
      status: json['status'] as int?,
      statusName: json['state_name'] as String?,
      statusId: json['state_id'] as int?,
      heading: json['heading'] as String?,
      sendingDate: json['sending_date'] == null
          ? null
          : DateTime.parse(json['sending_date'] as String),
      supplierId: (json['supplier_id'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
    );

Map<String, dynamic> _$ServerMessageToJson(ServerMessage instance) =>
    <String, dynamic>{
      'message_id': instance.id,
      'message_date': instance.date?.toIso8601String(),
      'note': instance.note,
      'status': instance.status,
      'state_name': instance.statusName,
      'state_id': instance.statusId,
      'heading': instance.heading,
      'sending_date': instance.sendingDate?.toIso8601String(),
      'supplier_id': instance.supplierId,
    };
