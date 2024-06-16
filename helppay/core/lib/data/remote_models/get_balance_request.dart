import 'package:helppay_core/data/remote_models/komplat_general_elements.dart';
import 'package:json_annotation/json_annotation.dart';
part 'get_balance_request.g.dart';

@JsonSerializable()
class PsEripGetBalanceRequestWrapper {
  @JsonKey(name: 'PS_ERIP')
  final PsEripGetBalanceRequest request;

  PsEripGetBalanceRequestWrapper(this.request);

  factory PsEripGetBalanceRequestWrapper.fromJson(Map<String, dynamic> json) =>
      _$PsEripGetBalanceRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$PsEripGetBalanceRequestWrapperToJson(this);
}

@JsonSerializable(includeIfNull: false)
class PsEripGetBalanceRequest {
  @JsonKey(name: 'GetBalanceRequest')
  final GetBalanceRequest request;
  PsEripGetBalanceRequest(this.request);
  factory PsEripGetBalanceRequest.fromJson(Map<String, dynamic> json) =>
      _$PsEripGetBalanceRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PsEripGetBalanceRequestToJson(this);
}

@JsonSerializable(includeIfNull: false)
class GetBalanceRequest {
  @JsonKey(name: 'TerminalID')
  final String terminalID;

  @JsonKey(name: 'Version')
  final int version;

  @JsonKey(name: 'DIType')
  final int diType;

  @JsonKey(name: 'PAN')
  final Pan? pan;

  @JsonKey(name: 'TypePAN')
  final TypePan? typePan;

  @JsonKey(name: 'Token')
  final String token;

  @JsonKey(name: 'Currency')
  final int currency;

  @JsonKey(name: 'RequestType')
  final int requestType;

  GetBalanceRequest({
    required this.terminalID,
    required this.version,
    required this.diType,
    this.typePan,
    this.pan,
    required this.token,
    required this.currency,
    required this.requestType,
  });

  factory GetBalanceRequest.fromJson(Map<String, dynamic> json) =>
      _$GetBalanceRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetBalanceRequestToJson(this);
}
