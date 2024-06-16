// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_period_type_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PeriodType _$PeriodTypeFromJson(Map<String, dynamic> json) => PeriodType(
      id: json['period_type_id'] as int,
      name: json['period_type_name'] as String,
    );

Map<String, dynamic> _$PeriodTypeToJson(PeriodType instance) =>
    <String, dynamic>{
      'period_type_id': instance.id,
      'period_type_name': instance.name,
    };
