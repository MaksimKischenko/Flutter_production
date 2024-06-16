import 'package:json_annotation/json_annotation.dart';

part 'companies_request.g.dart';

@JsonSerializable()
class MdomCompaniesRequestWrapper {

  @JsonKey(name: 'TPInfoRequest')
  final MdomCompaniesRequest request;

  MdomCompaniesRequestWrapper(this.request);

  factory MdomCompaniesRequestWrapper.fromJson(Map<String, dynamic> json) => _$MdomCompaniesRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$MdomCompaniesRequestWrapperToJson(this);
  
}

@JsonSerializable(includeIfNull: false)
class MdomCompaniesRequest {

  @JsonKey(name: 'RequestType')
  final String requestType;

  @JsonKey(name: 'TerminalId')
  final String terminalId;

  @JsonKey(name: 'Version')
  final String version;

  @JsonKey(name: 'Token')
  final String token;

  @JsonKey(name: 'Lang')
  final String? lang;

  MdomCompaniesRequest({
    required this.terminalId,
    required this.version,
    required this.token,
    this.lang,
    this.requestType = 'Companies'
  });

  factory MdomCompaniesRequest.fromJson(Map<String, dynamic> json) => _$MdomCompaniesRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MdomCompaniesRequestToJson(this);
  
}