import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';

enum PaymentStatus {
  /// 0
  @JsonValue(0)
  all,
  /// 1
  @JsonValue(1)
  registered,
  /// 2
  @JsonValue(2)
  paid,
  /// -1
  @JsonValue(-1)
  successfullyReversed,
  /// -2
  @JsonValue(-2)
  reversalStarted,
  /// -3
  @JsonValue(-3)
  registrationStarted,
  /// -4
  @JsonValue(-4)
  registrationCanceled,
  /// -9
  @JsonValue(-9)
  refundStarted,
  /// -10
  @JsonValue(-10)
  refundCompleted,
  /// -11
  @JsonValue(-11)
  refundCancelWaiting,
}

extension PaymentStatusExtension on PaymentStatus {
  static const _mapTypeToFilterName = <PaymentStatus, String>{
    PaymentStatus.all: 'Все',
    PaymentStatus.registered: 'Зарегистрированные',
    PaymentStatus.paid: 'Оплаченные (есть номер ПП)',
    PaymentStatus.successfullyReversed: 'Успешно сторнированные',
    PaymentStatus.reversalStarted: 'Начато сторнирование',
    PaymentStatus.registrationStarted: 'Начата регистрация',
    PaymentStatus.registrationCanceled: 'С отмененной регистрацией',
    PaymentStatus.refundStarted: 'Возврат начат',
    PaymentStatus.refundCompleted: 'Возврат выполнен',
    PaymentStatus.refundCancelWaiting: 'Ожидание отмены возврата',
  };

  String get filterName => _mapTypeToFilterName[this]!;

  static const _mapTypeToName = <PaymentStatus, String>{
    PaymentStatus.registered: 'Зарегистрировано, ожидается оплата',
    PaymentStatus.paid: 'Оплачено',
    PaymentStatus.successfullyReversed: 'Успешно сторнировано',
    PaymentStatus.reversalStarted: 'Начато сторнирование',
    PaymentStatus.registrationStarted: 'Начата регистрация платежа',
    PaymentStatus.registrationCanceled: 'Отмена регистрации',
    PaymentStatus.refundStarted: 'Возврат начат',
    PaymentStatus.refundCompleted: 'Возврат выполнен',
    PaymentStatus.refundCancelWaiting: 'Ожидание отмены возврата',
  };

  String get name => _mapTypeToName[this] ?? 'Неизвестно';

  static const _mapTypeToColor = <PaymentStatus, Color>{
    PaymentStatus.registered: Color(0xffDDE1E9),
    PaymentStatus.paid: Color(0xff56C58A),
    PaymentStatus.successfullyReversed: Color(0xffEC5B5B),
    PaymentStatus.reversalStarted: Color(0xffF8D147),
    PaymentStatus.registrationStarted: Color(0xff4FD8F1),
    PaymentStatus.registrationCanceled: Color(0xff000000),
    PaymentStatus.refundStarted: Color(0xff845BC4),
    PaymentStatus.refundCompleted: Color(0xff3F00A0),
    PaymentStatus.refundCancelWaiting: Color(0xff661283),
  };

  Color get color => _mapTypeToColor[this] ?? const Color(0xffDDE1E9);
}