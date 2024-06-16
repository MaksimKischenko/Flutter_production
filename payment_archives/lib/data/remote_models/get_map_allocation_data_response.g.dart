// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_map_allocation_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MapAllocationData _$MapAllocationDataFromJson(Map<String, dynamic> json) =>
    MapAllocationData(
      archiveId: json['archive_db_id'] as int,
      enabled: json['enabled'] as bool?,
      locationId: json['location_id'] as int?,
      storeDate: json['store_date'] == null
          ? null
          : DateTime.parse(json['store_date'] as String),
    );

Map<String, dynamic> _$MapAllocationDataToJson(MapAllocationData instance) =>
    <String, dynamic>{
      'archive_db_id': instance.archiveId,
      'enabled': instance.enabled,
      'location_id': instance.locationId,
      'store_date': instance.storeDate?.toIso8601String(),
    };
