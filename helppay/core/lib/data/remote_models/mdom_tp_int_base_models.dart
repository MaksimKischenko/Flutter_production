import 'package:json_annotation/json_annotation.dart';

part 'mdom_tp_int_base_models.g.dart';

/// TerminalId element
@JsonSerializable()
class MdomTpIntTerminalId {

  @JsonKey(name: 'evalue')
  final String evalue;

  /// fill with rand data
  @JsonKey(name: '@Password')
  final String password;

  MdomTpIntTerminalId({
    required this.evalue,
    required this.password
  });

  factory MdomTpIntTerminalId.fromJson(Map<String, dynamic> json) => _$MdomTpIntTerminalIdFromJson(json);

  Map<String, dynamic> toJson() => _$MdomTpIntTerminalIdToJson(this);
  
}