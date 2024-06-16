// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qr_register_payment_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsHelppayQrRegisterPaymentRequestWrapper
    _$PsHelppayQrRegisterPaymentRequestWrapperFromJson(
            Map<String, dynamic> json) =>
        PsHelppayQrRegisterPaymentRequestWrapper(
          PsHelppayQrRegisterPaymentRequest.fromJson(
              json['PS_HELPPAY'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$PsHelppayQrRegisterPaymentRequestWrapperToJson(
        PsHelppayQrRegisterPaymentRequestWrapper instance) =>
    <String, dynamic>{
      'PS_HELPPAY': instance.psErip,
    };

PsHelppayQrRegisterPaymentRequest _$PsHelppayQrRegisterPaymentRequestFromJson(
        Map<String, dynamic> json) =>
    PsHelppayQrRegisterPaymentRequest(
      QrRegisterPaymentRequest.fromJson(
          json['RegisterPaymentRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsHelppayQrRegisterPaymentRequestToJson(
        PsHelppayQrRegisterPaymentRequest instance) =>
    <String, dynamic>{
      'RegisterPaymentRequest': instance.request,
    };

QrRegisterPaymentRequest _$QrRegisterPaymentRequestFromJson(
        Map<String, dynamic> json) =>
    QrRegisterPaymentRequest(
      terminalID: RegPayMinTerminalID.fromJson(
          json['TerminalID'] as Map<String, dynamic>),
      version: json['Version'] as int,
      typePan: json['TypePAN'] as String,
      pan: QrPan.fromJson(json['PAN'] as Map<String, dynamic>),
      paymentDate: json['PayDate'] as String,
      kioskReciept: json['KioskReceipt'] as String,
      cashierData: json['Cashier'] == null
          ? null
          : Cashier.fromJson(json['Cashier'] as Map<String, dynamic>),
      payRecord: PayRecord.fromJson(json['PayRecord'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$QrRegisterPaymentRequestToJson(
    QrRegisterPaymentRequest instance) {
  final val = <String, dynamic>{
    'TerminalID': instance.terminalID,
    'Version': instance.version,
    'TypePAN': instance.typePan,
    'PAN': instance.pan,
    'PayDate': instance.paymentDate,
    'KioskReceipt': instance.kioskReciept,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Cashier', instance.cashierData);
  val['PayRecord'] = instance.payRecord;
  return val;
}

Cashier _$CashierFromJson(Map<String, dynamic> json) => Cashier(
      value: json['Value'] as String,
      fio: json['FIO'] as String?,
    );

Map<String, dynamic> _$CashierToJson(Cashier instance) {
  final val = <String, dynamic>{
    'Value': instance.value,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('FIO', instance.fio);
  return val;
}

PayRecord _$PayRecordFromJson(Map<String, dynamic> json) => PayRecord(
      paymentSum: (json['Summa'] as num?)?.toDouble(),
      currency: json['Currency'] as int,
      attributes: (json['AttrRecord'] as List<dynamic>)
          .map((e) => AttrRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PayRecordToJson(PayRecord instance) => <String, dynamic>{
      'Summa': instance.paymentSum,
      'Currency': instance.currency,
      'AttrRecord': instance.attributes,
    };

AttrRecord _$AttrRecordFromJson(Map<String, dynamic> json) => AttrRecord(
      code: json['Code'] as int,
      name: json['Name'] as String,
      value: json['Value'] as String,
    );

Map<String, dynamic> _$AttrRecordToJson(AttrRecord instance) =>
    <String, dynamic>{
      'Code': instance.code,
      'Name': instance.name,
      'Value': instance.value,
    };
