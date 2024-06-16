import 'package:helppay_core/generated/translations.g.dart';
import 'package:json_annotation/json_annotation.dart';

enum PollStatus {
  @JsonValue(0)
  all,
  @JsonValue(-3)
  publication,
  @JsonValue(1)
  inProgress,
  @JsonValue(2)
  completed
}

extension PollStatusExtension on PollStatus {

  String get name {
    if (this == PollStatus.all) {
      return t.models.pollStatus.all;
    } else if (this == PollStatus.publication) {
      return t.models.pollStatus.publication;
    } else if (this == PollStatus.inProgress) {
      return t.models.pollStatus.inProgress;
    } else if (this == PollStatus.completed) {
      return t.models.pollStatus.completed;
    } else {
      return 'Unknown';
    }
  }
}