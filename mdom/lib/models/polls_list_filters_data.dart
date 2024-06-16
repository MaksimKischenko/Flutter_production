import 'package:bpc/models/models.dart';
import 'package:equatable/equatable.dart';

class PollsListFiltersData extends Equatable {
  final String? topic;
  final PollStatus status;
  final DateTime stopDateFrom;
  final DateTime stopDateTo;

  const PollsListFiltersData({
    required this.topic,
    required this.status,
    required this.stopDateFrom,
    required this.stopDateTo,
  });

  @override
  List<Object?> get props => [topic, status, stopDateFrom, stopDateTo];

  factory PollsListFiltersData.initial() => PollsListFiltersData(
    topic: null,
    status: PollStatus.inProgress,
    stopDateFrom: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day), 
    stopDateTo: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).add(const Duration(days: 31, hours: 23, minutes: 59, seconds: 59))
  );

  bool equalTo(PollsListFiltersData other) {
    if (topic != other.topic) return false;
    if (status != other.status) return false;

    if (stopDateFrom.year != other.stopDateFrom.year) return false;
    if (stopDateFrom.month != other.stopDateFrom.month) return false;
    if (stopDateFrom.day != other.stopDateFrom.day) return false;
    
    if (stopDateTo.year != other.stopDateTo.year) return false;
    if (stopDateTo.month != other.stopDateTo.month) return false;
    if (stopDateTo.day != other.stopDateTo.day) return false;

    return true;
  }

  PollsListFiltersData copyWith({
    String? topic,
    PollStatus? status,
    DateTime? stopDateFrom,
    DateTime? stopDateTo,
  }) => PollsListFiltersData(
    topic: topic ?? this.topic,
    status: status ?? this.status,
    stopDateFrom: stopDateFrom ?? this.stopDateFrom,
    stopDateTo: stopDateTo ?? this.stopDateTo,
  );
}
