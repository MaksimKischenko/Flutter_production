import 'package:json_annotation/json_annotation.dart';

part 'qr_terminal_id.g.dart';

@JsonSerializable(includeIfNull: false)
class RegPayMinTerminalID {
  @JsonKey(name: 'Value')
  final String evalue;

  RegPayMinTerminalID({
    required this.evalue,
  });

  factory RegPayMinTerminalID.fromJson(Map<String, dynamic> json) =>
      _$RegPayMinTerminalIDFromJson(json);

  Map<String, dynamic> toJson() => _$RegPayMinTerminalIDToJson(this);
}
