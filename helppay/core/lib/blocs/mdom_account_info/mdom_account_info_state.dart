part of 'mdom_account_info_bloc.dart';

abstract class MdomAccountInfoState extends Equatable {
  const MdomAccountInfoState();
  
  @override
  List<Object?> get props => [];
}

class MdomAccountInfoPeriodNotSet extends MdomAccountInfoState {}

class MdomAccountInfoLoading extends MdomAccountInfoState {}

class MdomAccountInfoLoaded extends MdomAccountInfoState {
  final AccountStatementPeriod? periodInfo;
  final List<MdomService>? unRecolculatedServices;

  const MdomAccountInfoLoaded({
    this.periodInfo,
    this.unRecolculatedServices,
  });


  @override
  List<Object?> get props => [periodInfo];
}

class MdomAccountInfoError extends MdomAccountInfoState {
  final Object? error;

  const MdomAccountInfoError({this.error});

  @override
  List<Object?> get props => [error];
}

class MdomAccountInfoErrorKomplat extends MdomAccountInfoState {
  final String errorMessage;
  final int errorCode;

  const MdomAccountInfoErrorKomplat({
    required this.errorMessage,
    required this.errorCode
  });

  @override
  List<Object> get props => [errorMessage, errorCode];
}