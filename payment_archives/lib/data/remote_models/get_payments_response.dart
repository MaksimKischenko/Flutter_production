import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_payments_response.g.dart';

@JsonSerializable()
class Payment extends Equatable {

  @JsonKey(name: 'id')
  final String uuid;

  @JsonKey(name: 'source_id')
  final int? sourceId;

  @JsonKey(name: 'archive_id')
  final int? archiveId;

  @JsonKey(name: 'part_id')
  final int? partId;

  @JsonKey(name: 'payer_in')
  final String? payerId;

  @JsonKey(name: 'bank_bik')
  final String? bankBik;

  @JsonKey(name: 'full_name_depositor')
  final String? fullNameDepositor;

  @JsonKey(name: 'depositor_address')
  final String? depositorAddress;

  @JsonKey(name: 'region')
  final String? region;

  @JsonKey(name: 'receipt_no')
  final String? receiptNo;

  @JsonKey(name: 'commission_sum')
  final double? commissionSum;

  @JsonKey(name: 'idx')
  final int? idx;

  @JsonKey(name: 'payment_id')
  final int? paymentId;

  @JsonKey(name: 'status')
  final int? status;

  @JsonKey(name: 'external_system_supplier_id')
  final int? externalSystemSupplierId;

  @JsonKey(name: 'supplier_id')
  final int? supplierId;

  @JsonKey(name: 'supplier_name')
  final String? supplierName;

  @JsonKey(name: 'supplier_account')
  final String? supplierAccount;

  @JsonKey(name: 'supplier_unp')
  final String? supplierUnp;

  @JsonKey(name: 'bank_name')
  final String? bankName;

  @JsonKey(name: 'external_system_service_code')
  final String? externalSystemServiceCode;

  @JsonKey(name: 'service_code')
  final int? serviceCode;

  @JsonKey(name: 'service_name')
  final String? serviceName;

  @JsonKey(name: 'service_shortname')
  final String? serviceShortname;

  @JsonKey(name: 'budget_code')
  final int? budgetCode;

  @JsonKey(name: 'external_system_payer_id')
  final int? externalSystemPayerId;

  @JsonKey(name: 'payer_full_name')
  final String? payerFullName;

  @JsonKey(name: 'payer_doc')
  final String? payerDoc;

  @JsonKey(name: 'payer_address')
  final String? payerAddress;

  @JsonKey(name: 'payer_account')
  final String? payerAccount;

  @JsonKey(name: 'pay_date')
  final DateTime? payDate;

  @JsonKey(name: 'pay_sum')
  final double? paySum;

  @JsonKey(name: 'pay_direction')
  final int? payDirection;

  @JsonKey(name: 'penalty_sum')
  final double? penaltySum;

  @JsonKey(name: 'external_system_payment_id')
  final String? externalSystemPaymentId;

  @JsonKey(name: 'external_system_name')
  final String? externalSystemName;

  @JsonKey(name: 'terminal_id')
  final String? terminalId;

  @JsonKey(name: 'terminal_dept')
  final int? terminalDept;

  @JsonKey(name: 'dept_filial')
  final int? deptFilial;

  @JsonKey(name: 'terminal_location')
  final String? terminaLocation;

  @JsonKey(name: 'consolidated_doc_id')
  final int? consolidatedDocId;

  @JsonKey(name: 'idx_on_second')
  final int? idxOnSecond;

  @JsonKey(name: 'consolidated_doc_date')
  final DateTime? consolidatedDocDate;

  @JsonKey(name: 'consolidated_doc_sum')
  final double? consolidatedDocSum;

  @JsonKey(name: 'consolidated_doc_pay_string')
  final String? consolidatedDocPayString;

  @JsonKey(name: 'consolidated_export_file_name')
  final String? consolidatedExportFileName;

  @JsonKey(name: 'currency')
  final int? currency;

  @JsonKey(name: 'card_number')
  final String? cardNumber;
  

  const Payment({
    required this.uuid,
    this.sourceId,
    this.archiveId,
    this.partId,
    this.payerId,
    this.bankBik,
    this.fullNameDepositor,
    this.depositorAddress,
    this.region,
    this.receiptNo,
    this.commissionSum,
    this.idx,
    this.paymentId,
    this.status,
    this.externalSystemSupplierId,
    this.supplierId,
    this.supplierName,
    this.supplierAccount,
    this.supplierUnp,
    this.bankName,
    this.externalSystemServiceCode,
    this.serviceCode,
    this.serviceName,
    this.serviceShortname,
    this.budgetCode,
    this.externalSystemPayerId,
    this.payerFullName,
    this.payerDoc,
    this.payerAddress,
    this.payerAccount,
    this.payDate,
    this.paySum,
    this.payDirection,
    this.penaltySum,
    this.externalSystemPaymentId,
    this.externalSystemName,
    this.terminalId,
    this.terminalDept,
    this.deptFilial,
    this.terminaLocation,
    this.consolidatedDocId,
    this.idxOnSecond,
    this.consolidatedDocDate,
    this.consolidatedDocSum,
    this.consolidatedDocPayString,
    this.consolidatedExportFileName,
    this.currency,
    this.cardNumber
  });


  factory Payment.fromJson(Map<String, dynamic> json) => _$PaymentFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentToJson(this);
  
  @override
  List<Object?> get props => [
      uuid,
      payerId,
      fullNameDepositor,
      depositorAddress,
      commissionSum,
      region,
      receiptNo,
      sourceId,
      archiveId,
      partId,
      idx,
      paymentId,
      status,
      externalSystemSupplierId,
      supplierId,
      supplierName,
      supplierAccount,
      supplierUnp,
      externalSystemServiceCode,
      serviceCode,
      serviceName,
      bankName,
      serviceShortname,
      budgetCode,
      externalSystemPayerId,
      payerFullName,
      payerDoc,
      payerAddress,
      payerAccount,
      payDate,
      paySum,
      bankBik,
      payDirection,
      penaltySum,
      externalSystemPaymentId,
      externalSystemName,
      terminalId,
      terminalDept,
      deptFilial,
      terminaLocation,
      consolidatedDocId,
      consolidatedDocDate,
      consolidatedDocSum,
      consolidatedDocPayString,
      consolidatedExportFileName,
      idxOnSecond,
      currency,
      cardNumber
    ];


  Payment copyWith({
    String? uuid,
    int? sourceId,
    int? archiveId,
    int? partId,
    String? payerId,
    String? bankBik,
    String? fullNameDepositor,
    String? depositorAddress,
    String? region,
    String? receiptNo,
    double? commissionSum,
    int? idx,
    int? paymentId,
    int? status,
    int? externalSystemSupplierId,
    int? supplierId,
    String? supplierName,
    String? supplierAccount,
    String? supplierUnp,
    String? bankName,
    String? externalSystemServiceCode,
    int? serviceCode,
    String? serviceName,
    String? serviceShortname,
    int? budgetCode,
    int? externalSystemPayerId,
    String? payerFullName,
    String? payerDoc,
    String? payerAddress,
    String? payerAccount,
    DateTime? payDate,
    double? paySum,
    int? payDirection,
    double? penaltySum,
    String? externalSystemPaymentId,
    String? externalSystemName,
    String? terminalId,
    int? terminalDept,
    int? deptFilial,
    String? terminaLocation,
    int? consolidatedDocId,
    int? idxOnSecond,
    DateTime? consolidatedDocDate,
    double? consolidatedDocSum,
    String? consolidatedDocPayString,
    String? consolidatedExportFileName,
    int? currency,
    String? cardNumber,
  }) => Payment(
      uuid: uuid ?? this.uuid,
      sourceId: sourceId ?? this.sourceId,
      archiveId: archiveId ?? this.archiveId,
      partId: partId ?? this.partId,
      payerId: payerId ?? this.payerId,
      bankBik: bankBik ?? this.bankBik,
      fullNameDepositor: fullNameDepositor ?? this.fullNameDepositor,
      depositorAddress: depositorAddress ?? this.depositorAddress,
      region: region ?? this.region,
      receiptNo: receiptNo ?? this.receiptNo,
      commissionSum: commissionSum ?? this.commissionSum,
      idx: idx ?? this.idx,
      paymentId: paymentId ?? this.paymentId,
      status: status ?? this.status,
      externalSystemSupplierId: externalSystemSupplierId ?? this.externalSystemSupplierId,
      supplierId: supplierId ?? this.supplierId,
      supplierName: supplierName ?? this.supplierName,
      supplierAccount: supplierAccount ?? this.supplierAccount,
      supplierUnp: supplierUnp ?? this.supplierUnp,
      bankName: bankName ?? this.bankName,
      externalSystemServiceCode: externalSystemServiceCode ?? this.externalSystemServiceCode,
      serviceCode: serviceCode ?? this.serviceCode,
      serviceName: serviceName ?? this.serviceName,
      serviceShortname: serviceShortname ?? this.serviceShortname,
      budgetCode: budgetCode ?? this.budgetCode,
      externalSystemPayerId: externalSystemPayerId ?? this.externalSystemPayerId,
      payerFullName: payerFullName ?? this.payerFullName,
      payerDoc: payerDoc ?? this.payerDoc,
      payerAddress: payerAddress ?? this.payerAddress,
      payerAccount: payerAccount ?? this.payerAccount,
      payDate: payDate ?? this.payDate,
      paySum: paySum ?? this.paySum,
      payDirection: payDirection ?? this.payDirection,
      penaltySum: penaltySum ?? this.penaltySum,
      externalSystemPaymentId: externalSystemPaymentId ?? this.externalSystemPaymentId,
      externalSystemName: externalSystemName ?? this.externalSystemName,
      terminalId: terminalId ?? this.terminalId,
      terminalDept: terminalDept ?? this.terminalDept,
      deptFilial: deptFilial ?? this.deptFilial,
      terminaLocation: terminaLocation ?? this.terminaLocation,
      consolidatedDocId: consolidatedDocId ?? this.consolidatedDocId,
      idxOnSecond: idxOnSecond ?? this.idxOnSecond,
      consolidatedDocDate: consolidatedDocDate ?? this.consolidatedDocDate,
      consolidatedDocSum: consolidatedDocSum ?? this.consolidatedDocSum,
      consolidatedDocPayString: consolidatedDocPayString ?? this.consolidatedDocPayString,
      consolidatedExportFileName: consolidatedExportFileName ?? this.consolidatedExportFileName,
      currency: currency ?? this.currency,
      cardNumber: cardNumber ?? this.cardNumber,
    );
}

