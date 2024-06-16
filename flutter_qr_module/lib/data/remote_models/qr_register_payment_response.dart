// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'qr_register_payment_response.g.dart';

@JsonSerializable()
class PsHelppayQrRegisterPaymentResponseWrapper {
  @JsonKey(name: 'PS_HELPPAY')
  final PsHelppayQrRegisterPaymentResponse psHelpPay;

  PsHelppayQrRegisterPaymentResponseWrapper(this.psHelpPay);

  factory PsHelppayQrRegisterPaymentResponseWrapper.fromJson(
          Map<String, dynamic> json) =>
      _$PsHelppayQrRegisterPaymentResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PsHelppayQrRegisterPaymentResponseWrapperToJson(this);
}

@JsonSerializable()
class PsHelppayQrRegisterPaymentResponse {
  @JsonKey(name: 'RegisterPaymentResponse')
  final QrRegisterPaymentResponse response;

  PsHelppayQrRegisterPaymentResponse(this.response);

  factory PsHelppayQrRegisterPaymentResponse.fromJson(
          Map<String, dynamic> json) =>
      _$PsHelppayQrRegisterPaymentResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PsHelppayQrRegisterPaymentResponseToJson(this);
}

@JsonSerializable(includeIfNull: false)
class QrRegisterPaymentResponse {
  // @JsonKey(name: 'TerminalID')
  // final QrTerminalID terminalID;

  // @JsonKey(name: 'Version')
  // final int version;

  // @JsonKey(name: 'TypePAN')
  // final String typePan;

  // @JsonKey(name: 'PAN')
  // final QrPan pan;

  @JsonKey(name: 'KioskReceipt')
  final String? kioskReciept;

  @JsonKey(name: 'PayRecord')
  final PayRecord payRecord;

  @JsonKey(name: 'ErrorCode')
  final int errorCode;

  @JsonKey(name: 'ErrorText')
  final String? errorText;

  QrRegisterPaymentResponse({
    // required this.terminalID,
    // required this.version,
    // required this.typePan,
    // required this.pan,
    required this.kioskReciept,
    required this.payRecord,
    required this.errorCode,
    this.errorText,
  });

  factory QrRegisterPaymentResponse.fromJson(Map<String, dynamic> json) =>
      _$QrRegisterPaymentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$QrRegisterPaymentResponseToJson(this);
}

@JsonSerializable(includeIfNull: true)
class PayRecord {
  @JsonKey(name: 'PaymentID')
  final int paymentId;

  @JsonKey(name: 'Summa')
  final double paymentSum;

  @JsonKey(name: 'Currency')
  final int currency;

  @JsonKey(name: 'Date')
  final String paymentDate;

  PayRecord({
    required this.paymentSum,
    required this.currency,
    required this.paymentId,
    required this.paymentDate,
  });

  factory PayRecord.fromJson(Map<String, dynamic> json) =>
      _$PayRecordFromJson(json);

  Map<String, dynamic> toJson() => _$PayRecordToJson(this);
}
