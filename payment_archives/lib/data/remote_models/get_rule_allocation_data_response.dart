// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_rule_allocation_data_response.g.dart';

@JsonSerializable()
class RuleAllocationData extends Equatable {

  @JsonKey(name: 'id')
  final int? id;

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

  @JsonKey(name: 'store_date')
  final String? storeDate;

  @JsonKey(name: 'is_default')
  final bool? isDefault;

  const RuleAllocationData({
    this.id,
    this.sourceId,
    this.storeYear,
    this.storeMonth,
    this.storeDay,
    this.locationId,
    this.storeDate,
    this.isDefault
  });


  factory RuleAllocationData.empty() => const RuleAllocationData();

  factory RuleAllocationData.fromJson(Map<String, dynamic> json) => _$RuleAllocationDataFromJson(json);

  Map<String, dynamic> toJson() => _$RuleAllocationDataToJson(this);

  @override
  List<Object?> get props => [id, sourceId, storeYear, storeDay, storeMonth, locationId, storeDate, isDefault];

  RuleAllocationData copyWith({
    int? id,
    int? sourceId,
    int? storeYear,
    int? storeMonth,
    int? storeDay,
    int? locationId,
    String? storeDate,
    bool? isDefault,
  }) => RuleAllocationData(
      id: id ?? this.id,
      sourceId: sourceId ?? this.sourceId,
      storeYear: storeYear ?? this.storeYear,
      storeMonth: storeMonth ?? this.storeMonth,
      storeDay: storeDay ?? this.storeDay,
      locationId: locationId ?? this.locationId,
      storeDate: storeDate ?? this.storeDate,
      isDefault: isDefault ?? this.isDefault,
    );
}
