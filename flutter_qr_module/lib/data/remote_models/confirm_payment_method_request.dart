
import 'package:json_annotation/json_annotation.dart';

import 'common_models/common_models.dart';

part 'confirm_payment_method_request.g.dart';

@JsonSerializable()
class PsHelppayConfirmPaymentMethodRequestWrapper {
  @JsonKey(name: 'PS_HELPPAY')
  final PsHelppayConfirmPaymentMethodRequest psErip;

  PsHelppayConfirmPaymentMethodRequestWrapper(this.psErip);

  factory PsHelppayConfirmPaymentMethodRequestWrapper.fromJson(
          Map<String, dynamic> json) =>
      _$PsHelppayConfirmPaymentMethodRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PsHelppayConfirmPaymentMethodRequestWrapperToJson(this);
}

@JsonSerializable()
class PsHelppayConfirmPaymentMethodRequest {
  @JsonKey(name: 'ConfirmPayMeanRequest')
  final ConfirmPaymentMethodRequest request;

  PsHelppayConfirmPaymentMethodRequest(this.request);

  factory PsHelppayConfirmPaymentMethodRequest.fromJson(
          Map<String, dynamic> json) =>
      _$PsHelppayConfirmPaymentMethodRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PsHelppayConfirmPaymentMethodRequestToJson(this);
}

@JsonSerializable(includeIfNull: false)
class ConfirmPaymentMethodRequest {
  @JsonKey(name: 'TerminalID')
  final RegPayMinTerminalID terminalID;

  @JsonKey(name: 'Version')
  final int version;

  @JsonKey(name: 'TypePAN')
  final String typePan;

  @JsonKey(name: 'PAN')
  final QrPan? pan;

  @JsonKey(name: 'RequestId')
  final RequestIdentifier requestId;

  ConfirmPaymentMethodRequest({
    required this.terminalID,
    required this.version,
    required this.typePan,
    required this.pan,
    required this.requestId,
  });

  factory ConfirmPaymentMethodRequest.fromJson(Map<String, dynamic> json) =>
      _$ConfirmPaymentMethodRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmPaymentMethodRequestToJson(this);
}

@JsonSerializable(includeIfNull: false)
class RequestIdentifier {
  @JsonKey(name: 'Value')
  final int evalue;

  @JsonKey(name: 'OTPCode')
  final String? otpCode; //required if confirmCode equal 1

  @JsonKey(name: 'AttemptNumber')
  final int? attemptNumber;

  @JsonKey(name: 'CardId')
  final int? cardId;

  @JsonKey(name: 'ContractKind')
  final int? contractKind;
  

  @JsonKey(name: 'ConfirmCode')
  final int confirmCode; // 0 for decline, 1 for confirm

  RequestIdentifier({
    required this.evalue,
    required this.otpCode,
    required this.confirmCode,
    this.contractKind,
    this.cardId,
    this.attemptNumber,
  });

  factory RequestIdentifier.fromJson(Map<String, dynamic> json) =>
      _$RequestIdentifierFromJson(json);

  Map<String, dynamic> toJson() => _$RequestIdentifierToJson(this);
}
