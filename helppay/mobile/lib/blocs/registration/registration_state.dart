part of 'registration_bloc.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState();

  @override
  List<Object?> get props => [];
}

class RegistrationInitial extends RegistrationState {}

class RegistrationLoading extends RegistrationState {}

class RegistrationError extends RegistrationState {
  final Object error;

  const RegistrationError({required this.error});

  @override
  List<Object> get props => [error];
}

class RegistrationErrorKomplat extends RegistrationState {
  final String? errorMessage;
  final int errorCode;

  const RegistrationErrorKomplat(
      {required this.errorMessage, required this.errorCode});

  @override
  List<Object?> get props => [errorMessage, errorCode];
}

class RegistrationSuccess extends RegistrationState {
  final List<MdomResponseParam>? params;
  final ConfirmCodeType codeType;
  final List<MdomLookupItem>? lookups;
  final String? phoneNumber;

  const RegistrationSuccess({
    required this.params,
    required this.codeType,
    this.lookups,
    this.phoneNumber,
  });

  @override
  List<Object?> get props => [params, lookups, phoneNumber];
}

class RegistrationSuccessEdit extends RegistrationState {
  final ConfirmCodeType codeType;

  const RegistrationSuccessEdit({required this.codeType});

  @override
  List<Object> get props => [codeType];
}

class RegistrationCodeSendSuccess extends RegistrationState {}

class RegistrationPinSetSuccess extends RegistrationState {
  final bool askForBimetrics;
  final KomplatBiometricType? komplatBiometricType;

  const RegistrationPinSetSuccess(
      {required this.askForBimetrics, required this.komplatBiometricType});

  @override
  List<Object?> get props => [askForBimetrics, komplatBiometricType];
}
