part of 'mdom_delete_bloc.dart';

@immutable
abstract class MdomDeleteUserState {
  const MdomDeleteUserState();

  List<Object?> get props => [];
}

class MdomDeleteUserInitial extends MdomDeleteUserState {}

class MdomDeleteUserError extends MdomDeleteUserState {
  final Object error;

  const MdomDeleteUserError({required this.error});

  @override
  List<Object> get props => [error];
}

class MdomDeleteUserErrorKomplat extends MdomDeleteUserState {
  final String? errorMessage;
  final int errorCode;

  const MdomDeleteUserErrorKomplat(
      {required this.errorMessage, required this.errorCode});

  @override
  List<Object?> get props => [errorMessage, errorCode];
}

class MdomDeleteUserSuccess extends MdomDeleteUserState {}
