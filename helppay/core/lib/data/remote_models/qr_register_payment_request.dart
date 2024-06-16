// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:helppay_core/data/remote_models/common_models/common_models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'qr_register_payment_request.g.dart';

@JsonSerializable()
class PsHelppayQrRegisterPaymentRequestWrapper {
  @JsonKey(name: 'PS_HELPPAY') //TODO maybe change to proper data
  final PsHelppayQrRegisterPaymentRequest psErip;

  PsHelppayQrRegisterPaymentRequestWrapper(this.psErip);

  factory PsHelppayQrRegisterPaymentRequestWrapper.fromJson(
          Map<String, dynamic> json) =>
      _$PsHelppayQrRegisterPaymentRequestWrapperFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PsHelppayQrRegisterPaymentRequestWrapperToJson(this);
}

@JsonSerializable()
class PsHelppayQrRegisterPaymentRequest {
  @JsonKey(name: 'RegisterPaymentRequest')
  final QrRegisterPaymentRequest request;

  PsHelppayQrRegisterPaymentRequest(this.request);

  factory PsHelppayQrRegisterPaymentRequest.fromJson(
          Map<String, dynamic> json) =>
      _$PsHelppayQrRegisterPaymentRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PsHelppayQrRegisterPaymentRequestToJson(this);
}

@JsonSerializable(includeIfNull: false)
class QrRegisterPaymentRequest {
  @JsonKey(name: 'TerminalID')
  final RegPayMinTerminalID terminalID;

  @JsonKey(name: 'Version')
  final int version;

  @JsonKey(name: 'TypePAN')
  final String typePan;

  @JsonKey(name: 'PAN')
  final QrPan pan;

  @JsonKey(name: 'PayDate')
  final String paymentDate;

  @JsonKey(name: 'KioskReceipt')
  final String kioskReciept;

  @JsonKey(name: 'Cashier')
  final Cashier? cashierData;

  @JsonKey(name: 'PayRecord')
  final PayRecord payRecord;

  QrRegisterPaymentRequest({
    required this.terminalID,
    required this.version,
    required this.typePan,
    required this.pan,
    required this.paymentDate,
    required this.kioskReciept,
    this.cashierData,
    required this.payRecord,
  });

  factory QrRegisterPaymentRequest.fromJson(Map<String, dynamic> json) =>
      _$QrRegisterPaymentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$QrRegisterPaymentRequestToJson(this);
}

@JsonSerializable(includeIfNull: false)
class Cashier {
  @JsonKey(name: 'Value')
  final String value;

  @JsonKey(name: 'FIO')
  final String? fio;

  Cashier({
    required this.value,
    this.fio,
  });

  factory Cashier.fromJson(Map<String, dynamic> json) =>
      _$CashierFromJson(json);

  Map<String, dynamic> toJson() => _$CashierToJson(this);
}

@JsonSerializable(includeIfNull: true)
class PayRecord {
  @JsonKey(name: 'Summa')
  final double? paymentSum; //instead null send 0.0

  @JsonKey(name: 'Currency')
  final int currency; //for BYN - 933

  @JsonKey(name: 'AttrRecord')
  final List<AttrRecord> attributes;

  PayRecord({
    this.paymentSum,
    required this.currency,
    required this.attributes,
  });

  factory PayRecord.fromJson(Map<String, dynamic> json) =>
      _$PayRecordFromJson(json);

  Map<String, dynamic> toJson() => _$PayRecordToJson(this);
}

@JsonSerializable(includeIfNull: true)
class AttrRecord {
  @JsonKey(name: 'Code')
  final int code;

  @JsonKey(name: 'Name')
  final String name;

  @JsonKey(name: 'Value')
  final String value;

  AttrRecord({required this.code, required this.name, required this.value});

  factory AttrRecord.fromJson(Map<String, dynamic> json) =>
      _$AttrRecordFromJson(json);

  Map<String, dynamic> toJson() => _$AttrRecordToJson(this);
}
