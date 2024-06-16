// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:helppay_core/data/remote_models/common_models/common_models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_qr_request_status_request.g.dart';

@JsonSerializable()
class PsHelpPayQRRequestStatusRequestWrapper {
  @JsonKey(name: 'PS_HELPPAY')
  final PsHelpPayQRRequestStatusRequest psErip;

  PsHelpPayQRRequestStatusRequestWrapper(this.psErip);

  factory PsHelpPayQRRequestStatusRequestWrapper.fromJson(
          Map<String, dynamic> json) =>
      _$PsHelpPayQRRequestStatusRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PsHelpPayQRRequestStatusRequestWrapperToJson(this);
}

@JsonSerializable()
class PsHelpPayQRRequestStatusRequest {
  @JsonKey(name: 'GetReqIdStatusRequest')
  final QRRequestStatusRequest request;

  PsHelpPayQRRequestStatusRequest(this.request);

  factory PsHelpPayQRRequestStatusRequest.fromJson(Map<String, dynamic> json) =>
      _$PsHelpPayQRRequestStatusRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PsHelpPayQRRequestStatusRequestToJson(this);
}

@JsonSerializable()
class QRRequestStatusRequest {
  @JsonKey(name: 'TerminalID')
  final RegPayMinTerminalID terminalID;

  @JsonKey(name: 'Version')
  final int version;

  @JsonKey(name: 'TypePAN')
  final String typePan;

  @JsonKey(name: 'PAN')
  final QrPan pan;

  @JsonKey(name: 'RequestId')
  final int requestId;

  QRRequestStatusRequest({
    required this.terminalID,
    required this.version,
    required this.typePan,
    required this.pan,
    required this.requestId,
  });

  factory QRRequestStatusRequest.fromJson(Map<String, dynamic> json) =>
      _$QRRequestStatusRequestFromJson(json);

  Map<String, dynamic> toJson() => _$QRRequestStatusRequestToJson(this);
}
