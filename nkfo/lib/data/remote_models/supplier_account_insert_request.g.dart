// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplier_account_insert_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupplierAccountInsertRequest _$SupplierAccountInsertRequestFromJson(
        Map<String, dynamic> json) =>
    SupplierAccountInsertRequest(
      supplierId: json['supplier_id'] as int?,
      paymentSystemServiceCode: json['payment_system_service_code'] as String?,
      serviceShortName: json['service_short_name'] as String?,
      enabled: json['enabled'] as bool? ?? false,
      serviceName: json['service_name'] as String?,
      dateStart: json['date_start'] == null
          ? null
          : DateTime.parse(json['date_start'] as String),
      dateEnd: json['date_end'] == null
          ? null
          : DateTime.parse(json['date_end'] as String),
      bankId: json['bank_id'] as int?,
      account: json['account'] as String?,
      payMin: (json['pay_min'] as num?)?.toDouble(),
      payMax: (json['pay_max'] as num?)?.toDouble(),
      advanceEnabled: json['advance_enabled'] as bool? ?? false,
      claimOnly: json['claim_only'] as bool? ?? true,
      attrName: json['attr_name'] as String?,
      valueType: json['value_type'] as String?,
      minLength: json['min_length'] as int?,
      maxLength: json['max_length'] as int?,
      autogenPan: json['auto_gen_pan'] as bool? ?? false,
      stornoMode: json['storno_mode'] as String?,
      scenarioId: json['scenario_id'] as int?,
      nameGroup: json['name_group'] as bool? ?? false,
      adressGroup: json['address_group'] as bool? ?? false,
    );

Map<String, dynamic> _$SupplierAccountInsertRequestToJson(
        SupplierAccountInsertRequest instance) =>
    <String, dynamic>{
      'supplier_id': instance.supplierId,
      'payment_system_service_code': instance.paymentSystemServiceCode,
      'service_short_name': instance.serviceShortName,
      'enabled': instance.enabled,
      'service_name': instance.serviceName,
      'date_start': instance.dateStart?.toIso8601String(),
      'date_end': instance.dateEnd?.toIso8601String(),
      'bank_id': instance.bankId,
      'account': instance.account,
      'pay_min': instance.payMin,
      'pay_max': instance.payMax,
      'advance_enabled': instance.advanceEnabled,
      'claim_only': instance.claimOnly,
      'attr_name': instance.attrName,
      'value_type': instance.valueType,
      'min_length': instance.minLength,
      'max_length': instance.maxLength,
      'auto_gen_pan': instance.autogenPan,
      'storno_mode': instance.stornoMode,
      'scenario_id': instance.scenarioId,
      'name_group': instance.nameGroup,
      'address_group': instance.adressGroup,
    };
