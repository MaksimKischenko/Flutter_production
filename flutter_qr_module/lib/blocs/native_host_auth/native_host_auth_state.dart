part of 'native_host_auth_bloc.dart';

sealed class NativeHostAuthState extends Equatable {
  const NativeHostAuthState();
  
  @override
  List<Object?> get props => [];
}

final class NativeHostAuthInitial extends NativeHostAuthState {}

final class NativeHostAuthLoading extends NativeHostAuthState {}

final class NativeHostAuthSuccess extends NativeHostAuthState {
  final NativeHostAuthData? data;

  const NativeHostAuthSuccess({required this.data});

  @override
  List<Object?> get props => [data];

  @override
  String toString() =>
      'DATA - { terminalId: ${data?.terminalId}, typePan: ${data?.typePan}, pan: ${data?.pan}, expiry: ${data?.expiry} }';
}

class NativeHostAuthError extends NativeHostAuthState {
  final Object error;

  const NativeHostAuthError({required this.error});

  @override
  List<Object> get props => [error];
}
