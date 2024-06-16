// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'companies_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MdomCompaniesRequestWrapper _$MdomCompaniesRequestWrapperFromJson(
        Map<String, dynamic> json) =>
    MdomCompaniesRequestWrapper(
      MdomCompaniesRequest.fromJson(
          json['TPInfoRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomCompaniesRequestWrapperToJson(
        MdomCompaniesRequestWrapper instance) =>
    <String, dynamic>{
      'TPInfoRequest': instance.request,
    };

MdomCompaniesRequest _$MdomCompaniesRequestFromJson(
        Map<String, dynamic> json) =>
    MdomCompaniesRequest(
      terminalId: json['TerminalId'] as String,
      version: json['Version'] as String,
      token: json['Token'] as String,
      lang: json['Lang'] as String?,
      requestType: json['RequestType'] as String? ?? 'Companies',
    );

Map<String, dynamic> _$MdomCompaniesRequestToJson(
    MdomCompaniesRequest instance) {
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
  return val;
}
