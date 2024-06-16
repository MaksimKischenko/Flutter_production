// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_payment_claim_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsTpORegisterPaymentClaimRequestWrapper
    _$PsTpORegisterPaymentClaimRequestWrapperFromJson(
            Map<String, dynamic> json) =>
        PsTpORegisterPaymentClaimRequestWrapper(
          PsTpORegisterPaymentClaimRequest.fromJson(
              json['PS_TP_O'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$PsTpORegisterPaymentClaimRequestWrapperToJson(
        PsTpORegisterPaymentClaimRequestWrapper instance) =>
    <String, dynamic>{
      'PS_TP_O': instance.psTpO,
    };

PsTpORegisterPaymentClaimRequest _$PsTpORegisterPaymentClaimRequestFromJson(
        Map<String, dynamic> json) =>
    PsTpORegisterPaymentClaimRequest(
      RegisterPaymentOfClaimRequest.fromJson(
          json['RegisterPaymentOfClaimRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PsTpORegisterPaymentClaimRequestToJson(
        PsTpORegisterPaymentClaimRequest instance) =>
    <String, dynamic>{
      'RegisterPaymentOfClaimRequest': instance.request,
    };

RegisterPaymentOfClaimRequest _$RegisterPaymentOfClaimRequestFromJson(
        Map<String, dynamic> json) =>
    RegisterPaymentOfClaimRequest(
      claimId: json['ClaimId'] as int?,
      paySum: (json['PaySum'] as num?)?.toDouble(),
      memNumber: json['MemNumber'] as String?,
      memDate: json['MemDate'] as String?,
      account: json['Account'] as String?,
      key: json['KeyRequest'] as int?,
      token: json['Token'] as String?,
      version: json['Version'] as int?,
    );

Map<String, dynamic> _$RegisterPaymentOfClaimRequestToJson(
    RegisterPaymentOfClaimRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ClaimId', instance.claimId);
  writeNotNull('PaySum', instance.paySum);
  writeNotNull('MemNumber', instance.memNumber);
  writeNotNull('MemDate', instance.memDate);
  writeNotNull('Account', instance.account);
  writeNotNull('Version', instance.version);
  writeNotNull('KeyRequest', instance.key);
  writeNotNull('Token', instance.token);
  return val;
}
