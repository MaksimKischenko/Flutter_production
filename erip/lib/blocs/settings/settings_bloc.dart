import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bpc_nkfo/data/data.dart';
import 'package:bpc_nkfo/injection_component.dart';
import 'package:bpc_nkfo/models/models.dart';
import 'package:equatable/equatable.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final DataManager _dataManager;
  
  SettingsBloc() : _dataManager = InjectionComponent.getDependency<DataManager>(), super(SettingsLoading());

  @override
  Stream<SettingsState> mapEventToState(
    SettingsEvent event,
  ) async* {
    if (event is SettingsInit) {
      yield* _mapSettingsInitToState(event);
    }
    if (event is SettingsChangeAuthWithBiometrics) {
      yield* _mapSettingsChangeAuthWithBiometrics(event);
    }
    if (event is SettingsStartChangePin) {
      yield* _mapSettingsStartChangePinToState(event);
    }
    if (event is SettingsChangePin) {
      yield* _mapSettingsChangePinToState(event);
    }
  }

  Stream<SettingsState> _mapSettingsInitToState(
    SettingsInit event
  ) async* {
    yield SettingsLoading();

    final isAuthWithBiometricsAvailable = _dataManager.isCredentialsSaveChecked
        && _dataManager.isAvailableBiometricAuth;
    final authWithBiometricsFlag = await PreferencesHelper.getAuthWithBiometrics();
    final isChangePinAvailable = _dataManager.isCredentialsSaveChecked;

    const biometricDescriptionMap = <KomplatBiometricType, String>{
      KomplatBiometricType.faceid: 'Face ID',
      KomplatBiometricType.touchid: 'Touch ID',
      KomplatBiometricType.biometric: 'биометрии',
    };

    final biometricDescription = biometricDescriptionMap[_dataManager.komplatBiometricType];

    yield SettingsInitial(
      isAuthWithBiometricsAvailable: isAuthWithBiometricsAvailable,
      biometricDescription: biometricDescription,
      authWithBiometricsFlag: authWithBiometricsFlag,
      isChangePinAvailable: isChangePinAvailable
    );
  }

  Stream<SettingsState> _mapSettingsChangeAuthWithBiometrics(
    SettingsChangeAuthWithBiometrics event
  ) async* {
    await PreferencesHelper.setAuthWithBiometrics(event.value);
    _dataManager.authWithBiometricsFlag = event.value;

    final isAuthWithBiometricsAvailable = _dataManager.isCredentialsSaveChecked
        && _dataManager.isAvailableBiometricAuth;
    final authWithBiometricsFlag = await PreferencesHelper.getAuthWithBiometrics();
    final isChangePinAvailable = _dataManager.isCredentialsSaveChecked;

    const biometricDescriptionMap = <KomplatBiometricType, String>{
      KomplatBiometricType.faceid: 'Face ID',
      KomplatBiometricType.touchid: 'Touch ID',
      KomplatBiometricType.biometric: 'биометрии',
    };

    final biometricDescription = biometricDescriptionMap[_dataManager.komplatBiometricType];

    yield SettingsInitial(
      isAuthWithBiometricsAvailable: isAuthWithBiometricsAvailable,
      biometricDescription: biometricDescription,
      authWithBiometricsFlag: authWithBiometricsFlag,
      isChangePinAvailable: isChangePinAvailable
    );
  }

  Stream<SettingsState> _mapSettingsStartChangePinToState(
    SettingsStartChangePin event
  ) async* {
    final correctPin = await SecureStorageManager.getPinCode();

    yield SettingsCheckOldPin(
      oldPin: correctPin!
    );
  }

  Stream<SettingsState> _mapSettingsChangePinToState(
    SettingsChangePin event
  ) async* {
    await SecureStorageManager.writePinCode(event.newPin);

    yield SettingsPinChangedSuccess();
  }
}
