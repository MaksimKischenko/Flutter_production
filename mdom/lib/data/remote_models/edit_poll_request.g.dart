// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_poll_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MdomTpIntEditPollRequestWrapper _$MdomTpIntEditPollRequestWrapperFromJson(
        Map<String, dynamic> json) =>
    MdomTpIntEditPollRequestWrapper(
      MdomTpIntEditPollRequest.fromJson(
          json['PS_TP_O_INT'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomTpIntEditPollRequestWrapperToJson(
        MdomTpIntEditPollRequestWrapper instance) =>
    <String, dynamic>{
      'PS_TP_O_INT': instance.psTpInt,
    };

MdomTpIntEditPollRequest _$MdomTpIntEditPollRequestFromJson(
        Map<String, dynamic> json) =>
    MdomTpIntEditPollRequest(
      EditPollRequest.fromJson(json['EditPollRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomTpIntEditPollRequestToJson(
        MdomTpIntEditPollRequest instance) =>
    <String, dynamic>{
      'EditPollRequest': instance.request,
    };

EditPollRequest _$EditPollRequestFromJson(Map<String, dynamic> json) =>
    EditPollRequest(
      terminalId: MdomTpIntTerminalId.fromJson(
          json['TerminalId'] as Map<String, dynamic>),
      version: json['Version'] as String,
      keyRequest: json['KeyRequest'] as int,
      lang: json['Lang'] as String?,
      token: json['Token'] as String,
      pollId: json['PollId'] as int,
      topic: json['Topic'] as String?,
      startDate: json['StartDate'] as String?,
      stopDate: json['StopDate'] as String?,
      url: json['URL'] as String?,
      anonymous: json['Anonymous'] as int?,
      publish: json['Publish'] as int?,
      questions: (json['Question'] as List<dynamic>?)
          ?.map((e) => PollQuestionEdit.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EditPollRequestToJson(EditPollRequest instance) {
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
  val['PollId'] = instance.pollId;
  writeNotNull('Topic', instance.topic);
  writeNotNull('StartDate', instance.startDate);
  writeNotNull('StopDate', instance.stopDate);
  writeNotNull('URL', instance.url);
  writeNotNull('Anonymous', instance.anonymous);
  writeNotNull('Publish', instance.publish);
  writeNotNull('Question', instance.questions);
  return val;
}
