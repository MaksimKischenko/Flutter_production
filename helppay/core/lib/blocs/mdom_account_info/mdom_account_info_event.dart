part of 'mdom_account_info_bloc.dart';

abstract class MdomAccountInfoEvent extends Equatable {
  const MdomAccountInfoEvent();

  @override
  List<Object> get props => [];
}

class MdomAccountInit extends MdomAccountInfoEvent {
  final DateTime from;
  final DateTime to;

  const MdomAccountInit({
    required this.from,
    required this.to,
  });
  

  @override
  List<Object> get props => [from, to];
}