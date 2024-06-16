part of 'mdom_accruals_bloc.dart';

abstract class MdomAccrualsState extends Equatable {
  const MdomAccrualsState();
  
  @override
  List<Object?> get props => [];
}

class MdomAccrualsLoading extends MdomAccrualsState {}

class MdomAccrualsLoaded extends MdomAccrualsState {
  final List<CompaniesResponseCompany> companies;

  const MdomAccrualsLoaded({
    required this.companies,
  });

  @override
  List<Object> get props => [companies];
}

class MdomAccrualsError extends MdomAccrualsState {
  final Object? error;

  const MdomAccrualsError({this.error});

  @override
  List<Object?> get props => [error];
}

class MdomAccrualsErrorKomplat extends MdomAccrualsState {
  final String errorMessage;
  final int errorCode;

  const MdomAccrualsErrorKomplat({
    required this.errorMessage,
    required this.errorCode
  });

  @override
  List<Object> get props => [errorMessage, errorCode];
}

class MdomAccrualsToggleRefresh extends MdomAccrualsState {}