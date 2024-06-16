// ignore_for_file: avoid_void_async

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bpc/data/data.dart';
import 'package:bpc/models/models.dart';
import 'package:equatable/equatable.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final DataManager dataManager;
  
  SettingsBloc({
    required this.dataManager,
  }) : super(SettingsLoading()) {
    on<SettingsEvent>(_onEvent);
  }
  
  bool get isAuthWithBiometricsAvailable => dataManager.isCredentialsSaveChecked
      && dataManager.isAvailableBiometricAuth;
  final biometricDescriptionMap = <KomplatBiometricType, String>{
    KomplatBiometricType.faceid: 'Face ID',
    KomplatBiometricType.touchid: 'Touch ID',
    KomplatBiometricType.biometric: 'биометрии',
  };
  String? get biometricDescription => biometricDescriptionMap[dataManager.komplatBiometricType];
  bool get isChangePinAvailable => dataManager.isCredentialsSaveChecked;
  Future<bool> get authWithBiometricsFlag async => (await PreferencesHelper.read(PrefsKeys.authWithBiometric))!;

  void _onEvent(
    SettingsEvent event,
    Emitter<SettingsState> emit,
  ) {
    if (event is SettingsInit) return _onSettingsInit(event, emit);
    if (event is SettingsChangeAuthWithBiometrics) return _onSettingsChangeAuthWithBiometrics(event, emit);
    if (event is SettingsStartChangePin) return _onSettingsStartChangePin(event, emit);
    if (event is SettingsChangePin) return _onSettingsChangePin(event, emit);
  }

  void _onSettingsInit(
    SettingsInit event,
    Emitter<SettingsState> emit,
  ) async {
    emit(SettingsLoading());

    emit(SettingsInitial(
      isAuthWithBiometricsAvailable: isAuthWithBiometricsAvailable,
      biometricDescription: biometricDescription,
      authWithBiometricsFlag: await authWithBiometricsFlag,
      isChangePinAvailable: isChangePinAvailable
    ));
  }

  void _onSettingsChangeAuthWithBiometrics(
    SettingsChangeAuthWithBiometrics event,
    Emitter<SettingsState> emit,
  ) async {
    await PreferencesHelper.write(PrefsKeys.authWithBiometric, event.value);
    dataManager.authWithBiometricsFlag = event.value;

    emit(SettingsInitial(
      isAuthWithBiometricsAvailable: isAuthWithBiometricsAvailable,
      biometricDescription: biometricDescription,
      authWithBiometricsFlag: await authWithBiometricsFlag,
      isChangePinAvailable: isChangePinAvailable
    ));
  }

  void _onSettingsStartChangePin(
    SettingsStartChangePin event,
    Emitter<SettingsState> emit,
  ) async {
    final correctPin = await SecureStorageManager.read(SecureStorageKeys.pincode);

    emit(SettingsCheckOldPin(
      oldPin: correctPin!
    ));
  }

  void _onSettingsChangePin(
    SettingsChangePin event,
    Emitter<SettingsState> emit,
  ) async {
    await SecureStorageManager.write(SecureStorageKeys.pincode, event.newPin);

    emit(SettingsPinChangedSuccess());
  }
}