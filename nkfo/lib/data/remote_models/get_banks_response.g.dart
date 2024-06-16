// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_banks_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bank _$BankFromJson(Map<String, dynamic> json) => Bank(
      id: json['bank_id'] as int,
      name: json['bank_name'] as String,
      bic: json['bank_bic'] as String,
    );

Map<String, dynamic> _$BankToJson(Bank instance) => <String, dynamic>{
      'bank_id': instance.id,
      'bank_name': instance.name,
      'bank_bic': instance.bic,
    };
