// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_check_duplicate_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCheckDuplicateResponse _$GetCheckDuplicateResponseFromJson(
        Map<String, dynamic> json) =>
    GetCheckDuplicateResponse(
      errorCode: json['ErrorCode'] as int?,
      errorText: json['ErrorText'] as String?,
      token: json['Token'] as String?,
      check: json['Check'] == null
          ? null
          : CheckResponse.fromJson(json['Check'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetCheckDuplicateResponseToJson(
    GetCheckDuplicateResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ErrorCode', instance.errorCode);
  writeNotNull('ErrorText', instance.errorText);
  writeNotNull('Token', instance.token);
  writeNotNull('Check', instance.check);
  return val;
}
