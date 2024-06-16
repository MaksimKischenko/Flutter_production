// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'register_payment_claim_response.g.dart';

@JsonSerializable()
class PsTpORegisterPaymentClaimResponseWrapper {

  @JsonKey(name: 'PS_TP_O')
  final PsTpORegisterPaymentClaimResponse psTpO;

  PsTpORegisterPaymentClaimResponseWrapper(this.psTpO);

  factory PsTpORegisterPaymentClaimResponseWrapper.fromJson(Map<String, dynamic> json) => _$PsTpORegisterPaymentClaimResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$PsTpORegisterPaymentClaimResponseWrapperToJson(this);
  
}

@JsonSerializable()
class PsTpORegisterPaymentClaimResponse {

  @JsonKey(name: 'RegisterPaymentOfClaimResponse')
  final RegisterPaymentOfClaimResponse response;

  PsTpORegisterPaymentClaimResponse(this.response);

  factory PsTpORegisterPaymentClaimResponse.fromJson(Map<String, dynamic> json) => _$PsTpORegisterPaymentClaimResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PsTpORegisterPaymentClaimResponseToJson(this);
  
}

@JsonSerializable(includeIfNull: false)
class RegisterPaymentOfClaimResponse {

  @JsonKey(name: 'PaymentId')
  final int? paymentId;

  @JsonKey(name: 'ErrorCode')
  final int errorCode;

  @JsonKey(name: 'ErrorText')
  final String? errorText;

  RegisterPaymentOfClaimResponse({
    required this.paymentId,
    required this.errorCode,
    this.errorText,
  });

  factory RegisterPaymentOfClaimResponse.fromJson(Map<String, dynamic> json) => _$RegisterPaymentOfClaimResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterPaymentOfClaimResponseToJson(this);
}

