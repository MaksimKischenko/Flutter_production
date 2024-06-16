part of 'mdom_accruals_bloc.dart';

abstract class MdomAccrualsEvent extends Equatable {
  const MdomAccrualsEvent();

  @override
  List<Object> get props => [];
}

class MdomAccrualsInit extends MdomAccrualsEvent {}

class MdomAccrualsCheckLoaded extends MdomAccrualsEvent {}

class MdomAccrualsNewAccount extends MdomAccrualsEvent {
  final PropertyAccountAccount account;

  const MdomAccrualsNewAccount(this.account);

  @override
  List<Object> get props => [account];
}
