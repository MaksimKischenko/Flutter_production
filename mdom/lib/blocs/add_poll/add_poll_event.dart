part of 'add_poll_bloc.dart';

abstract class AddPollEvent extends Equatable {
  const AddPollEvent();

  @override
  List<Object?> get props => [];
}

class AddPollProceed extends AddPollEvent {
  final String topic;
  final DateTime startDate;
  final DateTime endDate;
  final String? url;
  final bool anonymous;
  final List<String> questions;
  final bool publish;

  const AddPollProceed({
    required this.topic,
    required this.startDate,
    required this.endDate,
    required this.url,
    required this.anonymous,
    required this.questions,
    required this.publish,
  });

  @override
  List<Object?> get props => [
    topic,
    startDate,
    endDate,
    url,
    anonymous,
    questions,
    publish,
  ];
}
