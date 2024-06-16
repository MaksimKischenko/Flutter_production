part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileInit extends ProfileEvent {}

class ProfileParamsChanged extends ProfileEvent {
  final List<MdomRequestParam> params;

  const ProfileParamsChanged({
    required this.params
  });

  @override
  List<Object> get props => [params];

  @override
  String toString() => 'ProfileParamsChanged { params: $params }';
}

class ProfileChangeAuthWithBiometrics extends ProfileEvent {
  final bool value;

  const ProfileChangeAuthWithBiometrics({
    required this.value
  });

  @override
  List<Object> get props => [value];

  @override
  String toString() => 'ProfileChangeAuthWithBiometrics { value: $value }';
}
