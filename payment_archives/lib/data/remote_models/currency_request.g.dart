// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyRequest _$CurrencyRequestFromJson(Map<String, dynamic> json) =>
    CurrencyRequest(
      paySumm: (json['p_sum'] as num).toDouble(),
      payCurrency: json['p_currency'] as int?,
    );

Map<String, dynamic> _$CurrencyRequestToJson(CurrencyRequest instance) =>
    <String, dynamic>{
      'p_sum': instance.paySumm,
      'p_currency': instance.payCurrency,
    };
