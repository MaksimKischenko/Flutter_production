// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'run_operation_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RunOperationRequest _$RunOperationRequestFromJson(Map<String, dynamic> json) =>
    RunOperationRequest(
      payDate: json['PayDate'] as String,
      kioskReceipt: json['KioskReceipt'] as String,
      payRecord: json['PayRecord'] == null
          ? null
          : PayRecordRequest.fromJson(
              json['PayRecord'] as Map<String, dynamic>),
      pan: json['PAN'] == null
          ? null
          : PAN.fromJson(json['PAN'] as Map<String, dynamic>),
      typePAN: json['TypePAN'] == null
          ? null
          : TypePAN.fromJson(json['TypePAN'] as Map<String, dynamic>),
      properties: (json['Property'] as List<dynamic>?)
          ?.map((e) => RequestProperty.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RunOperationRequestToJson(RunOperationRequest instance) {
  final val = <String, dynamic>{
    'PayDate': instance.payDate,
    'KioskReceipt': instance.kioskReceipt,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('PayRecord', instance.payRecord);
  writeNotNull('PAN', instance.pan);
  writeNotNull('TypePAN', instance.typePAN);
  writeNotNull('Property', instance.properties);
  return val;
}
