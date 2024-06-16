import 'package:json_annotation/json_annotation.dart';

part 'supplier_account_insert_request.g.dart';

@JsonSerializable()
class SupplierAccountInsertRequest {

  @JsonKey(name: 'supplier_id')
  int? supplierId;

  @JsonKey(name: 'payment_system_service_code')
  String? paymentSystemServiceCode;

  @JsonKey(name: 'service_short_name')
  String? serviceShortName;

  @JsonKey(name: 'enabled')
  bool enabled;

  @JsonKey(name: 'service_name')
  String? serviceName;

  @JsonKey(name: 'date_start')
  DateTime? dateStart;

  @JsonKey(name: 'date_end')
  DateTime? dateEnd;

  @JsonKey(name: 'bank_id')
  int? bankId;

  @JsonKey(name: 'account')
  String? account;

  @JsonKey(name: 'pay_min')
  double? payMin;

  @JsonKey(name: 'pay_max')
  double? payMax;

  /// Разрешен авансовый платеж
  @JsonKey(name: 'advance_enabled')
  bool advanceEnabled;

  /// Оплата только по требованию
  @JsonKey(name: 'claim_only')
  bool claimOnly;

  @JsonKey(name: 'attr_name')
  String? attrName;

  @JsonKey(name: 'value_type')
  String? valueType;

  @JsonKey(name: 'min_length')
  int? minLength;

  @JsonKey(name: 'max_length')
  int? maxLength;

  /// Признак генерации номера лицевого счета
  @JsonKey(name: 'auto_gen_pan')
  bool autogenPan;

  @JsonKey(name: 'storno_mode')
  String? stornoMode;

  @JsonKey(name: 'scenario_id')
  int? scenarioId;

  @JsonKey(name: 'name_group')
  bool nameGroup;

  @JsonKey(name: 'address_group')
  bool adressGroup;

  SupplierAccountInsertRequest({
    this.supplierId,
    this.paymentSystemServiceCode,
    this.serviceShortName,
    this.enabled = false,
    this.serviceName,
    this.dateStart,
    this.dateEnd,
    this.bankId,
    this.account,
    this.payMin,
    this.payMax,
    this.advanceEnabled = false,
    this.claimOnly = true,
    this.attrName,
    this.valueType,
    this.minLength,
    this.maxLength,
    this.autogenPan = false,
    this.stornoMode,
    this.scenarioId,
    this.nameGroup = false, 
    this.adressGroup = false
  });

  factory SupplierAccountInsertRequest.fromJson(Map<String, dynamic> json) => _$SupplierAccountInsertRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SupplierAccountInsertRequestToJson(this);
  
  SupplierAccountInsertRequest copyWith({
    int? supplierId,
    String? paymentSystemServiceCode,
    String? serviceShortName,
    bool? enabled,
    String? serviceName,
    DateTime? dateStart,
    DateTime? dateEnd,
    int? bankId,
    String? account,
    double? payMin,
    double? payMax,
    bool? advanceEnabled,
    bool? claimOnly,
    String? attrName,
    String? valueType,
    int? minLength,
    int? maxLength,
    bool? autogenPan,
    String? stornoMode,
    int? scenarioId,
    bool? nameGroup,
    bool? adressGroup,
  }) => SupplierAccountInsertRequest(
      supplierId: supplierId ?? this.supplierId,
      paymentSystemServiceCode: paymentSystemServiceCode ?? this.paymentSystemServiceCode,
      serviceShortName: serviceShortName ?? this.serviceShortName,
      enabled: enabled ?? this.enabled,
      serviceName: serviceName ?? this.serviceName,
      dateStart: dateStart ?? this.dateStart,
      dateEnd: dateEnd ?? this.dateEnd,
      bankId: bankId ?? this.bankId,
      account: account ?? this.account,
      payMin: payMin ?? this.payMin,
      payMax: payMax ?? this.payMax,
      advanceEnabled: advanceEnabled ?? this.advanceEnabled,
      claimOnly: claimOnly ?? this.claimOnly,
      attrName: attrName ?? this.attrName,
      valueType: valueType ?? this.valueType,
      minLength: minLength ?? this.minLength,
      maxLength: maxLength ?? this.maxLength,
      autogenPan: autogenPan ?? this.autogenPan,
      stornoMode: stornoMode ?? this.stornoMode,
      scenarioId: scenarioId ?? this.scenarioId,
      nameGroup: nameGroup ?? this.nameGroup,
      adressGroup: adressGroup ?? this.adressGroup,
    );
}
