// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'confirm_qr_payment_response.g.dart';

@JsonSerializable()
class PsHelppayConfirmQrPaymentResponseWrapper {
  @JsonKey(name: 'PS_HELPPAY')
  final PsHelppayConfirmQrPaymentResponse psErip;

  PsHelppayConfirmQrPaymentResponseWrapper(this.psErip);

  factory PsHelppayConfirmQrPaymentResponseWrapper.fromJson(
          Map<String, dynamic> json) =>
      _$PsHelppayConfirmQrPaymentResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PsHelppayConfirmQrPaymentResponseWrapperToJson(this);
}

@JsonSerializable()
class PsHelppayConfirmQrPaymentResponse {
  @JsonKey(name: 'ConfirmQRPaymentResponse')
  final ConfirmQrPaymentResponse response;

  PsHelppayConfirmQrPaymentResponse(this.response);

  factory PsHelppayConfirmQrPaymentResponse.fromJson(
          Map<String, dynamic> json) =>
      _$PsHelppayConfirmQrPaymentResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PsHelppayConfirmQrPaymentResponseToJson(this);
}

@JsonSerializable(includeIfNull: false)
class ConfirmQrPaymentResponse {
  @JsonKey(name: 'ErrorCode')
  final int errorCode;

  @JsonKey(name: 'ErrorText')
  final String? errorText;

  ConfirmQrPaymentResponse({
    required this.errorCode,
    this.errorText,
  });

  factory ConfirmQrPaymentResponse.fromJson(Map<String, dynamic> json) =>
      _$ConfirmQrPaymentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmQrPaymentResponseToJson(this);
}
