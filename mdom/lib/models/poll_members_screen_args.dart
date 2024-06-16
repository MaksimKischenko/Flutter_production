import 'package:bpc/data/data.dart';

class PollMembersScreenArgs {
  final int participantsCount;
  final int confirmedCount;
  final Poll poll;


  const PollMembersScreenArgs({
    required this.participantsCount,
    required this.confirmedCount,
    required this.poll,
  });
}