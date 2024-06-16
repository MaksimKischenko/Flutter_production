import 'package:flutter/material.dart';
import 'package:helppay_core/generated/translations.g.dart';
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
  /// name when poll is active
  String get nameActive {
    if (this == PollAnswer.yes) {
      return t.models.pollAnswer.active.yes;
    } else if (this == PollAnswer.no) {
      return t.models.pollAnswer.active.no;
    } else if (this == PollAnswer.abstain) {
      return t.models.pollAnswer.active.abstain;
    } else {
      return 'Unknown';
    }
  }

  /// name when poll is voted by user
  String get nameVoted {
    if (this == PollAnswer.yes) {
      return t.models.pollAnswer.voted.yes;
    } else if (this == PollAnswer.no) {
      return t.models.pollAnswer.voted.no;
    } else if (this == PollAnswer.abstain) {
      return t.models.pollAnswer.voted.abstain;
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