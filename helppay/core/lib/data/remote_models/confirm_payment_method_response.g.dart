// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_payment_method_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PsHelppayConfirmPaymentMethodResponseWrapper
    _$PsHelppayConfirmPaymentMethodResponseWrapperFromJson(
            Map<String, dynamic> json) =>
        PsHelppayConfirmPaymentMethodResponseWrapper(
          PsHelppayConfirmPaymentMethodResponse.fromJson(
              json['PS_HELPPAY'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$PsHelppayConfirmPaymentMethodResponseWrapperToJson(
        PsHelppayConfirmPaymentMethodResponseWrapper instance) =>
    <String, dynamic>{
      'PS_HELPPAY': instance.psHelpPay,
    };

PsHelppayConfirmPaymentMethodResponse
    _$PsHelppayConfirmPaymentMethodResponseFromJson(
            Map<String, dynamic> json) =>
        PsHelppayConfirmPaymentMethodResponse(
          ConfirmPaymentMethodResponse.fromJson(
              json['ConfirmPayMeanResponse'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$PsHelppayConfirmPaymentMethodResponseToJson(
        PsHelppayConfirmPaymentMethodResponse instance) =>
    <String, dynamic>{
      'ConfirmPayMeanResponse': instance.response,
    };

ConfirmPaymentMethodResponse _$ConfirmPaymentMethodResponseFromJson(
        Map<String, dynamic> json) =>
    ConfirmPaymentMethodResponse(
      errorCode: json['ErrorCode'] as int,
      errorText: json['ErrorText'] as String?,
      cardId: json['CardId'] as int?,
      cardPan: json['CardPAN'] as String?,
    );

Map<String, dynamic> _$ConfirmPaymentMethodResponseToJson(
    ConfirmPaymentMethodResponse instance) {
  final val = <String, dynamic>{
    'ErrorCode': instance.errorCode,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ErrorText', instance.errorText);
  writeNotNull('CardId', instance.cardId);
  writeNotNull('CardPAN', instance.cardPan);
  return val;
}
