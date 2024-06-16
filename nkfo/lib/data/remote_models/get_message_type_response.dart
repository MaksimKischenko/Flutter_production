import 'package:json_annotation/json_annotation.dart';

part 'get_message_type_response.g.dart';

@JsonSerializable()
class MessageType {

  @JsonKey(name: 'message_type_id')
  final int id;

  @JsonKey(name: 'message_type_description')
  final String? name;

  @JsonKey(name: 'message_type_answer_id')
  final int? answerId;

  MessageType({
    required this.id,
    this.name,
    this.answerId,
  });
  

  factory MessageType.fromJson(Map<String, dynamic> json) => _$MessageTypeFromJson(json);

  Map<String, dynamic> toJson() => _$MessageTypeToJson(this);
}
