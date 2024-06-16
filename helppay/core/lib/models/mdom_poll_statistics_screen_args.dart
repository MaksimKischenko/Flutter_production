import 'package:helppay_core/data/data.dart';

class MdomPollStatisticsScreenArgs {
  final int participantsCount;
  final Poll poll;

  const MdomPollStatisticsScreenArgs({
    required this.participantsCount,
    required this.poll,
  });
}