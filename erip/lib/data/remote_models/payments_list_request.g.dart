// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payments_list_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsTpOPaymentsListRequestWrapper _$PsTpOPaymentsListRequestWrapperFromJson(
        Map<String, dynamic> json) =>
    PsTpOPaymentsListRequestWrapper(
      PsTpOPaymentsListRequest.fromJson(
          json['PS_TP_O'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsTpOPaymentsListRequestWrapperToJson(
        PsTpOPaymentsListRequestWrapper instance) =>
    <String, dynamic>{
      'PS_TP_O': instance.psTpO,
    };

PsTpOPaymentsListRequest _$PsTpOPaymentsListRequestFromJson(
        Map<String, dynamic> json) =>
    PsTpOPaymentsListRequest(
      PaymentsListRequest.fromJson(
          json['PaymentsListRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsTpOPaymentsListRequestToJson(
        PsTpOPaymentsListRequest instance) =>
    <String, dynamic>{
      'PaymentsListRequest': instance.request,
    };

PaymentsListRequest _$PaymentsListRequestFromJson(Map<String, dynamic> json) =>
    PaymentsListRequest(
      dateType: json['DateType'] as int,
      dateFrom: json['DateFrom'] as String,
      dateTo: json['DateTo'] as String,
      accNum: json['AccNum'] as String?,
      status: json['PaymentStatus'] as int?,
      claimId: json['ClaimId'] as int?,
      lastPayment: json['LastPayment'] as int?,
      serviceCode: json['ServiceCode'] as int,
      rowCount: json['RowCount'] == null
          ? null
          : RowCountPayments.fromJson(json['RowCount'] as Map<String, dynamic>),
      version: json['Version'] as int,
      token: json['Token'] as String,
      key: json['KeyRequest'] as int,
    );

Map<String, dynamic> _$PaymentsListRequestToJson(PaymentsListRequest instance) {
  final val = <String, dynamic>{
    'DateType': instance.dateType,
    'DateFrom': instance.dateFrom,
    'DateTo': instance.dateTo,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('AccNum', instance.accNum);
  writeNotNull('PaymentStatus', instance.status);
  writeNotNull('ClaimId', instance.claimId);
  writeNotNull('LastPayment', instance.lastPayment);
  val['ServiceCode'] = instance.serviceCode;
  writeNotNull('RowCount', instance.rowCount);
  val['Version'] = instance.version;
  val['Token'] = instance.token;
  val['KeyRequest'] = instance.key;
  return val;
}

RowCountPayments _$RowCountPaymentsFromJson(Map<String, dynamic> json) =>
    RowCountPayments(
      evalue: json['evalue'] as int,
      paymentId: json['@PaymentId'] as int?,
    );

Map<String, dynamic> _$RowCountPaymentsToJson(RowCountPayments instance) =>
    <String, dynamic>{
      'evalue': instance.evalue,
      '@PaymentId': instance.paymentId,
    };
