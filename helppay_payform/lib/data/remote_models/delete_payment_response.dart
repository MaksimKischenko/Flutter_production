import 'package:json_annotation/json_annotation.dart';

part 'delete_payment_response.g.dart';

@JsonSerializable()
class DeletePaymentResponse {

  @JsonKey(name: 'ErrorCode')
  final int? errorCode;

  @JsonKey(name: 'ErrorText')
  final String? errorText;

  const DeletePaymentResponse({
    this.errorCode,
    this.errorText,
  });

  factory DeletePaymentResponse.fromJson(Map<String, dynamic> json) => _$DeletePaymentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeletePaymentResponseToJson(this);
  
}