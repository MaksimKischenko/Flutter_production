// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';

part 'register_payment_method_response.g.dart';

@JsonSerializable()
class PsHelppayRegisterPaymentMethodResponseWrapper {
  @JsonKey(name: 'PS_HELPPAY')
  final PsHelppayRegisterPaymentMethodResponse psHelpPay;

  PsHelppayRegisterPaymentMethodResponseWrapper(this.psHelpPay);

  factory PsHelppayRegisterPaymentMethodResponseWrapper.fromJson(
          Map<String, dynamic> json) =>
      _$PsHelppayRegisterPaymentMethodResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PsHelppayRegisterPaymentMethodResponseWrapperToJson(this);
}

@JsonSerializable()
class PsHelppayRegisterPaymentMethodResponse {
  @JsonKey(name: 'RegPayMeanResponse')
  final RegisterPaymentMethodResponse? response;

  PsHelppayRegisterPaymentMethodResponse(this.response);

  factory PsHelppayRegisterPaymentMethodResponse.fromJson(
          Map<String, dynamic> json) =>
      _$PsHelppayRegisterPaymentMethodResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PsHelppayRegisterPaymentMethodResponseToJson(this);
}

@JsonSerializable(includeIfNull: false)
class RegisterPaymentMethodResponse {
  @JsonKey(name: 'ErrorCode')
  final int errorCode;

  @JsonKey(name: 'ErrorText')
  final String? errorText;

  @JsonKey(name: 'RequestId')
  final int? requestId;

  @JsonKey(name: 'Card')
  final List<CardPayment>? card;

  @JsonKey(name: 'NeedMCI')
  final int? needMCI;

  RegisterPaymentMethodResponse({
    required this.errorCode,
    this.errorText,
    required this.requestId,
    this.card,
    this.needMCI,
  });

  factory RegisterPaymentMethodResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterPaymentMethodResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterPaymentMethodResponseToJson(this);

  @override
  String toString() => 'RegisterPaymentMethodResponse(errorCode: $errorCode, errorText: $errorText, requestId: $requestId, card: $card, needMCI: $needMCI)';
}


@JsonSerializable(includeIfNull: false)
class CardPayment {

  @JsonKey(name: 'CardId')
  final int cardId;

  @JsonKey(name: 'PANMask')
  final String panMask;

  @JsonKey(name: 'CardName')
  final String? cardName;

  @JsonKey(name: 'ContractKind')
  final int contractKind;
  
  CardPayment({
    required this.cardId,
    required this.panMask,
    required this.contractKind,
    required this.cardName
  });

  factory CardPayment.fromJson(Map<String, dynamic> json) =>
      _$CardPaymentFromJson(json);

  Map<String, dynamic> toJson() => _$CardPaymentToJson(this);

  @override
  String toString() => 'CardPayment(cardId: $cardId, panMask: $panMask, cardName: $cardName, contractKind: $contractKind)';
}
