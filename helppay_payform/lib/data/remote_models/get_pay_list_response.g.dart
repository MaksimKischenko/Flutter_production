// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_pay_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPayListResponse _$GetPayListResponseFromJson(Map<String, dynamic> json) =>
    GetPayListResponse(
      errorCode: json['ErrorCode'] as int?,
      errorText: json['ErrorText'] as String?,
      token: json['Token'] as String?,
      payRecord: (json['PayRecord'] as List<dynamic>?)
          ?.map((e) => PayRecordResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetPayListResponseToJson(GetPayListResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ErrorCode', instance.errorCode);
  writeNotNull('ErrorText', instance.errorText);
  writeNotNull('Token', instance.token);
  writeNotNull('PayRecord', instance.payRecord);
  return val;
}
