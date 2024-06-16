// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplier_account_update_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupplierAccountUpdateRequest _$SupplierAccountUpdateRequestFromJson(
        Map<String, dynamic> json) =>
    SupplierAccountUpdateRequest(
      bankId: json['bank_id'] as int?,
      account: json['account'] as String?,
      serviceName: json['service_name'] as String?,
      payMin: (json['pay_min'] as num?)?.toDouble() ?? 0,
      payMax: (json['pay_max'] as num?)?.toDouble() ?? -1,
      enabled: json['enabled'] as bool? ?? false,
      serviceShortName: json['service_short_name'] as String?,
      dateEnd: json['date_end'] == null
          ? null
          : DateTime.parse(json['date_end'] as String),
      advanceEnabled: json['advance_enabled'] as bool? ?? true,
      stornoMode: json['storno_mode'] as String?,
      attrName: json['attr_name'] as String?,
      valueType: json['value_type'] as String?,
      minLength: json['min_length'] as int? ?? 0,
      maxLength: json['max_length'] as int? ?? -1,
      scenarioId: json['scenario_id'] as int?,
      claimOnly: json['claim_only'] as bool? ?? false,
      nameGroup: json['name_group'] as bool? ?? false,
      adressGroup: json['address_group'] as bool? ?? false,
    )..autogenPan = json['auto_gen_pan'] as bool?;

Map<String, dynamic> _$SupplierAccountUpdateRequestToJson(
    SupplierAccountUpdateRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('bank_id', instance.bankId);
  writeNotNull('account', instance.account);
  writeNotNull('auto_gen_pan', instance.autogenPan);
  writeNotNull('service_name', instance.serviceName);
  val['pay_min'] = instance.payMin;
  val['pay_max'] = instance.payMax;
  writeNotNull('enabled', instance.enabled);
  writeNotNull('service_short_name', instance.serviceShortName);
  writeNotNull('date_end', instance.dateEnd?.toIso8601String());
  writeNotNull('advance_enabled', instance.advanceEnabled);
  writeNotNull('storno_mode', instance.stornoMode);
  writeNotNull('attr_name', instance.attrName);
  writeNotNull('value_type', instance.valueType);
  val['min_length'] = instance.minLength;
  val['max_length'] = instance.maxLength;
  writeNotNull('scenario_id', instance.scenarioId);
  writeNotNull('claim_only', instance.claimOnly);
  val['name_group'] = instance.nameGroup;
  val['address_group'] = instance.adressGroup;
  return val;
}
