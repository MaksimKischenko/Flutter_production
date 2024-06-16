part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class SettingsInit extends SettingsEvent {}

class SettingsSave extends SettingsEvent {
  final SettingsData data;

  const SettingsSave(this.data);

  @override
  List<Object> get props => [data];
}