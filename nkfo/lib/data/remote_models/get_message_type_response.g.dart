// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_message_type_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageType _$MessageTypeFromJson(Map<String, dynamic> json) => MessageType(
      id: json['message_type_id'] as int,
      name: json['message_type_description'] as String?,
      answerId: json['message_type_answer_id'] as int?,
    );

Map<String, dynamic> _$MessageTypeToJson(MessageType instance) =>
    <String, dynamic>{
      'message_type_id': instance.id,
      'message_type_description': instance.name,
      'message_type_answer_id': instance.answerId,
    };
