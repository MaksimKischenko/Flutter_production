// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'run_operation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsEripRunOperationResponseWrapper _$PsEripRunOperationResponseWrapperFromJson(
        Map<String, dynamic> json) =>
    PsEripRunOperationResponseWrapper(
      PsEripRunOperationResponse.fromJson(
          json['PS_ERIP'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsEripRunOperationResponseWrapperToJson(
        PsEripRunOperationResponseWrapper instance) =>
    <String, dynamic>{
      'PS_ERIP': instance.psErip,
    };

PsEripRunOperationResponse _$PsEripRunOperationResponseFromJson(
        Map<String, dynamic> json) =>
    PsEripRunOperationResponse(
      RunOperationResponse.fromJson(
          json['RunOperationResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsEripRunOperationResponseToJson(
        PsEripRunOperationResponse instance) =>
    <String, dynamic>{
      'RunOperationResponse': instance.response,
    };

RunOperationResponse _$RunOperationResponseFromJson(
        Map<String, dynamic> json) =>
    RunOperationResponse(
      errorCode: json['ErrorCode'] as int?,
      errorText: json['ErrorText'] as String?,
      payRecord: json['PayRecord'] == null
          ? null
          : PayRecordResponse.fromJson(
              json['PayRecord'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RunOperationResponseToJson(
    RunOperationResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ErrorCode', instance.errorCode);
  writeNotNull('ErrorText', instance.errorText);
  writeNotNull('PayRecord', instance.payRecord);
  return val;
}
