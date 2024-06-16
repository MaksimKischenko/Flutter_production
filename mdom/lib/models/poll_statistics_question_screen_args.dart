import 'package:bpc/data/data.dart';

class PollStatisticsQuestionScreenArgs {
  final int pollId;
  final PollListQuestion question;

  const PollStatisticsQuestionScreenArgs({
    required this.pollId,
    required this.question
  });
}