// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'confirm_payment_method_response.g.dart';

@JsonSerializable()
class PsHelppayConfirmPaymentMethodResponseWrapper {
  @JsonKey(name: 'PS_HELPPAY')
  final PsHelppayConfirmPaymentMethodResponse psHelpPay;

  PsHelppayConfirmPaymentMethodResponseWrapper(this.psHelpPay);

  factory PsHelppayConfirmPaymentMethodResponseWrapper.fromJson(
          Map<String, dynamic> json) =>
      _$PsHelppayConfirmPaymentMethodResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PsHelppayConfirmPaymentMethodResponseWrapperToJson(this);
}

@JsonSerializable()
class PsHelppayConfirmPaymentMethodResponse {
  @JsonKey(name: 'ConfirmPayMeanResponse')
  final ConfirmPaymentMethodResponse response;

  PsHelppayConfirmPaymentMethodResponse(this.response);

  factory PsHelppayConfirmPaymentMethodResponse.fromJson(
          Map<String, dynamic> json) =>
      _$PsHelppayConfirmPaymentMethodResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PsHelppayConfirmPaymentMethodResponseToJson(this);
}

@JsonSerializable(includeIfNull: false)
class ConfirmPaymentMethodResponse {
  @JsonKey(name: 'ErrorCode')
  final int errorCode;

  @JsonKey(name: 'ErrorText')
  final String? errorText;

  @JsonKey(name: 'CardId')
  final int? cardId;

  @JsonKey(name: 'CardPAN')
  final String? cardPan;


  ConfirmPaymentMethodResponse({
    required this.errorCode,
    this.errorText,
    this.cardId,
    this.cardPan,
  });

  factory ConfirmPaymentMethodResponse.fromJson(Map<String, dynamic> json) =>
      _$ConfirmPaymentMethodResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmPaymentMethodResponseToJson(this);
}
