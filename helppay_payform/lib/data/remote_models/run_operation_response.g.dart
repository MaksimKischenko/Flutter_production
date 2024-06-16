// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'run_operation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RunOperationResponse _$RunOperationResponseFromJson(
        Map<String, dynamic> json) =>
    RunOperationResponse(
      errorCode: json['ErrorCode'] as int?,
      errorText: json['ErrorText'] as String?,
      kioskReceipt: json['KioskReceipt'] as String?,
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
  writeNotNull('KioskReceipt', instance.kioskReceipt);
  writeNotNull('PayRecord', instance.payRecord);
  return val;
}
