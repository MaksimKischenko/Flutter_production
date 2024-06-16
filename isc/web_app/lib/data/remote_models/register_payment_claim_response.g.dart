// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_payment_claim_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsTpORegisterPaymentClaimResponseWrapper
    _$PsTpORegisterPaymentClaimResponseWrapperFromJson(
            Map<String, dynamic> json) =>
        PsTpORegisterPaymentClaimResponseWrapper(
          PsTpORegisterPaymentClaimResponse.fromJson(
              json['PS_TP_O'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$PsTpORegisterPaymentClaimResponseWrapperToJson(
        PsTpORegisterPaymentClaimResponseWrapper instance) =>
    <String, dynamic>{
      'PS_TP_O': instance.psTpO,
    };

PsTpORegisterPaymentClaimResponse _$PsTpORegisterPaymentClaimResponseFromJson(
        Map<String, dynamic> json) =>
    PsTpORegisterPaymentClaimResponse(
      RegisterPaymentOfClaimResponse.fromJson(
          json['RegisterPaymentOfClaimResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsTpORegisterPaymentClaimResponseToJson(
        PsTpORegisterPaymentClaimResponse instance) =>
    <String, dynamic>{
      'RegisterPaymentOfClaimResponse': instance.response,
    };

RegisterPaymentOfClaimResponse _$RegisterPaymentOfClaimResponseFromJson(
        Map<String, dynamic> json) =>
    RegisterPaymentOfClaimResponse(
      paymentId: json['PaymentId'] as int?,
      errorCode: json['ErrorCode'] as int,
      errorText: json['ErrorText'] as String?,
    );

Map<String, dynamic> _$RegisterPaymentOfClaimResponseToJson(
    RegisterPaymentOfClaimResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('PaymentId', instance.paymentId);
  val['ErrorCode'] = instance.errorCode;
  writeNotNull('ErrorText', instance.errorText);
  return val;
}
