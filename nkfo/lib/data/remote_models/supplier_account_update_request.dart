import 'package:json_annotation/json_annotation.dart';

part 'supplier_account_update_request.g.dart';

@JsonSerializable(includeIfNull: false)
class SupplierAccountUpdateRequest {

  @JsonKey(name: 'bank_id')
  int? bankId;

  @JsonKey(name: 'account')
  String? account;

  @JsonKey(name: 'auto_gen_pan')
  bool? autogenPan;

  @JsonKey(name: 'service_name')
  String? serviceName;

  @JsonKey(name: 'pay_min')
  double payMin;

  @JsonKey(name: 'pay_max')
  double payMax;

  @JsonKey(name: 'enabled')
  bool? enabled;

  @JsonKey(name: 'service_short_name')
  String? serviceShortName;

  @JsonKey(name: 'date_end')
  DateTime? dateEnd;

  @JsonKey(name: 'advance_enabled')
  bool? advanceEnabled;

  @JsonKey(name: 'storno_mode')
  String? stornoMode;

  @JsonKey(name: 'attr_name')
  String? attrName;

  @JsonKey(name: 'value_type')
  String? valueType;

  @JsonKey(name: 'min_length')
  int minLength;

  @JsonKey(name: 'max_length')
  int maxLength;

  @JsonKey(name: 'scenario_id')
  int? scenarioId;

  @JsonKey(name: 'claim_only')
  bool? claimOnly;

  @JsonKey(name: 'name_group')
  bool nameGroup;

  @JsonKey(name: 'address_group')
  bool adressGroup;

  SupplierAccountUpdateRequest({
    this.bankId,
    this.account,
    this.serviceName,
    this.payMin = 0,
    this.payMax = -1,
    this.enabled = false,
    this.serviceShortName,
    this.dateEnd,
    this.advanceEnabled = true,
    this.stornoMode,
    this.attrName,
    this.valueType,
    this.minLength = 0,
    this.maxLength = -1,
    this.scenarioId,
    this.claimOnly = false,
    this.nameGroup = false, 
    this.adressGroup = false
  });

  factory SupplierAccountUpdateRequest.fromJson(Map<String, dynamic> json) => _$SupplierAccountUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SupplierAccountUpdateRequestToJson(this);
}
