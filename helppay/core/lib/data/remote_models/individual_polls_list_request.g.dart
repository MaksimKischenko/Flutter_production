// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'individual_polls_list_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MdomTpIntIndividualPollsListRequestWrapper
    _$MdomTpIntIndividualPollsListRequestWrapperFromJson(
            Map<String, dynamic> json) =>
        MdomTpIntIndividualPollsListRequestWrapper(
          MdomTpIntIndividualPollsListRequest.fromJson(
              json['PS_TP_O_INT'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$MdomTpIntIndividualPollsListRequestWrapperToJson(
        MdomTpIntIndividualPollsListRequestWrapper instance) =>
    <String, dynamic>{
      'PS_TP_O_INT': instance.psTpInt,
    };

MdomTpIntIndividualPollsListRequest
    _$MdomTpIntIndividualPollsListRequestFromJson(Map<String, dynamic> json) =>
        MdomTpIntIndividualPollsListRequest(
          IndividualPollsListRequest.fromJson(
              json['IndividualPollsListRequest'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$MdomTpIntIndividualPollsListRequestToJson(
        MdomTpIntIndividualPollsListRequest instance) =>
    <String, dynamic>{
      'IndividualPollsListRequest': instance.request,
    };

IndividualPollsListRequest _$IndividualPollsListRequestFromJson(
        Map<String, dynamic> json) =>
    IndividualPollsListRequest(
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
      supplierId: json['SupplierId'] as int?,
      rowCount: json['RowCount'] == null
          ? null
          : IndividualPollsListRequestRowCount.fromJson(
              json['RowCount'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IndividualPollsListRequestToJson(
    IndividualPollsListRequest instance) {
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
  writeNotNull('SupplierId', instance.supplierId);
  writeNotNull('RowCount', instance.rowCount);
  return val;
}

const _$PollStatusEnumMap = {
  PollStatus.all: 0,
  PollStatus.publication: -3,
  PollStatus.inProgress: 1,
  PollStatus.completed: 2,
};

IndividualPollsListRequestRowCount _$IndividualPollsListRequestRowCountFromJson(
        Map<String, dynamic> json) =>
    IndividualPollsListRequestRowCount(
      evalue: json['evalue'] as int,
      pollId: json['@PollId'] as int?,
    );

Map<String, dynamic> _$IndividualPollsListRequestRowCountToJson(
    IndividualPollsListRequestRowCount instance) {
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
