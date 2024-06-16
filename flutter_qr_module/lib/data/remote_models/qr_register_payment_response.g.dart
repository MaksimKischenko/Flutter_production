// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qr_register_payment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsHelppayQrRegisterPaymentResponseWrapper
    _$PsHelppayQrRegisterPaymentResponseWrapperFromJson(
            Map<String, dynamic> json) =>
        PsHelppayQrRegisterPaymentResponseWrapper(
          PsHelppayQrRegisterPaymentResponse.fromJson(
              json['PS_HELPPAY'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$PsHelppayQrRegisterPaymentResponseWrapperToJson(
        PsHelppayQrRegisterPaymentResponseWrapper instance) =>
    <String, dynamic>{
      'PS_HELPPAY': instance.psHelpPay,
    };

PsHelppayQrRegisterPaymentResponse _$PsHelppayQrRegisterPaymentResponseFromJson(
        Map<String, dynamic> json) =>
    PsHelppayQrRegisterPaymentResponse(
      QrRegisterPaymentResponse.fromJson(
          json['RegisterPaymentResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsHelppayQrRegisterPaymentResponseToJson(
        PsHelppayQrRegisterPaymentResponse instance) =>
    <String, dynamic>{
      'RegisterPaymentResponse': instance.response,
    };

QrRegisterPaymentResponse _$QrRegisterPaymentResponseFromJson(
        Map<String, dynamic> json) =>
    QrRegisterPaymentResponse(
      kioskReciept: json['KioskReceipt'] as String?,
      payRecord: PayRecord.fromJson(json['PayRecord'] as Map<String, dynamic>),
      errorCode: json['ErrorCode'] as int,
      errorText: json['ErrorText'] as String?,
    );

Map<String, dynamic> _$QrRegisterPaymentResponseToJson(
    QrRegisterPaymentResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('KioskReceipt', instance.kioskReciept);
  val['PayRecord'] = instance.payRecord;
  val['ErrorCode'] = instance.errorCode;
  writeNotNull('ErrorText', instance.errorText);
  return val;
}

PayRecord _$PayRecordFromJson(Map<String, dynamic> json) => PayRecord(
      paymentSum: (json['Summa'] as num).toDouble(),
      currency: json['Currency'] as int,
      paymentId: json['PaymentID'] as int,
      paymentDate: json['Date'] as String,
    );

Map<String, dynamic> _$PayRecordToJson(PayRecord instance) => <String, dynamic>{
      'PaymentID': instance.paymentId,
      'Summa': instance.paymentSum,
      'Currency': instance.currency,
      'Date': instance.paymentDate,
    };
