// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:helppay_core/data/remote_models/common_models/common_models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_qr_request.g.dart';

@JsonSerializable()
class PsHelppayGetQrRequestWrapper {
  @JsonKey(name: 'PS_HELPPAY')
  final PsHelppayGetQrRequest psErip;

  PsHelppayGetQrRequestWrapper(this.psErip);

  factory PsHelppayGetQrRequestWrapper.fromJson(Map<String, dynamic> json) =>
      _$PsHelppayGetQrRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$PsHelppayGetQrRequestWrapperToJson(this);
}

@JsonSerializable()
class PsHelppayGetQrRequest {
  @JsonKey(name: 'GetQRRequest')
  final GetQrRequest request;

  PsHelppayGetQrRequest(this.request);

  factory PsHelppayGetQrRequest.fromJson(Map<String, dynamic> json) =>
      _$PsHelppayGetQrRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PsHelppayGetQrRequestToJson(this);
}

@JsonSerializable(includeIfNull: false)
class GetQrRequest {
  @JsonKey(name: 'TerminalID')
  final RegPayMinTerminalID terminalID;

  @JsonKey(name: 'Version')
  final int version;

  @JsonKey(name: 'TypePAN')
  final String typePan;

  @JsonKey(name: 'PAN')
  final QrPan pan;

  @JsonKey(name: 'RestSum')
  final double restSum;

  @JsonKey(name: 'PaySum')
  final double? paymentSum; //TODO must be >0 or null

  GetQrRequest({
    required this.terminalID,
    required this.version,
    required this.typePan,
    required this.pan,
    required this.restSum,
    this.paymentSum,
  });

  factory GetQrRequest.fromJson(Map<String, dynamic> json) =>
      _$GetQrRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetQrRequestToJson(this);
}
