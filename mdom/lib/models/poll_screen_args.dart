import 'package:bpc/data/data.dart';

class PollScreenArgs {
  final int participantsCount;
  final int confirmedCount;
  final Poll poll;

  const PollScreenArgs({
    required this.participantsCount,
    required this.confirmedCount,
    required this.poll,
  });
}
