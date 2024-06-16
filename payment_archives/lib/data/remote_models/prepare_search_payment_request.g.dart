// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prepare_search_payment_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchPaymentIdsData _$SearchPaymentIdsDataFromJson(
        Map<String, dynamic> json) =>
    SearchPaymentIdsData(
      uuid: json['p_id'] as String?,
      limit: json['p_limit'] as int?,
      sourceId: json['p_source_id'] as int?,
      prevIdxOnsecond: json['p_prev_idx_on_second'] as int?,
      prevSourceId: json['p_prev_source_id'] as int?,
      prevDate: json['p_prev_date'] == null
          ? null
          : DateTime.parse(json['p_prev_date'] as String),
      ids: (json['p_payment_external_id_list'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$SearchPaymentIdsDataToJson(
        SearchPaymentIdsData instance) =>
    <String, dynamic>{
      'p_id': instance.uuid,
      'p_source_id': instance.sourceId,
      'p_limit': instance.limit,
      'p_prev_idx_on_second': instance.prevIdxOnsecond,
      'p_prev_source_id': instance.prevSourceId,
      'p_prev_date': instance.prevDate?.toIso8601String(),
      'p_payment_external_id_list': instance.ids,
    };

SearchPaymentNamesData _$SearchPaymentNamesDataFromJson(
        Map<String, dynamic> json) =>
    SearchPaymentNamesData(
      uuid: json['p_id'] as String?,
      sourceId: json['p_source_id'] as int?,
      limit: json['p_limit'] as int?,
      prevIdxOnsecond: json['p_prev_idx_on_second'] as int?,
      prevSourceId: json['p_prev_source_id'] as int?,
      prevDate: json['p_prev_date'] == null
          ? null
          : DateTime.parse(json['p_prev_date'] as String),
      names: (json['p_full_name_list'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$SearchPaymentNamesDataToJson(
        SearchPaymentNamesData instance) =>
    <String, dynamic>{
      'p_id': instance.uuid,
      'p_source_id': instance.sourceId,
      'p_limit': instance.limit,
      'p_prev_idx_on_second': instance.prevIdxOnsecond,
      'p_prev_source_id': instance.prevSourceId,
      'p_prev_date': instance.prevDate?.toIso8601String(),
      'p_full_name_list': instance.names,
    };

SearchPaymentData _$SearchPaymentDataFromJson(Map<String, dynamic> json) =>
    SearchPaymentData(
      searchPaymentMethod: $enumDecodeNullable(
          _$SearchPaymentMethodEnumMap, json['searchPaymentMethod']),
      uuid: json['p_id'] as String?,
      bik: json['p_bik'] as String?,
      receiptNo: json['p_receipt_no'] as String?,
      sourceId: json['p_source_id'] as int?,
      dateFrom: json['p_date_from'] == null
          ? null
          : DateTime.parse(json['p_date_from'] as String),
      dateTo: json['p_date_to'] == null
          ? null
          : DateTime.parse(json['p_date_to'] as String),
      paymentId: json['p_payment_id'] as int?,
      payerName: json['p_payer_full_name'] as String?,
      payerDoc: json['p_payer_doc'] as String?,
      payerIn: json['p_payer_in'] as String?,
      payerAddress: json['p_payer_address'] as String?,
      payerAccount: json['p_payer_account'] as String?,
      supplierName: json['p_supplier_name'] as String?,
      supplierAccount: json['p_supplier_account'] as String?,
      supplierUnp: json['p_supplier_unp'] as String?,
      budgetCode: json['p_budget_code'] as int?,
      serviceName: json['p_service_name'] as String?,
      paySumMin: (json['p_pay_sum_min'] as num?)?.toDouble(),
      paySumMax: (json['p_pay_sum_max'] as num?)?.toDouble(),
      systemPaymentId: json['p_external_system_payment_id'] as String?,
      prevIdxOnsecond: json['p_prev_idx_on_second'] as int?,
      prevSourceId: json['p_prev_source_id'] as int?,
      prevDate: json['p_prev_date'] == null
          ? null
          : DateTime.parse(json['p_prev_date'] as String),
      limit: json['p_limit'] as int?,
      terminalId: json['p_terminal_id'] as String?,
      terminalDept: json['p_terminal_dept'] as int?,
      paymentMethod: $enumDecodeNullable(
          _$PaymentMethodModelEnumMap, json['p_auth_type'],
          unknownValue: PaymentMethodModel.all),
      ids: (json['ids'] as List<dynamic>?)?.map((e) => e as String).toList(),
      names:
          (json['names'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$SearchPaymentDataToJson(SearchPaymentData instance) =>
    <String, dynamic>{
      'p_id': instance.uuid,
      'p_bik': instance.bik,
      'p_receipt_no': instance.receiptNo,
      'p_source_id': instance.sourceId,
      'p_date_from': instance.dateFrom?.toIso8601String(),
      'p_date_to': instance.dateTo?.toIso8601String(),
      'p_payment_id': instance.paymentId,
      'p_payer_full_name': instance.payerName,
      'p_payer_doc': instance.payerDoc,
      'p_payer_in': instance.payerIn,
      'p_payer_address': instance.payerAddress,
      'p_payer_account': instance.payerAccount,
      'p_supplier_name': instance.supplierName,
      'p_supplier_account': instance.supplierAccount,
      'p_supplier_unp': instance.supplierUnp,
      'p_budget_code': instance.budgetCode,
      'p_service_name': instance.serviceName,
      'p_pay_sum_min': instance.paySumMin,
      'p_pay_sum_max': instance.paySumMax,
      'p_external_system_payment_id': instance.systemPaymentId,
      'p_prev_idx_on_second': instance.prevIdxOnsecond,
      'p_prev_source_id': instance.prevSourceId,
      'p_prev_date': instance.prevDate?.toIso8601String(),
      'p_limit': instance.limit,
      'p_terminal_id': instance.terminalId,
      'p_terminal_dept': instance.terminalDept,
      'p_auth_type': _$PaymentMethodModelEnumMap[instance.paymentMethod],
    };

const _$SearchPaymentMethodEnumMap = {
  SearchPaymentMethod.full: 'full',
  SearchPaymentMethod.ids: 'ids',
  SearchPaymentMethod.names: 'names',
};

const _$PaymentMethodModelEnumMap = {
  PaymentMethodModel.all: null,
  PaymentMethodModel.middle: 0,
  PaymentMethodModel.huge: 1,
};
