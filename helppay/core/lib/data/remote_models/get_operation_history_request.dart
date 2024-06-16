import 'package:json_annotation/json_annotation.dart';

part 'get_operation_history_request.g.dart';

@JsonSerializable()
class PsEripGetOperationHistoryRequestWrapper {

  @JsonKey(name: 'PS_ERIP')
  final PsEripGetOperationHistoryRequest psErip;

  PsEripGetOperationHistoryRequestWrapper(this.psErip);

  factory PsEripGetOperationHistoryRequestWrapper.fromJson(Map<String, dynamic> json) => _$PsEripGetOperationHistoryRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$PsEripGetOperationHistoryRequestWrapperToJson(this);
  
}

@JsonSerializable()
class PsEripGetOperationHistoryRequest {

  @JsonKey(name: 'GetOperationHistoryRequest')
  final GetOperationHistoryRequest request;

  PsEripGetOperationHistoryRequest(this.request);

  factory PsEripGetOperationHistoryRequest.fromJson(Map<String, dynamic> json) => _$PsEripGetOperationHistoryRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PsEripGetOperationHistoryRequestToJson(this);
  
}

@JsonSerializable(includeIfNull: false)
class GetOperationHistoryRequest {

  @JsonKey(name: 'TerminalID')
  final String terminalID;

  @JsonKey(name: 'Version')
  final int version;

  @JsonKey(name: 'Token')
  final String token;

  @JsonKey(name: 'SourceId')
  final GetOperationHistoryRequestSourceId sourceId;

  @JsonKey(name: 'RequestTerminalID')
  final String? requestTerminalID;

  @JsonKey(name: 'Filter')
  final GetOperationHistoryRequestFilter? filter;

  GetOperationHistoryRequest({
    required this.terminalID,
    required this.version,
    required this.token,
    required this.sourceId,
    this.requestTerminalID,
    this.filter
  });

  factory GetOperationHistoryRequest.fromJson(Map<String, dynamic> json) => _$GetOperationHistoryRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetOperationHistoryRequestToJson(this);
  
}

@JsonSerializable()
class GetOperationHistoryRequestSourceId {

  @JsonKey(name: 'evalue')
  final String evalue;

  @JsonKey(name: '@Type')
  final String type;

  GetOperationHistoryRequestSourceId({
    required this.evalue,
    required this.type
  });

  factory GetOperationHistoryRequestSourceId.fromJson(Map<String, dynamic> json) => _$GetOperationHistoryRequestSourceIdFromJson(json);

  Map<String, dynamic> toJson() => _$GetOperationHistoryRequestSourceIdToJson(this);
  
}

@JsonSerializable(includeIfNull: false)
class GetOperationHistoryRequestFilter {

  @JsonKey(name: '@DateFrom')
  final String dateFrom;

  @JsonKey(name: '@DateTo')
  final String dateTo;

  @JsonKey(name: '@Amount')
  final double? amount;

  @JsonKey(name: '@PayName')
  final String? payName;

  @JsonKey(name: '@ListSize')
  final int? listSize;

  @JsonKey(name: '@LastPaymentId')
  final int? lastPaymentId;

  @JsonKey(name: '@PayCode')
  final int? payCode;

  @JsonKey(name: '@LS')
  final String? ls;

  @JsonKey(name: '@PayCurrency')
  final int? payCurrency;

  GetOperationHistoryRequestFilter({
    required this.dateFrom,
    required this.dateTo,
    this.amount,
    this.payName,
    this.listSize,
    this.lastPaymentId,
    this.payCode,
    this.ls,
    this.payCurrency
  });

  factory GetOperationHistoryRequestFilter.fromJson(Map<String, dynamic> json) => _$GetOperationHistoryRequestFilterFromJson(json);

  Map<String, dynamic> toJson() => _$GetOperationHistoryRequestFilterToJson(this);
  
}