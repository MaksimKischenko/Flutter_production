import 'package:json_annotation/json_annotation.dart';

part 'start_message_request.g.dart';

@JsonSerializable()
class StartMessageRequest {

  @JsonKey(name: 'p_message')
  final String message;


  StartMessageRequest({
    required this.message,
  });

  factory StartMessageRequest.fromJson(Map<String, dynamic> json) => _$StartMessageRequestFromJson(json);

  Map<String, dynamic> toJson() => _$StartMessageRequestToJson(this);
  
}
