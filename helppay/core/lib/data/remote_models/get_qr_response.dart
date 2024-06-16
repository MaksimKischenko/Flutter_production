// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';

part 'get_qr_response.g.dart';

@JsonSerializable()
class PsHelppayGetQrResponseWrapper {
  @JsonKey(name: 'PS_HELPPAY')
  final PsHelppayGetQrResponse psErip;

  PsHelppayGetQrResponseWrapper(this.psErip);

  factory PsHelppayGetQrResponseWrapper.fromJson(Map<String, dynamic> json) =>
      _$PsHelppayGetQrResponseWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$PsHelppayGetQrResponseWrapperToJson(this);
}

@JsonSerializable()
class PsHelppayGetQrResponse {
  @JsonKey(name: 'GetQRResponse')
  final GetQrResponse response;

  PsHelppayGetQrResponse(this.response);

  factory PsHelppayGetQrResponse.fromJson(Map<String, dynamic> json) =>
      _$PsHelppayGetQrResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PsHelppayGetQrResponseToJson(this);
}

@JsonSerializable(includeIfNull: false)
class GetQrResponse {
  @JsonKey(name: 'ErrorCode')
  final int errorCode;

  @JsonKey(name: 'ErrorText')
  final String? errorText;

  @JsonKey(name: 'QRCode')
  final Map<String, dynamic>? qrCode;

  @JsonKey(name: 'PaySumWithOTP')
  final double?
      agregatorSumLimit; //sum limit for payment without entering otp code

  @JsonKey(name: 'QRValidity')
  final int? qrCodeLifetime;

  GetQrResponse({
    required this.errorCode,
    this.errorText,
    this.agregatorSumLimit,
    required this.qrCode,
    required this.qrCodeLifetime,
  });

  factory GetQrResponse.fromJson(Map<String, dynamic> json) =>
      _$GetQrResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetQrResponseToJson(this);
}
