part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();
  
  @override
  List<Object> get props => [];
}

class SettingsLoading extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final SettingsData data;

  const SettingsLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class SettingsSaved extends SettingsState {}
