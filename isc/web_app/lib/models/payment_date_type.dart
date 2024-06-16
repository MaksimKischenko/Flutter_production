import 'package:json_annotation/json_annotation.dart';

enum PaymentDateType {
  /// 0
  @JsonValue(0)
  transfer,
  /// 1
  @JsonValue(1)
  receive,
}

extension PaymentDateTypeExtension on PaymentDateType {
  static const _mapTypeToName = <PaymentDateType, String>{
    PaymentDateType.transfer: 'Дата перечисления',
    PaymentDateType.receive: 'Дата приема платежа',
  };

  String get name => _mapTypeToName[this]!;
}