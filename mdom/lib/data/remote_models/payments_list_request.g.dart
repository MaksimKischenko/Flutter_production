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
      version: json['Version'] as int,
      key: json['KeyRequest'] as int,
      token: json['Token'] as String,
      terminalId: json['TerminalId'] as String,
      dateType: $enumDecode(_$PaymentDateTypeEnumMap, json['DateType']),
      dateFrom: json['DateFrom'] as String,
      dateTo: json['DateTo'] as String,
      accNum: json['AccNum'] as String?,
      status:
          $enumDecodeNullable(_$PaymentStatusEnumMap, json['PaymentStatus']),
      claimId: json['ClaimId'] as int?,
      lastPayment: json['LastPayment'] as int?,
      serviceCode: json['ServiceCode'] as int,
      rowCount: json['RowCount'] == null
          ? null
          : RowCountPayments.fromJson(json['RowCount'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaymentsListRequestToJson(PaymentsListRequest instance) {
  final val = <String, dynamic>{
    'Version': instance.version,
    'KeyRequest': instance.key,
    'Token': instance.token,
    'TerminalId': instance.terminalId,
    'DateType': _$PaymentDateTypeEnumMap[instance.dateType]!,
    'DateFrom': instance.dateFrom,
    'DateTo': instance.dateTo,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('AccNum', instance.accNum);
  writeNotNull('PaymentStatus', _$PaymentStatusEnumMap[instance.status]);
  writeNotNull('ClaimId', instance.claimId);
  writeNotNull('LastPayment', instance.lastPayment);
  val['ServiceCode'] = instance.serviceCode;
  writeNotNull('RowCount', instance.rowCount);
  return val;
}

const _$PaymentDateTypeEnumMap = {
  PaymentDateType.transfer: 0,
  PaymentDateType.receive: 1,
};

const _$PaymentStatusEnumMap = {
  PaymentStatus.all: 0,
  PaymentStatus.registered: 1,
  PaymentStatus.paid: 2,
  PaymentStatus.successfullyReversed: -1,
  PaymentStatus.reversalStarted: -2,
  PaymentStatus.registrationStarted: -3,
  PaymentStatus.registrationCanceled: -4,
  PaymentStatus.refundStarted: -9,
  PaymentStatus.refundCompleted: -10,
  PaymentStatus.refundCancelWaiting: -11,
};

RowCountPayments _$RowCountPaymentsFromJson(Map<String, dynamic> json) =>
    RowCountPayments(
      evalue: json['evalue'] as int,
      paymentId: json['@PaymentId'] as int?,
    );

Map<String, dynamic> _$RowCountPaymentsToJson(RowCountPayments instance) {
  final val = <String, dynamic>{
    'evalue': instance.evalue,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('@PaymentId', instance.paymentId);
  return val;
}
