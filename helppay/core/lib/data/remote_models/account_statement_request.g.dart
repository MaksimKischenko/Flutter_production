// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_statement_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MdomAccountStatementRequestWrapper _$MdomAccountStatementRequestWrapperFromJson(
        Map<String, dynamic> json) =>
    MdomAccountStatementRequestWrapper(
      MdomAccountStatementRequest.fromJson(
          json['TPInfoRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomAccountStatementRequestWrapperToJson(
        MdomAccountStatementRequestWrapper instance) =>
    <String, dynamic>{
      'TPInfoRequest': instance.request,
    };

MdomAccountStatementRequest _$MdomAccountStatementRequestFromJson(
        Map<String, dynamic> json) =>
    MdomAccountStatementRequest(
      requestType: json['RequestType'] as String? ?? 'AccountStatement',
      terminalId: json['TerminalId'] as String,
      version: json['Version'] as String,
      token: json['Token'] as String,
      lang: json['Lang'] as String?,
      periodFrom: json['PeriodFrom'] as String,
      periodTo: json['PeriodTo'] as String,
      supplierId: json['SupplierId'] as int,
      account: json['Account'] as String,
    );

Map<String, dynamic> _$MdomAccountStatementRequestToJson(
    MdomAccountStatementRequest instance) {
  final val = <String, dynamic>{
    'RequestType': instance.requestType,
    'TerminalId': instance.terminalId,
    'Version': instance.version,
    'Token': instance.token,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Lang', instance.lang);
  val['PeriodFrom'] = instance.periodFrom;
  val['PeriodTo'] = instance.periodTo;
  val['SupplierId'] = instance.supplierId;
  val['Account'] = instance.account;
  return val;
}
