import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

enum PollAnswer {
  @JsonValue('Yes')
  yes,
  @JsonValue('No')
  no,
  @JsonValue('Abstain')
  abstain
}

extension PollAnswerExtension on PollAnswer {
  /// name when poll is voted by user
  String get nameVoted {
    if (this == PollAnswer.yes) {
      return 'Да';
      // TODO
      // return t.models.pollAnswer.voted.yes;
    } else if (this == PollAnswer.no) {
      return 'Нет';
      // TODO
      // return t.models.pollAnswer.voted.no;
    } else if (this == PollAnswer.abstain) {
      return 'Воздерж.';
      // TODO
      // return t.models.pollAnswer.voted.abstain;
    } else {
      return 'Unknown';
    }
  }

  static const _mapAnswerToColor = <PollAnswer, Color>{
    PollAnswer.yes: Color(0xff15C36F),
    PollAnswer.no: Color(0xffFF5C00),
    PollAnswer.abstain: Color(0xff787878),
  };

  Color get color => _mapAnswerToColor[this]!;
}