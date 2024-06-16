// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_poll_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MdomTpIntAddPollRequestWrapper _$MdomTpIntAddPollRequestWrapperFromJson(
        Map<String, dynamic> json) =>
    MdomTpIntAddPollRequestWrapper(
      MdomTpIntAddPollRequest.fromJson(
          json['PS_TP_O_INT'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomTpIntAddPollRequestWrapperToJson(
        MdomTpIntAddPollRequestWrapper instance) =>
    <String, dynamic>{
      'PS_TP_O_INT': instance.psTpInt,
    };

MdomTpIntAddPollRequest _$MdomTpIntAddPollRequestFromJson(
        Map<String, dynamic> json) =>
    MdomTpIntAddPollRequest(
      AddPollRequest.fromJson(json['AddPollRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomTpIntAddPollRequestToJson(
        MdomTpIntAddPollRequest instance) =>
    <String, dynamic>{
      'AddPollRequest': instance.request,
    };

AddPollRequest _$AddPollRequestFromJson(Map<String, dynamic> json) =>
    AddPollRequest(
      terminalId: MdomTpIntTerminalId.fromJson(
          json['TerminalId'] as Map<String, dynamic>),
      version: json['Version'] as String,
      keyRequest: json['KeyRequest'] as int,
      lang: json['Lang'] as String?,
      token: json['Token'] as String,
      topic: json['Topic'] as String,
      startDate: json['StartDate'] as String,
      stopDate: json['StopDate'] as String,
      url: json['URL'] as String?,
      anonymous: json['Anonymous'] as int,
      publish: json['Publish'] as int?,
      questions: (json['Question'] as List<dynamic>?)
          ?.map((e) => PollQuestionEdit.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AddPollRequestToJson(AddPollRequest instance) {
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
  val['Topic'] = instance.topic;
  val['StartDate'] = instance.startDate;
  val['StopDate'] = instance.stopDate;
  writeNotNull('URL', instance.url);
  val['Anonymous'] = instance.anonymous;
  writeNotNull('Publish', instance.publish);
  writeNotNull('Question', instance.questions);
  return val;
}

PollQuestionEdit _$PollQuestionEditFromJson(Map<String, dynamic> json) =>
    PollQuestionEdit(
      evalue: json['evalue'] as String,
      idx: json['@Idx'] as int,
      description: json['@Description'] as String?,
    );

Map<String, dynamic> _$PollQuestionEditToJson(PollQuestionEdit instance) =>
    <String, dynamic>{
      'evalue': instance.evalue,
      '@Idx': instance.idx,
      '@Description': instance.description,
    };
