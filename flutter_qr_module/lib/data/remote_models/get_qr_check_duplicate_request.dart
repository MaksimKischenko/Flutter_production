import 'package:json_annotation/json_annotation.dart';

import 'common_models/common_models.dart';

part 'get_qr_check_duplicate_request.g.dart';

@JsonSerializable()
class PsHelpPayQRCheckDuplicateRequestWrapper {
  @JsonKey(name: 'PS_HELPPAY')
  final PsHelpPayQRCheckDuplicateRequest psErip;

  PsHelpPayQRCheckDuplicateRequestWrapper(this.psErip);

  factory PsHelpPayQRCheckDuplicateRequestWrapper.fromJson(
          Map<String, dynamic> json) =>
      _$PsHelpPayQRCheckDuplicateRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PsHelpPayQRCheckDuplicateRequestWrapperToJson(this);
}

@JsonSerializable()
class PsHelpPayQRCheckDuplicateRequest {
  @JsonKey(name: 'GetQRCheckDuplicateRequest')
  final QRCheckDuplicateRequest request;

  PsHelpPayQRCheckDuplicateRequest(this.request);

  factory PsHelpPayQRCheckDuplicateRequest.fromJson(
          Map<String, dynamic> json) =>
      _$PsHelpPayQRCheckDuplicateRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PsHelpPayQRCheckDuplicateRequestToJson(this);
}

@JsonSerializable(includeIfNull: false)
class QRCheckDuplicateRequest {
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

  @JsonKey(name: 'Advanced')
  final int? advancedInfoRequired;

  QRCheckDuplicateRequest({
    required this.terminalID,
    required this.version,
    required this.typePan,
    required this.pan,
    required this.requestId,
    required this.advancedInfoRequired,
  });

  factory QRCheckDuplicateRequest.fromJson(Map<String, dynamic> json) =>
      _$QRCheckDuplicateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$QRCheckDuplicateRequestToJson(this);
}
