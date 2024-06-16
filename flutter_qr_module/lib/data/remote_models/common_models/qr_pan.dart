import 'package:json_annotation/json_annotation.dart';

part 'qr_pan.g.dart';

@JsonSerializable(includeIfNull: false)
class QrPan {
  @JsonKey(name: 'Expiry')
  final String? expiry;

  @JsonKey(name: 'Value')
  final String value;

  QrPan({
    this.expiry,
    required this.value,
  });

  factory QrPan.fromJson(Map<String, dynamic> json) => _$QrPanFromJson(json);

  Map<String, dynamic> toJson() => _$QrPanToJson(this);
}
