part of 'native_host_auth_bloc.dart';

sealed class NativeHostAuthEvent extends Equatable {
  const NativeHostAuthEvent();

  @override
  List<Object> get props => [];
}

class NativeHostAuthRun extends NativeHostAuthEvent {}