// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_payment_method_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsHelppayRegisterPaymentMethodResponseWrapper
    _$PsHelppayRegisterPaymentMethodResponseWrapperFromJson(
            Map<String, dynamic> json) =>
        PsHelppayRegisterPaymentMethodResponseWrapper(
          PsHelppayRegisterPaymentMethodResponse.fromJson(
              json['PS_HELPPAY'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$PsHelppayRegisterPaymentMethodResponseWrapperToJson(
        PsHelppayRegisterPaymentMethodResponseWrapper instance) =>
    <String, dynamic>{
      'PS_HELPPAY': instance.psHelpPay,
    };

PsHelppayRegisterPaymentMethodResponse
    _$PsHelppayRegisterPaymentMethodResponseFromJson(
            Map<String, dynamic> json) =>
        PsHelppayRegisterPaymentMethodResponse(
          json['RegPayMeanResponse'] == null
              ? null
              : RegisterPaymentMethodResponse.fromJson(
                  json['RegPayMeanResponse'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$PsHelppayRegisterPaymentMethodResponseToJson(
        PsHelppayRegisterPaymentMethodResponse instance) =>
    <String, dynamic>{
      'RegPayMeanResponse': instance.response,
    };

RegisterPaymentMethodResponse _$RegisterPaymentMethodResponseFromJson(
        Map<String, dynamic> json) =>
    RegisterPaymentMethodResponse(
      errorCode: json['ErrorCode'] as int,
      errorText: json['ErrorText'] as String?,
      requestId: json['RequestId'] as int?,
      card: (json['Card'] as List<dynamic>?)
          ?.map((e) => CardPayment.fromJson(e as Map<String, dynamic>))
          .toList(),
      needMCI: json['NeedMCI'] as int?,
    );

Map<String, dynamic> _$RegisterPaymentMethodResponseToJson(
    RegisterPaymentMethodResponse instance) {
  final val = <String, dynamic>{
    'ErrorCode': instance.errorCode,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ErrorText', instance.errorText);
  writeNotNull('RequestId', instance.requestId);
  writeNotNull('Card', instance.card);
  writeNotNull('NeedMCI', instance.needMCI);
  return val;
}

CardPayment _$CardPaymentFromJson(Map<String, dynamic> json) => CardPayment(
      cardId: json['CardId'] as int,
      panMask: json['PANMask'] as String,
      contractKind: json['ContractKind'] as int,
      cardName: json['CardName'] as String?,
    );

Map<String, dynamic> _$CardPaymentToJson(CardPayment instance) {
  final val = <String, dynamic>{
    'CardId': instance.cardId,
    'PANMask': instance.panMask,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('CardName', instance.cardName);
  val['ContractKind'] = instance.contractKind;
  return val;
}
