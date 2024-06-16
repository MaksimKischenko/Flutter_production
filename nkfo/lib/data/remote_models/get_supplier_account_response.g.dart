// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_supplier_account_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupplierAccount _$SupplierAccountFromJson(Map<String, dynamic> json) =>
    SupplierAccount(
      id: json['supplier_account_id'] as int,
      supplierId: json['supplier_id'] as int,
      bankId: json['bank_id'] as int?,
      account: json['account'] as String?,
      serviceName: json['service_name'] as String?,
      payMin: (json['pay_min'] as num?)?.toDouble(),
      payMax: (json['pay_max'] as num?)?.toDouble(),
      enabled: json['enabled'] as bool? ?? false,
      paymentSystemServiceCode: json['payment_system_service_code'] as String?,
      serviceShortName: json['service_short_name'] as String?,
      dateStart: json['date_start'] == null
          ? null
          : DateTime.parse(json['date_start'] as String),
      dateEnd: json['date_end'] == null
          ? null
          : DateTime.parse(json['date_end'] as String),
      autogenPan: json['auto_gen_pan'] as bool? ?? false,
      advanceEnabled: json['advance_enabled'] as bool? ?? false,
      stornoMode: json['storno_mode'] as String?,
      bic: json['bank_bic'] as String?,
      attrName: json['attr_name'] as String?,
      valueType: json['value_type'] as String?,
      minLength: json['min_length'] as int?,
      maxLength: json['max_length'] as int?,
      scenarioId: json['scenario_id'] as int?,
      qrCode: json['qr_code'] as String?,
      claimOnly: json['claim_only'] as bool? ?? false,
      nameGroup: json['name_group'] as bool? ?? false,
      adressGroup: json['address_group'] as bool? ?? false,
    );

Map<String, dynamic> _$SupplierAccountToJson(SupplierAccount instance) =>
    <String, dynamic>{
      'supplier_account_id': instance.id,
      'supplier_id': instance.supplierId,
      'bank_id': instance.bankId,
      'account': instance.account,
      'service_name': instance.serviceName,
      'pay_min': instance.payMin,
      'pay_max': instance.payMax,
      'enabled': instance.enabled,
      'payment_system_service_code': instance.paymentSystemServiceCode,
      'service_short_name': instance.serviceShortName,
      'date_start': instance.dateStart?.toIso8601String(),
      'date_end': instance.dateEnd?.toIso8601String(),
      'auto_gen_pan': instance.autogenPan,
      'advance_enabled': instance.advanceEnabled,
      'storno_mode': instance.stornoMode,
      'bank_bic': instance.bic,
      'attr_name': instance.attrName,
      'value_type': instance.valueType,
      'min_length': instance.minLength,
      'max_length': instance.maxLength,
      'scenario_id': instance.scenarioId,
      'qr_code': instance.qrCode,
      'claim_only': instance.claimOnly,
      'name_group': instance.nameGroup,
      'address_group': instance.adressGroup,
    };
