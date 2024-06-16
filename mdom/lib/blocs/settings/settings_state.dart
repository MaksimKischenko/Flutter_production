part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();
  
  @override
  List<Object?> get props => [];
}

class SettingsLoading extends SettingsState {}

class SettingsInitial extends SettingsState {
  final bool isAuthWithBiometricsAvailable;
  final String? biometricDescription;
  final bool authWithBiometricsFlag;
  final bool isChangePinAvailable;
  
  const SettingsInitial({
    required this.isAuthWithBiometricsAvailable,
    required this.biometricDescription,
    required this.authWithBiometricsFlag,
    required this.isChangePinAvailable
  });

  @override
  List<Object?> get props => [
    isAuthWithBiometricsAvailable,
    biometricDescription,
    authWithBiometricsFlag,
    isChangePinAvailable
  ];
}

class SettingsCheckOldPin extends SettingsState {
  final int timestamp;
  final String oldPin;

  SettingsCheckOldPin({
    required this.oldPin
  }) : timestamp = DateTime.now().millisecondsSinceEpoch;

  @override
  List<Object> get props => [oldPin, timestamp];
}

class SettingsPinChangedSuccess extends SettingsState {}