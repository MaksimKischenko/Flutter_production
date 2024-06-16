import 'package:json_annotation/json_annotation.dart';

part 'account_statement_request.g.dart';

@JsonSerializable()
class MdomAccountStatementRequestWrapper {

  @JsonKey(name: 'TPInfoRequest')
  final MdomAccountStatementRequest request;

  MdomAccountStatementRequestWrapper(this.request);

  factory MdomAccountStatementRequestWrapper.fromJson(Map<String, dynamic> json) => _$MdomAccountStatementRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$MdomAccountStatementRequestWrapperToJson(this);
  
}

@JsonSerializable(includeIfNull: false)
class MdomAccountStatementRequest {

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

  @JsonKey(name: 'PeriodFrom')
  final String periodFrom;

  @JsonKey(name: 'PeriodTo')
  final String periodTo;

  @JsonKey(name: 'SupplierId')
  final int supplierId;

  @JsonKey(name: 'Account')
  final String account;

  MdomAccountStatementRequest({
    this.requestType = 'AccountStatement',
    required this.terminalId,
    required this.version,
    required this.token,
    this.lang,
    required this.periodFrom,
    required this.periodTo,
    required this.supplierId,
    required this.account
  });

  factory MdomAccountStatementRequest.fromJson(Map<String, dynamic> json) => _$MdomAccountStatementRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MdomAccountStatementRequestToJson(this);
  
}