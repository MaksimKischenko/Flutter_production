// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qr_pan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QrPan _$QrPanFromJson(Map<String, dynamic> json) => QrPan(
      expiry: json['Expiry'] as String?,
      value: json['Value'] as String,
    );

Map<String, dynamic> _$QrPanToJson(QrPan instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Expiry', instance.expiry);
  val['Value'] = instance.value;
  return val;
}
