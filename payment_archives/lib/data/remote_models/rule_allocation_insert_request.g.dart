// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rule_allocation_insert_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RuleAllocationInsertRequest _$RuleAllocationInsertRequestFromJson(
        Map<String, dynamic> json) =>
    RuleAllocationInsertRequest(
      sourceId: json['source_id'] as int?,
      storeYear: json['store_year'] as int?,
      storeMonth: json['store_month'] as int?,
      storeDay: json['store_day'] as int?,
      locationId: json['location_id'] as int?,
      isDefault: json['is_default'] as bool? ?? false,
    );

Map<String, dynamic> _$RuleAllocationInsertRequestToJson(
        RuleAllocationInsertRequest instance) =>
    <String, dynamic>{
      'source_id': instance.sourceId,
      'store_year': instance.storeYear,
      'store_month': instance.storeMonth,
      'store_day': instance.storeDay,
      'location_id': instance.locationId,
      'is_default': instance.isDefault,
    };
