


import 'package:json_annotation/json_annotation.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/utils/utils.dart';

part 'prepare_search_payment_request.g.dart';

@JsonSerializable()
class SearchPaymentIdsData  {

  @JsonKey(name: 'p_id')
  final String? uuid;

  @JsonKey(name: 'p_source_id')
  final int? sourceId;

  @JsonKey(name: 'p_limit')
  final int? limit;

  @JsonKey(name: 'p_prev_idx_on_second')
  final int? prevIdxOnsecond;

  @JsonKey(name: 'p_prev_source_id')
  final int? prevSourceId;

  @JsonKey(name: 'p_prev_date')
  final DateTime? prevDate;

  @JsonKey(name: 'p_payment_external_id_list')
  final List<String>? ids;

  SearchPaymentIdsData({
    this.uuid,
    this.limit,
    this.sourceId,
    this.prevIdxOnsecond,
    this.prevSourceId,
    this.prevDate,
    this.ids,
  });
}

@JsonSerializable()
class SearchPaymentNamesData  {

  @JsonKey(name: 'p_id')
  final String? uuid;

  @JsonKey(name: 'p_source_id')
  final int? sourceId;

  @JsonKey(name: 'p_limit')
  final int? limit;

  @JsonKey(name: 'p_prev_idx_on_second')
  final int? prevIdxOnsecond;

  @JsonKey(name: 'p_prev_source_id')
  final int? prevSourceId;

  @JsonKey(name: 'p_prev_date')
  final DateTime? prevDate;

  @JsonKey(name: 'p_full_name_list')
  final List<String>? names;

  SearchPaymentNamesData({
    this.uuid,
    this.sourceId,
    this.limit,
    this.prevIdxOnsecond,
    this.prevSourceId,
    this.prevDate,
    this.names,
  });
}

@JsonSerializable()
class SearchPaymentData {

  @JsonKey(includeToJson: false)
  final SearchPaymentMethod? searchPaymentMethod;

  @JsonKey(name: 'p_id')
  final String? uuid;

  @JsonKey(name: 'p_bik')
  final String? bik;

  @JsonKey(name: 'p_receipt_no')
  final String? receiptNo;
  
  @JsonKey(name: 'p_source_id')
  final int? sourceId;
  
  @JsonKey(name: 'p_date_from')
  final DateTime? dateFrom;
  
  @JsonKey(name: 'p_date_to')
  final DateTime? dateTo;

  @JsonKey(name: 'p_payment_id')
  final int? paymentId;
  
  @JsonKey(name: 'p_payer_full_name')
  final String? payerName;
  
  @JsonKey(name: 'p_payer_doc')
  final String? payerDoc;

  @JsonKey(name: 'p_payer_in')
  final String? payerIn;
  
  @JsonKey(name: 'p_payer_address')
  final String? payerAddress;

  @JsonKey(name: 'p_payer_account')
  final String? payerAccount;
  
  @JsonKey(name: 'p_supplier_name')
  final String? supplierName;
  
  @JsonKey(name: 'p_supplier_account')
  final String? supplierAccount;
  
  @JsonKey(name: 'p_supplier_unp')
  final String? supplierUnp;

  @JsonKey(name: 'p_budget_code')
  final int? budgetCode;

  @JsonKey(name: 'p_service_name')
  final String? serviceName;
  
  @JsonKey(name: 'p_pay_sum_min')
  final double? paySumMin;
  
  @JsonKey(name: 'p_pay_sum_max')
  final double? paySumMax;
  
  @JsonKey(name: 'p_external_system_payment_id')
  final String? systemPaymentId;

  @JsonKey(name: 'p_prev_idx_on_second')
  final int? prevIdxOnsecond;

  @JsonKey(name: 'p_prev_source_id')
  final int? prevSourceId;

  @JsonKey(name: 'p_prev_date')
  final DateTime? prevDate;

  @JsonKey(name: 'p_limit')
  final int? limit;

  @JsonKey(name: 'p_terminal_id')
  final String? terminalId;

  @JsonKey(name: 'p_terminal_dept')
  final int? terminalDept;
  
  @JsonKey(name: 'p_auth_type', unknownEnumValue: PaymentMethodModel.all)
  final PaymentMethodModel? paymentMethod;

  @JsonKey(includeToJson: false)
  final List<String>? ids;

  @JsonKey(includeToJson: false)
  final List<String>? names; 

  const SearchPaymentData({
    this.searchPaymentMethod,
    this.uuid,
    this.bik,
    this.receiptNo,
    this.sourceId,
    this.dateFrom,
    this.dateTo,
    this.paymentId,
    this.payerName,
    this.payerDoc,
    this.payerIn,
    this.payerAddress,
    this.payerAccount,
    this.supplierName,
    this.supplierAccount,
    this.supplierUnp,
    this.budgetCode,
    this.serviceName,
    this.paySumMin,
    this.paySumMax,
    this.systemPaymentId,
    this.prevIdxOnsecond,
    this.prevSourceId,
    this.prevDate,
    this.limit,
    this.terminalId,
    this.terminalDept,
    this.paymentMethod,
    this.ids,
    this.names,
  });


  factory SearchPaymentData.empty() =>  const SearchPaymentData();

  Map<String, dynamic> toJson() {
    switch (searchPaymentMethod) {
      case SearchPaymentMethod.full:
        return _$SearchPaymentDataToJson(this);
      case SearchPaymentMethod.ids:
        return _$SearchPaymentIdsDataToJson(SearchPaymentIdsData(
          ids: ids,
          uuid: uuid,
          limit: limit,
          sourceId: sourceId,
          prevIdxOnsecond: prevIdxOnsecond,
          prevSourceId: prevSourceId,
          prevDate: prevDate
        ));
      case SearchPaymentMethod.names:
        return _$SearchPaymentNamesDataToJson(SearchPaymentNamesData(
          names: names,
          uuid: uuid,
          limit: limit,
          sourceId: sourceId,
          prevIdxOnsecond: prevIdxOnsecond,
          prevSourceId: prevSourceId,
          prevDate: prevDate          
        ));            
      default:
      return _$SearchPaymentDataToJson(this);
    }
  } 


  List<Object?> get filterProps => [dateFrom?.toStringFormattedGetOperationHistory(), dateTo?.toStringFormattedGetOperationHistory(), 
    paymentId, payerName, payerIn, payerDoc, payerAddress, payerAccount, supplierName, supplierAccount, bik, supplierUnp, budgetCode, 
    serviceName, paySumMin, paySumMax, receiptNo, systemPaymentId, terminalDept, terminalId, paymentMethod?.name 
  ];


  SearchPaymentData copyWith({
    SearchPaymentMethod? searchPaymentMethod,
    String? uuid,
    String? bik,
    String? receiptNo,
    int? sourceId,
    DateTime? dateFrom,
    DateTime? dateTo,
    Wrapped<int?>? paymentId,
    String? payerName,
    String? payerDoc,
    String? payerIn,
    String? payerAddress,
    String? payerAccount,
    String? supplierName,
    String? supplierAccount,
    String? supplierUnp,
    Wrapped<int?>? budgetCode,
    String? serviceName,
    Wrapped<double?>? paySumMin,    
    Wrapped<double?>? paySumMax,    
    String? systemPaymentId,
    int? prevIdxOnsecond,
    int? prevSourceId,
    DateTime? prevDate,
    int? limit,
    String? terminalId,
    Wrapped<int?>? terminalDept,    
    PaymentMethodModel? paymentMethod,
    List<String>? ids,
    List<String>? names,
  }) => SearchPaymentData(
      searchPaymentMethod: searchPaymentMethod ?? this.searchPaymentMethod,
      uuid: uuid ?? this.uuid,
      bik: bik ?? this.bik,
      receiptNo: receiptNo ?? this.receiptNo,
      sourceId: sourceId ?? this.sourceId,
      dateFrom: dateFrom ?? this.dateFrom,
      dateTo: dateTo ?? this.dateTo,
      paymentId:paymentId != null ? paymentId.value : this.paymentId,
      payerName: payerName ?? this.payerName,
      payerDoc: payerDoc ?? this.payerDoc,
      payerIn: payerIn ?? this.payerIn,
      payerAddress: payerAddress ?? this.payerAddress,
      payerAccount: payerAccount ?? this.payerAccount,
      supplierName: supplierName ?? this.supplierName,
      supplierAccount: supplierAccount ?? this.supplierAccount,
      supplierUnp: supplierUnp ?? this.supplierUnp,
      budgetCode: budgetCode != null ? budgetCode.value : this.budgetCode,
      serviceName: serviceName ?? this.serviceName,
      paySumMin: paySumMin != null ? paySumMin.value : this.paySumMin,   
      paySumMax: paySumMax != null ? paySumMax.value : this.paySumMax,               
      systemPaymentId: systemPaymentId ?? this.systemPaymentId,
      prevIdxOnsecond: prevIdxOnsecond ?? this.prevIdxOnsecond,
      prevSourceId: prevSourceId ?? this.prevSourceId,
      prevDate: prevDate ?? this.prevDate,
      limit: limit ?? this.limit,
      terminalId: terminalId ?? this.terminalId,
      terminalDept: terminalDept != null ? terminalDept.value : this.terminalDept,      
      paymentMethod: paymentMethod ?? this.paymentMethod,
      ids: ids ?? this.ids,
      names: names ?? this.names,
    );
}

class Wrapped<T> {
  final T value;
  const Wrapped.value(this.value);
}