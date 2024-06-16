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

  const RegistrationError({
    required this.error
  });

  @override
  List<Object> get props => [error];
}

class RegistrationErrorKomplat extends RegistrationState {
  final String? errorMessage;
  final int errorCode;

  const RegistrationErrorKomplat({
    required this.errorMessage,
    required this.errorCode
  });

  @override
  List<Object?> get props => [errorMessage, errorCode];
}

class RegistrationSuccess extends RegistrationState {
  final List<MdomResponseParam>? params;
  final ConfirmCodeType codeType;

  const RegistrationSuccess({
    required this.params,
    required this.codeType
  });

  @override
  List<Object?> get props => [params];
}

class RegistrationSuccessEdit extends RegistrationState {
  final ConfirmCodeType codeType;

  const RegistrationSuccessEdit({
    required this.codeType
  });

  @override
  List<Object> get props => [codeType];
}

class RegistrationCodeSendSuccess extends RegistrationState {}

class RegistrationAskForBiometrics extends RegistrationState {
  final String biometricDescription;

  const RegistrationAskForBiometrics({
    required this.biometricDescription
  });

  @override
  List<Object> get props => [biometricDescription];
}

class RegistrationPinSetSuccess extends RegistrationState {}