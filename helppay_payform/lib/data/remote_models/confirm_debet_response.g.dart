// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_debet_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfirmDebetResponse _$ConfirmDebetResponseFromJson(
        Map<String, dynamic> json) =>
    ConfirmDebetResponse(
      returnUrl: json['ReturnURL'] as String?,
      errorCode: json['ErrorCode'] as int?,
      errorText: json['ErrorText'] as String?,
    );

Map<String, dynamic> _$ConfirmDebetResponseToJson(
    ConfirmDebetResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ReturnURL', instance.returnUrl);
  writeNotNull('ErrorCode', instance.errorCode);
  writeNotNull('ErrorText', instance.errorText);
  return val;
}
