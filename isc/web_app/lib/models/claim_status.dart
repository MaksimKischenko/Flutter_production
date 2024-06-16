
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

// enum ClaimStatus {


//   @JsonValue(0)
//   all('Все', Colors.transparent),

//   @JsonValue(1)
//   unpaid('Подготовлено', Color(0xffDDE1E9)),

//   @JsonValue(2)
//   fullyPaid('Полностью оплаченно', Color(0xff56C58A)),

//   @JsonValue(3)
//   partiallyPaid('Частично оплаченно', Color(0xffF8D147)),

//   @JsonValue(4)
//   overdue('Просрочено', Color(0xffEC5B5B));

//   const ClaimStatus(this.claimStatusName, this.claimStatusColor);

//   final String claimStatusName;
//   final Color claimStatusColor;
// }

enum ClaimStatus {


  @JsonValue(0)
  all('Все', Color(0xffDDE1E9)),

  @JsonValue(1)
  unpaid('Подготовлено',  Color(0xffF8D147)),

  @JsonValue(2)
  fullyPaid('Полностью оплаченно', Color(0xfff7f9fc)),

  @JsonValue(3)
  partiallyPaid('Частично оплаченно',Color(0xff56C58A)),

  @JsonValue(4)
  overdue('Просрочено', Color(0xffEC5B5B));

  const ClaimStatus(this.claimStatusName, this.claimStatusColor);

  final String claimStatusName;
  final Color claimStatusColor;
}
