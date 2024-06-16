// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rule_allocation_insert_request.g.dart';

@JsonSerializable()
class RuleAllocationInsertRequest extends Equatable {

  @JsonKey(name: 'source_id')
  final int? sourceId;

  @JsonKey(name: 'store_year')
  final int? storeYear;

  @JsonKey(name: 'store_month')
  final int? storeMonth;

  @JsonKey(name: 'store_day')
  final int? storeDay;

  @JsonKey(name: 'location_id')
  final int? locationId;

  @JsonKey(name: 'is_default')
  final bool? isDefault;
  
  
  const RuleAllocationInsertRequest({
    this.sourceId,
    this.storeYear,
    this.storeMonth,
    this.storeDay,
    this.locationId,
    this.isDefault = false,
  });

  factory RuleAllocationInsertRequest.empty() => const RuleAllocationInsertRequest();

  factory RuleAllocationInsertRequest.fromJson(Map<String, dynamic> json) => _$RuleAllocationInsertRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RuleAllocationInsertRequestToJson(this);

  @override
  List<Object?> get props => [sourceId, storeYear, storeDay, storeMonth,  locationId, isDefault];


  RuleAllocationInsertRequest copyWith({
    int? sourceId,
    int? storeYear,
    int? storeMonth,
    int? storeDay,
    int? locationId,
    bool? isDefault,
  }) => RuleAllocationInsertRequest(
      sourceId: sourceId ?? this.sourceId,
      storeYear: storeYear ?? this.storeYear,
      storeMonth: storeMonth ?? this.storeMonth,
      storeDay: storeDay ?? this.storeDay,
      locationId: locationId ?? this.locationId,
      isDefault: isDefault ?? this.isDefault,
    );
}
