
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

enum PaymentStatus {

  @JsonValue(0)
  all('Все платежи', Colors.black),

  @JsonValue(1)
  registered('Зарегистрированные', Color(0xffDDE1E9)),

  @JsonValue(2)
  paid('Оплаченные (есть номер ПП)', Color(0xff56C58A)),

  @JsonValue(-1)
  successfullyReversed('Успешносторнированные', Color(0xffEC5B5B)),

  @JsonValue(-2)
  reversalStarted('Начато сторнирование', Color(0xffF8D147)),

  @JsonValue(-3)
  registrationStarted('Начата регистрация', Color(0xff4FD8F1)),

  @JsonValue(-4)
  registrationCanceled('С отмененной регистрацией', Color(0xff000000));

  const PaymentStatus(this.paymentStatusName, this.paymentStatusColor);

  final String paymentStatusName;
  final Color paymentStatusColor;
}
