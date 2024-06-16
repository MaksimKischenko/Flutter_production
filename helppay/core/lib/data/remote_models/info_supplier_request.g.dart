// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_supplier_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MdomInfoSupplierRequestWrapper _$MdomInfoSupplierRequestWrapperFromJson(
        Map<String, dynamic> json) =>
    MdomInfoSupplierRequestWrapper(
      MdomInfoSupplierRequest.fromJson(
          json['TPInfoRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomInfoSupplierRequestWrapperToJson(
        MdomInfoSupplierRequestWrapper instance) =>
    <String, dynamic>{
      'TPInfoRequest': instance.request,
    };

MdomInfoSupplierRequest _$MdomInfoSupplierRequestFromJson(
        Map<String, dynamic> json) =>
    MdomInfoSupplierRequest(
      requestType: json['RequestType'] as String? ?? 'InfoSupplier',
      terminalId: json['TerminalId'] as String,
      version: json['Version'] as String,
      token: json['Token'] as String,
      lang: json['Lang'] as String?,
      filter: Filter.fromJson(json['Filter'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MdomInfoSupplierRequestToJson(
    MdomInfoSupplierRequest instance) {
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
  val['Filter'] = instance.filter;
  return val;
}

Filter _$FilterFromJson(Map<String, dynamic> json) => Filter(
      supplierUNN: json['@SupplierUNN'] as int?,
      supplierName: json['@SupplierName'] as String?,
    );

Map<String, dynamic> _$FilterToJson(Filter instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('@SupplierUNN', instance.supplierUNN);
  writeNotNull('@SupplierName', instance.supplierName);
  return val;
}
