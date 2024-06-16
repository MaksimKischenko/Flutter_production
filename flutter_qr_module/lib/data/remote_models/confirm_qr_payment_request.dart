
import 'package:json_annotation/json_annotation.dart';

import 'common_models/common_models.dart';

part 'confirm_qr_payment_request.g.dart';

@JsonSerializable()
class PsHelppayConfirmQrPaymentRequestWrapper {
  @JsonKey(name: 'PS_HELPPAY')
  final PsHelppayConfirmQrPaymentRequest psErip;

  PsHelppayConfirmQrPaymentRequestWrapper(this.psErip);

  factory PsHelppayConfirmQrPaymentRequestWrapper.fromJson(
          Map<String, dynamic> json) =>
      _$PsHelppayConfirmQrPaymentRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PsHelppayConfirmQrPaymentRequestWrapperToJson(this);
}

@JsonSerializable()
class PsHelppayConfirmQrPaymentRequest {
  @JsonKey(name: 'ConfirmQRPaymentRequest')
  final ConfirmQrPaymentRequest request;

  PsHelppayConfirmQrPaymentRequest(this.request);

  factory PsHelppayConfirmQrPaymentRequest.fromJson(
          Map<String, dynamic> json) =>
      _$PsHelppayConfirmQrPaymentRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PsHelppayConfirmQrPaymentRequestToJson(this);
}

@JsonSerializable(includeIfNull: false)
class ConfirmQrPaymentRequest {
  @JsonKey(name: 'TerminalID')
  final RegPayMinTerminalID terminalID;

  @JsonKey(name: 'Version')
  final int version;

  @JsonKey(name: 'TypePAN')
  final String typePan;

  @JsonKey(name: 'PAN')
  final QrPan pan;

  @JsonKey(name: 'RequestId')
  final QrRequestId requestId;

  ConfirmQrPaymentRequest({
    required this.terminalID,
    required this.version,
    required this.typePan,
    required this.pan,
    required this.requestId,
  });

  factory ConfirmQrPaymentRequest.fromJson(Map<String, dynamic> json) =>
      _$ConfirmQrPaymentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmQrPaymentRequestToJson(this);
}

@JsonSerializable(includeIfNull: true)
class QrRequestId {
  @JsonKey(name: 'Value')
  final int evalue;

  @JsonKey(name: 'OTPCode')
  final int? otpCode;

  @JsonKey(name: 'ConfirmCode')
  final int confirmCode;

  QrRequestId({
    required this.evalue,
    required this.otpCode,
    required this.confirmCode,
  });

  factory QrRequestId.fromJson(Map<String, dynamic> json) =>
      _$QrRequestIdFromJson(json);

  Map<String, dynamic> toJson() => _$QrRequestIdToJson(this);
}
