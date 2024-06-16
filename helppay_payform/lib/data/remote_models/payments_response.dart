import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payments_response.g.dart';

@JsonSerializable()
class PaymentsResponse {

  @JsonKey(name: 'Error')
  final String? error;

  @JsonKey(name: 'TotalAmount')
  final double? totalAmount;

  @JsonKey(name: 'MaxAmount')
  final double? maxAmount;

  @JsonKey(name: 'Payment')
  final List<Payment>? payments;

  PaymentsResponse({
    this.error,
    this.totalAmount,
    this.maxAmount,
    this.payments
  });

  factory PaymentsResponse.fromJson(Map<String, dynamic> json) => _$PaymentsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentsResponseToJson(this);
  
}

@JsonSerializable()
class Payment extends Equatable {

  @JsonKey(name: 'PaymentID')
  final int id;

  @JsonKey(name: 'Date')
  final String date;

  @JsonKey(name: 'KioskReceipt')
  final String kioskReceipt;

  @JsonKey(name: 'Amount')
  final double amount;

  @JsonKey(name: 'Description')
  final String? description;

  @JsonKey(name: 'AccNum')
  final String accNum;

  @JsonKey(name: 'DIType')
  final int? diType;

  const Payment({
    required this.id,
    required this.date,
    required this.kioskReceipt,
    required this.amount,
    required this.description,
    required this.accNum,
    required this.diType
  });

  factory Payment.fromJson(Map<String, dynamic> json) => _$PaymentFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentToJson(this);

  @override

  List<Object?> get props => [id, date, kioskReceipt, amount, description, diType];

}