import 'package:json_annotation/json_annotation.dart';

enum PollStatus {
  @JsonValue(0)
  all,
  @JsonValue(-1)
  draft,
  @JsonValue(-2)
  canceled,
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
      // return t.models.pollStatus.all;
      return 'Все';
    } else if (this == PollStatus.draft) {
      return 'Черновик';
    } else if (this == PollStatus.canceled) {
      return 'Отменено';
    } else if (this == PollStatus.publication) {
      // return t.models.pollStatus.publication;
      return 'Публикация';
    } else if (this == PollStatus.inProgress) {
      // return t.models.pollStatus.inProgress;
      return 'Идет голосование';
    } else if (this == PollStatus.completed) {
      // return t.models.pollStatus.completed;
      return 'Завершено';
    } else {
      return 'Unknown';
    }
  }
}