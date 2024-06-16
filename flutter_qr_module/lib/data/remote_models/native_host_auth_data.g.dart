// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'native_host_auth_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NativeHostAuthData _$NativeHostAuthDataFromJson(Map<String, dynamic> json) =>
    NativeHostAuthData(
      qrScanUrl: json['qrScanUrl'] as String,
      qrPayUrl: json['qrPayUrl'] as String,
      terminalId: json['terminalId'] as String,
      typePan: json['typePan'] as String,
      pan: json['pan'] as String,
      expiry: json['expiry'] as String?,
    );

Map<String, dynamic> _$NativeHostAuthDataToJson(NativeHostAuthData instance) {
  final val = <String, dynamic>{
    'qrScanUrl': instance.qrScanUrl,
    'qrPayUrl': instance.qrPayUrl,
    'terminalId': instance.terminalId,
    'typePan': instance.typePan,
    'pan': instance.pan,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('expiry', instance.expiry);
  return val;
}
