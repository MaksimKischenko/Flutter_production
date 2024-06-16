// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payments_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentsResponse _$PaymentsResponseFromJson(Map<String, dynamic> json) =>
    PaymentsResponse(
      error: json['Error'] as String?,
      totalAmount: (json['TotalAmount'] as num?)?.toDouble(),
      maxAmount: (json['MaxAmount'] as num?)?.toDouble(),
      payments: (json['Payment'] as List<dynamic>?)
          ?.map((e) => Payment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PaymentsResponseToJson(PaymentsResponse instance) =>
    <String, dynamic>{
      'Error': instance.error,
      'TotalAmount': instance.totalAmount,
      'MaxAmount': instance.maxAmount,
      'Payment': instance.payments,
    };

Payment _$PaymentFromJson(Map<String, dynamic> json) => Payment(
      id: json['PaymentID'] as int,
      date: json['Date'] as String,
      kioskReceipt: json['KioskReceipt'] as String,
      amount: (json['Amount'] as num).toDouble(),
      description: json['Description'] as String?,
      accNum: json['AccNum'] as String,
      diType: json['DIType'] as int?,
    );

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
      'PaymentID': instance.id,
      'Date': instance.date,
      'KioskReceipt': instance.kioskReceipt,
      'Amount': instance.amount,
      'Description': instance.description,
      'AccNum': instance.accNum,
      'DIType': instance.diType,
    };
