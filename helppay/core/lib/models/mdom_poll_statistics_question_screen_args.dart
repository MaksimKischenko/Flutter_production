import 'package:helppay_core/data/data.dart';

class MdomPollStatisticsQuestionScreenArgs {
  final int pollId;
  final PollListQuestion question;

  const MdomPollStatisticsQuestionScreenArgs({
    required this.pollId,
    required this.question
  });
}