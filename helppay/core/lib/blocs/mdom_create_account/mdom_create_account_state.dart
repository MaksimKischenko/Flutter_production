part of 'mdom_create_account_bloc.dart';

abstract class MdomCreateAccountState extends Equatable {
  const MdomCreateAccountState();

  @override
  List<Object?> get props => [];
}

class MdomCreateAccountLoading extends MdomCreateAccountState {}

class MdomCreateAccountError extends MdomCreateAccountState {
  final Object? error;

  const MdomCreateAccountError({this.error});

  @override
  List<Object?> get props => [error];
}

class MdomCreateAccountErrorKomplat extends MdomCreateAccountState {
  final String errorMessage;
  final int errorCode;

  const MdomCreateAccountErrorKomplat(
      {required this.errorMessage, required this.errorCode});

  @override
  List<Object> get props => [errorMessage, errorCode];
}

class MdomCreateAccountSuccess extends MdomCreateAccountState {
  final PropertyAccountAccount account;

  const MdomCreateAccountSuccess({
    required this.account,
  });

  @override
  List<Object?> get props => [account];
}

class MdomCreateAccountCodeWordSent extends MdomCreateAccountState {
  final PropertyAccountAccount account;

  const MdomCreateAccountCodeWordSent({
    required this.account,
  });

  @override
  List<Object?> get props => [account];
}
