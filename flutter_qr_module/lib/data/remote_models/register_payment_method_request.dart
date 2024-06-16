import 'package:json_annotation/json_annotation.dart';

import 'common_models/common_models.dart';

part 'register_payment_method_request.g.dart';

@JsonSerializable()
class PsHelppayRegisterPaymentMethodRequestWrapper {
  @JsonKey(name: 'PS_HELPPAY')
  final PsHelppayRegisterPaymentMethodRequest psErip;

  PsHelppayRegisterPaymentMethodRequestWrapper(this.psErip);

  factory PsHelppayRegisterPaymentMethodRequestWrapper.fromJson(
          Map<String, dynamic> json) =>
      _$PsHelppayRegisterPaymentMethodRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PsHelppayRegisterPaymentMethodRequestWrapperToJson(this);
}

@JsonSerializable()
class PsHelppayRegisterPaymentMethodRequest {
  @JsonKey(name: 'RegPayMeanRequest')
  final RegisterPaymentMethodRequest request;

  PsHelppayRegisterPaymentMethodRequest(this.request);

  factory PsHelppayRegisterPaymentMethodRequest.fromJson(
          Map<String, dynamic> json) =>
      _$PsHelppayRegisterPaymentMethodRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PsHelppayRegisterPaymentMethodRequestToJson(this);
}

@JsonSerializable(includeIfNull: false)
class RegisterPaymentMethodRequest {
  @JsonKey(name: 'TerminalID')
  final RegPayMinTerminalID terminalID;

  @JsonKey(name: 'Version')
  final int version;

  @JsonKey(name: 'TypePAN')
  final String typePan;

  @JsonKey(name: 'PAN')
  final QrPan? pan;

  @JsonKey(name: 'CardEmissionParam')
  final CardEmissionParam? cardEmissionParam;

  RegisterPaymentMethodRequest({
    required this.terminalID,
    required this.version,
    required this.typePan,
    required this.pan,
    this.cardEmissionParam,
  });

  factory RegisterPaymentMethodRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterPaymentMethodRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterPaymentMethodRequestToJson(this);
}

@JsonSerializable(includeIfNull: false)
class CardEmissionParam {
  @JsonKey(name: 'PhoneNumber')
  final String phoneNumber;

  @JsonKey(name: 'AttemptNumber')
  final int? attemptNumber;

  @JsonKey(name: 'BankId')
  final int bankId;

  @JsonKey(name: 'ContractKind')
  final int? contractKind;

  @JsonKey(name: 'PersonalNumber')
  final String? personalNumber;

  @JsonKey(name: 'RequestId')
  final String? requestId;

  @JsonKey(name: 'CardId')
  final String? cardId;

  CardEmissionParam({
    required this.phoneNumber,
    required this.bankId, 
    this.attemptNumber,
    this.contractKind,
    this.personalNumber,
    this.requestId,
    this.cardId,
  });

  factory CardEmissionParam.fromJson(Map<String, dynamic> json) =>
      _$CardEmissionParamFromJson(json);

  Map<String, dynamic> toJson() => _$CardEmissionParamToJson(this);
}
