import 'package:bpc/data/data.dart';

class PollStatisticsScreenArgs {
  final int participantsCount;
  final int confirmedCount;
  final Poll poll;

  const PollStatisticsScreenArgs({
    required this.participantsCount,
    required this.confirmedCount,
    required this.poll,
  });
}