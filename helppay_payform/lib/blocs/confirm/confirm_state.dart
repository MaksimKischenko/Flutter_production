part of 'confirm_bloc.dart';

abstract class ConfirmState extends Equatable {
  const ConfirmState();

  @override
  List<Object?> get props => [];
}

class ConfirmInitial extends ConfirmState {}

class ConfirmLoading extends ConfirmState {}

class ConfirmError extends ConfirmState {
  final Object error;

  const ConfirmError({required this.error});

  @override
  List<Object?> get props => [error];
}

class ConfirmErrorKomplat extends ConfirmState {
  final RequestType request;
  final int? errorCode;
  final String? errorText;
  final bool redirectAvailable;

  const ConfirmErrorKomplat({
    required this.request,
    required this.errorCode,
    required this.errorText,
    this.redirectAvailable = false,
  });

  @override
  List<Object?> get props => [
        request,
        errorCode,
        errorText,
        redirectAvailable,
      ];
}

class ConfirmSuccess extends ConfirmState {
  final String? returnUrl;

  const ConfirmSuccess({required this.returnUrl});

  @override
  List<Object?> get props => [returnUrl];
}
