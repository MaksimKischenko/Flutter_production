import 'package:json_annotation/json_annotation.dart';

part 'confirm_debet_response.g.dart';

@JsonSerializable(includeIfNull: false)
class ConfirmDebetResponse {

  @JsonKey(name: 'ReturnURL')
  final String? returnUrl;

  @JsonKey(name: 'ErrorCode')
  final int? errorCode;

  @JsonKey(name: 'ErrorText')
  final String? errorText;

  const ConfirmDebetResponse({
    this.returnUrl,
    this.errorCode,
    this.errorText
  });

  factory ConfirmDebetResponse.fromJson(Map<String, dynamic> json) => _$ConfirmDebetResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmDebetResponseToJson(this);
  
}