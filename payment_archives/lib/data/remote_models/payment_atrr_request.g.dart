// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_atrr_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentAtrrRequest _$PaymentAtrrRequestFromJson(Map<String, dynamic> json) =>
    PaymentAtrrRequest(
      sourceId: json['p_source_id'] as int,
      paymentId: json['p_payment_id'] as int?,
    );

Map<String, dynamic> _$PaymentAtrrRequestToJson(PaymentAtrrRequest instance) =>
    <String, dynamic>{
      'p_source_id': instance.sourceId,
      'p_payment_id': instance.paymentId,
    };
