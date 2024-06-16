// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplier_server_message_update_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerMessageUpdateRequest _$ServerMessageUpdateRequestFromJson(
        Map<String, dynamic> json) =>
    ServerMessageUpdateRequest(
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

Map<String, dynamic> _$ServerMessageUpdateRequestToJson(
    ServerMessageUpdateRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('heading', instance.heading);
  writeNotNull('message_date', instance.messageDate?.toIso8601String());
  writeNotNull('note', instance.note);
  writeNotNull('sending_date', instance.sendingDate?.toIso8601String());
  val['sending_immediately'] = instance.sendingImmediately;
  writeNotNull('supplier_id', instance.supplierId);
  return val;
}
