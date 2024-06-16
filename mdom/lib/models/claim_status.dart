import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';

enum ClaimStatus {
  /// 0
  @JsonValue(0)
  all,
  /// 1
  @JsonValue(1)
  unpaid,
  /// 2
  @JsonValue(2)
  fullyPaid,
  /// 3
  @JsonValue(3)
  partiallyPaid,
  /// 4
  @JsonValue(4)
  overdue,
}

extension ClaimStatusExtension on ClaimStatus {
  static const _mapTypeToFilterName = <ClaimStatus, String>{
    ClaimStatus.all: 'Все',
    ClaimStatus.unpaid: 'Неоплаченные',
    ClaimStatus.fullyPaid: 'Полностью оплаченные',
    ClaimStatus.partiallyPaid: 'Частично оплаченные',
    ClaimStatus.overdue: 'Просроченные',
  };

  String get filterName => _mapTypeToFilterName[this]!;

  static const _mapTypeToName = <ClaimStatus, String>{
    ClaimStatus.unpaid: 'Подготовлено',
    ClaimStatus.fullyPaid: 'Полностью оплачено',
    ClaimStatus.partiallyPaid: 'Частично оплачено',
    ClaimStatus.overdue: 'Просрочено',
  };

  String get name => _mapTypeToName[this] ?? 'Неизвестно';

  static const _mapTypeToColor = <ClaimStatus, Color>{
    ClaimStatus.unpaid: Color(0xffDDE1E9),
    ClaimStatus.fullyPaid: Color(0xff56C58A),
    ClaimStatus.partiallyPaid: Color(0xffF8D147),
    ClaimStatus.overdue: Color(0xffEC5B5B),
  };

  Color get color => _mapTypeToColor[this] ?? const Color(0xffDDE1E9);
}