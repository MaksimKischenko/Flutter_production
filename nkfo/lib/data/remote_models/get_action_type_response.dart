import 'package:json_annotation/json_annotation.dart';

part 'get_action_type_response.g.dart';

@JsonSerializable()
class ActionType {

  @JsonKey(name: 'action_type_id')
  final int id;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'type')
  final int typeNum;
  
  @JsonKey(name: 'enabled')
  final int enabledNum;

  ActionType({
    required this.id,
    required this.name,
    required this.typeNum,
    required this.enabledNum,
  });
  

  factory ActionType.fromJson(Map<String, dynamic> json) => _$ActionTypeFromJson(json);

  Map<String, dynamic> toJson() => _$ActionTypeToJson(this);
  
}
