// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';

part 'get_qr_request_status_response.g.dart';

@JsonSerializable()
class PsHelpPayQRRequestStatusWrapper {
  @JsonKey(name: 'PS_HELPPAY')
  final PsHelpPayQRRequestStatusResponse psErip;

  PsHelpPayQRRequestStatusWrapper(this.psErip);

  factory PsHelpPayQRRequestStatusWrapper.fromJson(Map<String, dynamic> json) =>
      _$PsHelpPayQRRequestStatusWrapperFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PsHelpPayQRRequestStatusWrapperToJson(this);
}

@JsonSerializable()
class PsHelpPayQRRequestStatusResponse {
  @JsonKey(name: 'GetReqIdStatusResponse')
  final QRRequestStatusResponse response;

  PsHelpPayQRRequestStatusResponse(this.response);

  factory PsHelpPayQRRequestStatusResponse.fromJson(
          Map<String, dynamic> json) =>
      _$PsHelpPayQRRequestStatusResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PsHelpPayQRRequestStatusResponseToJson(this);
}

@JsonSerializable()
class QRRequestStatusResponse {
  @JsonKey(name: 'ErrorCode')
  final int errorCode;

  @JsonKey(name: 'ErrorText')
  final String? errorText;

  @JsonKey(name: 'Status')
  final int status;
  @JsonKey(name: 'RequestPaySum')
  final double?
      finalPaymentSum; // sum of check which must be compared with bankSumLimit from QrResponse

  @JsonKey(name: 'StatusDescription')
  final String? statusDescription;
  QRRequestStatusResponse({
    required this.errorCode,
    this.errorText,
    this.finalPaymentSum,
    required this.status,
    this.statusDescription,
  });

  factory QRRequestStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$QRRequestStatusResponseFromJson(json);

  Map<String, dynamic> toJson() => _$QRRequestStatusResponseToJson(this);
}
