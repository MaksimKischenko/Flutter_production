// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entity_polls_list_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MdomTpIntEntityPollsListRequestWrapper
    _$MdomTpIntEntityPollsListRequestWrapperFromJson(
            Map<String, dynamic> json) =>
        MdomTpIntEntityPollsListRequestWrapper(
          MdomTpIntEntityPollsListRequest.fromJson(
              json['PS_TP_O_INT'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$MdomTpIntEntityPollsListRequestWrapperToJson(
        MdomTpIntEntityPollsListRequestWrapper instance) =>
    <String, dynamic>{
      'PS_TP_O_INT': instance.psTpInt,
    };

MdomTpIntEntityPollsListRequest _$MdomTpIntEntityPollsListRequestFromJson(
        Map<String, dynamic> json) =>
    MdomTpIntEntityPollsListRequest(
      EntityPollsListRequest.fromJson(
          json['EntityPollsListRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomTpIntEntityPollsListRequestToJson(
        MdomTpIntEntityPollsListRequest instance) =>
    <String, dynamic>{
      'EntityPollsListRequest': instance.request,
    };

EntityPollsListRequest _$EntityPollsListRequestFromJson(
        Map<String, dynamic> json) =>
    EntityPollsListRequest(
      terminalId: MdomTpIntTerminalId.fromJson(
          json['TerminalId'] as Map<String, dynamic>),
      version: json['Version'] as String,
      keyRequest: json['KeyRequest'] as int,
      lang: json['Lang'] as String?,
      token: json['Token'] as String,
      topic: json['Topic'] as String?,
      status: $enumDecode(_$PollStatusEnumMap, json['Status']),
      stopDateFrom: json['StopDateFrom'] as String,
      stopDateTo: json['StopDateTo'] as String,
      rowCount: json['RowCount'] == null
          ? null
          : EntityPollsListRequestRowCount.fromJson(
              json['RowCount'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EntityPollsListRequestToJson(
    EntityPollsListRequest instance) {
  final val = <String, dynamic>{
    'TerminalId': instance.terminalId,
    'Version': instance.version,
    'KeyRequest': instance.keyRequest,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Lang', instance.lang);
  val['Token'] = instance.token;
  writeNotNull('Topic', instance.topic);
  val['Status'] = _$PollStatusEnumMap[instance.status]!;
  val['StopDateFrom'] = instance.stopDateFrom;
  val['StopDateTo'] = instance.stopDateTo;
  writeNotNull('RowCount', instance.rowCount);
  return val;
}

const _$PollStatusEnumMap = {
  PollStatus.all: 0,
  PollStatus.draft: -1,
  PollStatus.canceled: -2,
  PollStatus.publication: -3,
  PollStatus.inProgress: 1,
  PollStatus.completed: 2,
};

EntityPollsListRequestRowCount _$EntityPollsListRequestRowCountFromJson(
        Map<String, dynamic> json) =>
    EntityPollsListRequestRowCount(
      evalue: json['evalue'] as int,
      pollId: json['@PollId'] as int?,
    );

Map<String, dynamic> _$EntityPollsListRequestRowCountToJson(
    EntityPollsListRequestRowCount instance) {
  final val = <String, dynamic>{
    'evalue': instance.evalue,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('@PollId', instance.pollId);
  return val;
}
