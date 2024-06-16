// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_rule_allocation_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RuleAllocationData _$RuleAllocationDataFromJson(Map<String, dynamic> json) =>
    RuleAllocationData(
      id: json['id'] as int?,
      sourceId: json['source_id'] as int?,
      storeYear: json['store_year'] as int?,
      storeMonth: json['store_month'] as int?,
      storeDay: json['store_day'] as int?,
      locationId: json['location_id'] as int?,
      storeDate: json['store_date'] as String?,
      isDefault: json['is_default'] as bool?,
    );

Map<String, dynamic> _$RuleAllocationDataToJson(RuleAllocationData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'source_id': instance.sourceId,
      'store_year': instance.storeYear,
      'store_month': instance.storeMonth,
      'store_day': instance.storeDay,
      'location_id': instance.locationId,
      'store_date': instance.storeDate,
      'is_default': instance.isDefault,
    };
