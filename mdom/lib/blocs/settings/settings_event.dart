part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class SettingsInit extends SettingsEvent {}

class SettingsChangeAuthWithBiometrics extends SettingsEvent {
  final bool value;

  // ignore: avoid_positional_boolean_parameters
  const SettingsChangeAuthWithBiometrics(this.value);

  @override
  List<Object> get props => [value];
}

class SettingsStartChangePin extends SettingsEvent {}

class SettingsChangePin extends SettingsEvent {
  final String newPin;

  const SettingsChangePin(this.newPin);

  @override
  List<Object> get props => [newPin];
}