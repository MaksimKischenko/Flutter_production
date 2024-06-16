// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplier_server_message_insert_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerMessageInsertRequest _$ServerMessageInsertRequestFromJson(
        Map<String, dynamic> json) =>
    ServerMessageInsertRequest(
      heading: json['heading'] as String?,
      messageDate: json['message_date'] == null
          ? null
          : DateTime.parse(json['message_date'] as String),
      note: json['note'] as String?,
      sendingDate: json['sending_date'] == null
          ? null
          : DateTime.parse(json['sending_date'] as String),
      sendingImmediately: json['sending_immediately'] as bool? ?? false,
      supplierId: (json['supplier_id'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
    );

Map<String, dynamic> _$ServerMessageInsertRequestToJson(
        ServerMessageInsertRequest instance) =>
    <String, dynamic>{
      'heading': instance.heading,
      'message_date': instance.messageDate?.toIso8601String(),
      'note': instance.note,
      'sending_date': instance.sendingDate?.toIso8601String(),
      'sending_immediately': instance.sendingImmediately,
      'supplier_id': instance.supplierId,
    };
