import 'package:helppay_core/data/data.dart';
import 'package:helppay_core/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'individual_polls_list_request.g.dart';

@JsonSerializable()
class MdomTpIntIndividualPollsListRequestWrapper {

  @JsonKey(name: 'PS_TP_O_INT')
  final MdomTpIntIndividualPollsListRequest psTpInt;

  MdomTpIntIndividualPollsListRequestWrapper(this.psTpInt);

  factory MdomTpIntIndividualPollsListRequestWrapper.fromJson(Map<String, dynamic> json) => _$MdomTpIntIndividualPollsListRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$MdomTpIntIndividualPollsListRequestWrapperToJson(this);
  
}

@JsonSerializable()
class MdomTpIntIndividualPollsListRequest {

  @JsonKey(name: 'IndividualPollsListRequest')
  final IndividualPollsListRequest request;

  MdomTpIntIndividualPollsListRequest(this.request);

  factory MdomTpIntIndividualPollsListRequest.fromJson(Map<String, dynamic> json) => _$MdomTpIntIndividualPollsListRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MdomTpIntIndividualPollsListRequestToJson(this);
  
}

@JsonSerializable(includeIfNull: false)
class IndividualPollsListRequest {

  // general part

  @JsonKey(name: 'TerminalId')
  final MdomTpIntTerminalId terminalId;

  @JsonKey(name: 'Version')
  final String version;

  @JsonKey(name: 'KeyRequest')
  final int keyRequest;

  @JsonKey(name: 'Lang')
  final String? lang;

  @JsonKey(name: 'Token')
  final String token;

  // general part END

  @JsonKey(name: 'Topic')
  final String? topic;

  @JsonKey(name: 'Status')
  final PollStatus status;

  @JsonKey(name: 'StopDateFrom')
  final String stopDateFrom;

  @JsonKey(name: 'StopDateTo')
  final String stopDateTo;

  @JsonKey(name: 'SupplierId')
  final int? supplierId;

  @JsonKey(name: 'RowCount')
  final IndividualPollsListRequestRowCount? rowCount;

  IndividualPollsListRequest({
    required this.terminalId,
    required this.version,
    required this.keyRequest,
    this.lang,
    required this.token,
    this.topic,
    required this.status,
    required this.stopDateFrom,
    required this.stopDateTo,
    this.supplierId,
    this.rowCount,
  });

  factory IndividualPollsListRequest.fromJson(Map<String, dynamic> json) => _$IndividualPollsListRequestFromJson(json);

  Map<String, dynamic> toJson() => _$IndividualPollsListRequestToJson(this);
  
}

@JsonSerializable(includeIfNull: false)
class IndividualPollsListRequestRowCount {

  @JsonKey(name: 'evalue')
  final int evalue;

  @JsonKey(name: '@PollId')
  final int? pollId;

  const IndividualPollsListRequestRowCount({
    required this.evalue,
    this.pollId,
  });

  factory IndividualPollsListRequestRowCount.fromJson(Map<String, dynamic> json) => _$IndividualPollsListRequestRowCountFromJson(json);

  Map<String, dynamic> toJson() => _$IndividualPollsListRequestRowCountToJson(this);
  
}
