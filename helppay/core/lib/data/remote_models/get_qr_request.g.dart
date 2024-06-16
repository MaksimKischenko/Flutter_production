// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_qr_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsHelppayGetQrRequestWrapper _$PsHelppayGetQrRequestWrapperFromJson(
        Map<String, dynamic> json) =>
    PsHelppayGetQrRequestWrapper(
      PsHelppayGetQrRequest.fromJson(
          json['PS_HELPPAY'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsHelppayGetQrRequestWrapperToJson(
        PsHelppayGetQrRequestWrapper instance) =>
    <String, dynamic>{
      'PS_HELPPAY': instance.psErip,
    };

PsHelppayGetQrRequest _$PsHelppayGetQrRequestFromJson(
        Map<String, dynamic> json) =>
    PsHelppayGetQrRequest(
      GetQrRequest.fromJson(json['GetQRRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsHelppayGetQrRequestToJson(
        PsHelppayGetQrRequest instance) =>
    <String, dynamic>{
      'GetQRRequest': instance.request,
    };

GetQrRequest _$GetQrRequestFromJson(Map<String, dynamic> json) => GetQrRequest(
      terminalID: RegPayMinTerminalID.fromJson(
          json['TerminalID'] as Map<String, dynamic>),
      version: json['Version'] as int,
      typePan: json['TypePAN'] as String,
      pan: QrPan.fromJson(json['PAN'] as Map<String, dynamic>),
      restSum: (json['RestSum'] as num).toDouble(),
      paymentSum: (json['PaySum'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$GetQrRequestToJson(GetQrRequest instance) {
  final val = <String, dynamic>{
    'TerminalID': instance.terminalID,
    'Version': instance.version,
    'TypePAN': instance.typePan,
    'PAN': instance.pan,
    'RestSum': instance.restSum,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('PaySum', instance.paymentSum);
  return val;
}
