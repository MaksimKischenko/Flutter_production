// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_map_allocation_data_response.g.dart';

@JsonSerializable()
class MapAllocationData extends Equatable {

  @JsonKey(name: 'archive_db_id')
  final int archiveId;

  @JsonKey(name: 'enabled')
  final bool? enabled;

  @JsonKey(name: 'location_id')
  final int? locationId;

  @JsonKey(name: 'store_date')
  final DateTime? storeDate;

  const MapAllocationData({
    required this.archiveId,
    required this.enabled,
    required this.locationId,
    required this.storeDate,
  });


  factory MapAllocationData.fromJson(Map<String, dynamic> json) => _$MapAllocationDataFromJson(json);

  Map<String, dynamic> toJson() => _$MapAllocationDataToJson(this);

  @override
  List<Object?> get props => [archiveId, enabled, locationId, storeDate];


  MapAllocationData copyWith({
    int? archiveId,
    bool? enabled,
    int? locationId,
    DateTime? storeDate,
  }) => MapAllocationData(
      archiveId: archiveId ?? this.archiveId,
      enabled: enabled ?? this.enabled,
      locationId: locationId ?? this.locationId,
      storeDate: storeDate ?? this.storeDate,
    );

  int get statusSortIndex => (enabled ?? false) ? 1 : 0;   
}
