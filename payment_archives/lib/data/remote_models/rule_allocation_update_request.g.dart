// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rule_allocation_update_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RuleAllocationUpdateRequest _$RuleAllocationUpdateRequestFromJson(
        Map<String, dynamic> json) =>
    RuleAllocationUpdateRequest(
      sourceId: json['source_id'] as int?,
      storeYear: json['store_year'] as int?,
      storeMonth: json['store_month'] as int?,
      storeDay: json['store_day'] as int?,
      locationId: json['location_id'] as int?,
      isDefault: json['is_default'] as bool?,
    );

Map<String, dynamic> _$RuleAllocationUpdateRequestToJson(
    RuleAllocationUpdateRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('source_id', instance.sourceId);
  writeNotNull('store_year', instance.storeYear);
  writeNotNull('store_month', instance.storeMonth);
  writeNotNull('store_day', instance.storeDay);
  writeNotNull('location_id', instance.locationId);
  writeNotNull('is_default', instance.isDefault);
  return val;
}
