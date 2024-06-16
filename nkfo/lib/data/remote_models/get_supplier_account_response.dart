import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:web_cabinet_nkfo/models/models.dart';

part 'get_supplier_account_response.g.dart';

@JsonSerializable()
class SupplierAccount {

  @JsonKey(name: 'supplier_account_id')
  final int id;

  @JsonKey(name: 'supplier_id')
  final int supplierId;

  @JsonKey(name: 'bank_id')
  final int? bankId;

  @JsonKey(name: 'account')
  final String? account;

  @JsonKey(name: 'service_name')
  final String? serviceName;

  @JsonKey(name: 'pay_min')
  final double? payMin;

  @JsonKey(name: 'pay_max')
  final double? payMax;

  @JsonKey(name: 'enabled')
  final bool enabled;

  @JsonKey(name: 'payment_system_service_code')
  final String? paymentSystemServiceCode;

  @JsonKey(name: 'service_short_name')
  final String? serviceShortName;

  @JsonKey(name: 'date_start')
  final DateTime? dateStart;

  @JsonKey(name: 'date_end')
  final DateTime? dateEnd;

  @JsonKey(name: 'auto_gen_pan')
  final bool autogenPan;

  @JsonKey(name: 'advance_enabled')
  final bool advanceEnabled;

  @JsonKey(name: 'storno_mode')
  final String? stornoMode;

  @JsonKey(name: 'bank_bic')
  final String? bic;

  @JsonKey(name: 'attr_name')
  final String? attrName;

  @JsonKey(name: 'value_type')
  final String? valueType;

  @JsonKey(name: 'min_length')
  final int? minLength;

  @JsonKey(name: 'max_length')
  final int? maxLength;

  @JsonKey(name: 'scenario_id')
  final int? scenarioId;

  @JsonKey(name: 'qr_code')
  final String? qrCode;

  @JsonKey(name: 'claim_only')
  final bool claimOnly;

  @JsonKey(name: 'name_group')
  final bool nameGroup;

  @JsonKey(name: 'address_group')
  final bool adressGroup;



  SupplierAccount({
    required this.id,
    required this.supplierId,
    this.bankId,
    this.account,
    this.serviceName,
    this.payMin,
    this.payMax,
    this.enabled = false,
    this.paymentSystemServiceCode,
    this.serviceShortName,
    this.dateStart,
    this.dateEnd,
    this.autogenPan = false,
    this.advanceEnabled = false,
    this.stornoMode,
    this.bic,
    this.attrName,
    this.valueType,
    this.minLength,
    this.maxLength,
    this.scenarioId,
    this.qrCode,
    this.claimOnly = false,
    this.nameGroup = false, 
    this.adressGroup = false
  });

  factory SupplierAccount.fromJson(Map<String, dynamic> json) => _$SupplierAccountFromJson(json);

  Map<String, dynamic> toJson() => _$SupplierAccountToJson(this);

  Color get statusColor => enabled ? CupertinoColors.systemGreen : CupertinoColors.systemRed;

  String get statusText => enabled ? 'Активна' : 'Неактивна';

  PersonalAccountValueType get valueTypeEnum => PersonalAccountValueTypeExtension.fromName(valueType);

  PersonalAccountStornoMode get stornoModeEnum => PersonalAccountStornoModeExtension.fromName(stornoMode);
  

  SupplierAccount copyWith({
    int? id,
    int? supplierId,
    int? bankId,
    String? account,
    String? serviceName,
    double? payMin,
    double? payMax,
    bool? enabled,
    String? paymentSystemServiceCode,
    String? serviceShortName,
    DateTime? dateStart,
    DateTime? dateEnd,
    bool? autogenPan,
    bool? advanceEnabled,
    String? stornoMode,
    String? bic,
    String? attrName,
    String? valueType,
    int? minLength,
    int? maxLength,
    int? scenarioId,
    String? qrCode,
    bool? claimOnly,
    bool? nameGroup,
    bool? adressGroup,
  }) => SupplierAccount(
      id: id ?? this.id,
      supplierId: supplierId ?? this.supplierId,
      bankId: bankId ?? this.bankId,
      account: account ?? this.account,
      serviceName: serviceName ?? this.serviceName,
      payMin: payMin ?? this.payMin,
      payMax: payMax ?? this.payMax,
      enabled: enabled ?? this.enabled,
      paymentSystemServiceCode: paymentSystemServiceCode ?? this.paymentSystemServiceCode,
      serviceShortName: serviceShortName ?? this.serviceShortName,
      dateStart: dateStart ?? this.dateStart,
      dateEnd: dateEnd ?? this.dateEnd,
      autogenPan: autogenPan ?? this.autogenPan,
      advanceEnabled: advanceEnabled ?? this.advanceEnabled,
      stornoMode: stornoMode ?? this.stornoMode,
      bic: bic ?? this.bic,
      attrName: attrName ?? this.attrName,
      valueType: valueType ?? this.valueType,
      minLength: minLength ?? this.minLength,
      maxLength: maxLength ?? this.maxLength,
      scenarioId: scenarioId ?? this.scenarioId,
      qrCode: qrCode ?? this.qrCode,
      claimOnly: claimOnly ?? this.claimOnly,
      nameGroup: nameGroup ?? this.nameGroup,
      adressGroup: adressGroup ?? this.adressGroup,
    );
}
