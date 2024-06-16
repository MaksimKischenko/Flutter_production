part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {
  final String email;
  final String username;
  final List<MdomResponseParam> userParams;
  final MdomLookup? lookups;
  final bool isAvailableBiometricAuth;
  final KomplatBiometricType? komplatBiometricType;
  final bool authWithBiometricsFlag;

  const ProfileInitial({
    this.lookups,
    required this.email,
    required this.username,
    required this.userParams,
    required this.isAvailableBiometricAuth,
    required this.komplatBiometricType,
    required this.authWithBiometricsFlag,
  });

  @override
  List<Object?> get props => [email, username];
}

class ProfileLoading extends ProfileState {}

class ProfileError extends ProfileState {
  final Object error;

  const ProfileError({required this.error});

  @override
  List<Object> get props => [error];
}

class ProfileErrorKomplat extends ProfileState {
  final String? errorMessage;
  final int errorCode;

  const ProfileErrorKomplat({
    required this.errorMessage,
    required this.errorCode,
  });

  @override
  List<Object?> get props => [errorMessage, errorCode];
}

class ProfileSuccessEdit extends ProfileState {}
