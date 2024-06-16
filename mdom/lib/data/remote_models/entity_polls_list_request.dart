import 'package:bpc/data/data.dart';
import 'package:bpc/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'entity_polls_list_request.g.dart';

@JsonSerializable()
class MdomTpIntEntityPollsListRequestWrapper {

  @JsonKey(name: 'PS_TP_O_INT')
  final MdomTpIntEntityPollsListRequest psTpInt;

  MdomTpIntEntityPollsListRequestWrapper(this.psTpInt);

  factory MdomTpIntEntityPollsListRequestWrapper.fromJson(Map<String, dynamic> json) => _$MdomTpIntEntityPollsListRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() => _$MdomTpIntEntityPollsListRequestWrapperToJson(this);
  
}

@JsonSerializable()
class MdomTpIntEntityPollsListRequest {

  @JsonKey(name: 'EntityPollsListRequest')
  final EntityPollsListRequest request;

  MdomTpIntEntityPollsListRequest(this.request);

  factory MdomTpIntEntityPollsListRequest.fromJson(Map<String, dynamic> json) => _$MdomTpIntEntityPollsListRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MdomTpIntEntityPollsListRequestToJson(this);
  
}

@JsonSerializable(includeIfNull: false)
class EntityPollsListRequest {

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

  @JsonKey(name: 'RowCount')
  final EntityPollsListRequestRowCount? rowCount;

  EntityPollsListRequest({
    required this.terminalId,
    required this.version,
    required this.keyRequest,
    this.lang,
    required this.token,
    this.topic,
    required this.status,
    required this.stopDateFrom,
    required this.stopDateTo,
    this.rowCount,
  });

  factory EntityPollsListRequest.fromJson(Map<String, dynamic> json) => _$EntityPollsListRequestFromJson(json);

  Map<String, dynamic> toJson() => _$EntityPollsListRequestToJson(this);
  
}

@JsonSerializable(includeIfNull: false)
class EntityPollsListRequestRowCount {

  @JsonKey(name: 'evalue')
  final int evalue;

  @JsonKey(name: '@PollId')
  final int? pollId;

  const EntityPollsListRequestRowCount({
    required this.evalue,
    this.pollId,
  });

  factory EntityPollsListRequestRowCount.fromJson(Map<String, dynamic> json) => _$EntityPollsListRequestRowCountFromJson(json);

  Map<String, dynamic> toJson() => _$EntityPollsListRequestRowCountToJson(this);
  
}
