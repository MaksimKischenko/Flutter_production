import 'package:json_annotation/json_annotation.dart';

import 'common_models/common_models.dart';

part 'get_qr_operations_request.g.dart';

@JsonSerializable()
class PsHelpPayQROperationRequestWrapper {
  @JsonKey(name: 'PS_HELPPAY')
  final PsHelpPayQROperationRequest psErip;

  PsHelpPayQROperationRequestWrapper(this.psErip);

  factory PsHelpPayQROperationRequestWrapper.fromJson(
          Map<String, dynamic> json) =>
      _$PsHelpPayQROperationRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PsHelpPayQROperationRequestWrapperToJson(this);
}

@JsonSerializable()
class PsHelpPayQROperationRequest {
  @JsonKey(name: 'GetQROperationRequest')
  final GetQROperationRequest request;

  PsHelpPayQROperationRequest(this.request);

  factory PsHelpPayQROperationRequest.fromJson(Map<String, dynamic> json) =>
      _$PsHelpPayQROperationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PsHelpPayQROperationRequestToJson(this);
}

@JsonSerializable()
class GetQROperationRequest {
  @JsonKey(name: 'TerminalID')
  final RegPayMinTerminalID terminalID;

  @JsonKey(name: 'Version')
  final int version;

  @JsonKey(name: 'TypePAN')
  final String typePan;

  @JsonKey(name: 'PAN')
  final QrPan pan;

  @JsonKey(name: 'Filter')
  final OperationFilter filter;

  GetQROperationRequest({
    required this.terminalID,
    required this.version,
    required this.typePan,
    required this.pan,
    required this.filter,
  });

  factory GetQROperationRequest.fromJson(Map<String, dynamic> json) =>
      _$GetQROperationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetQROperationRequestToJson(this);
}

@JsonSerializable()
class OperationFilter {
  @JsonKey(name: 'DateFrom')
  final String dateFrom;

  @JsonKey(name: 'DateTo')
  final String dateTo;

  OperationFilter({
    required this.dateFrom,
    required this.dateTo,
  });

  factory OperationFilter.fromJson(Map<String, dynamic> json) =>
      _$OperationFilterFromJson(json);

  Map<String, dynamic> toJson() => _$OperationFilterToJson(this);
}
