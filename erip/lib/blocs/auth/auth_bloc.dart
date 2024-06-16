import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bpc_nkfo/data/data.dart';
import 'package:bpc_nkfo/injection_component.dart';
import 'package:bpc_nkfo/models/models.dart';
import 'package:bpc_nkfo/navigation.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final DataManager _dataManager;

  AuthBloc() : _dataManager = InjectionComponent.getDependency<DataManager>(), super(AuthInitial());

  late String _login;
  late String _password;

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AuthRun) {
      yield* _mapAuthRunToState(event);
    }
    if (event is AuthSetPin) {
      yield* _mapAuthSetPinToState(event);
    }
    if (event is AuthBiometricResponse) {
      yield* _mapAuthBiometricResponseToState(event);
    }
    if (event is AuthLogOut) {
      yield* _mapAuthLogOutToState(event);
    }
  }

  Stream<AuthState> _mapAuthRunToState(
    AuthRun event
  ) async* {
    yield AuthLoading();

    try {
      final response = await _dataManager.tokenRequest(event.login, event.password);
      if (response.errorCode == 0) {       
        if (event.isAuthSaveChecked) {
          _login = event.login;
          _password = event.password;

          yield AuthPinSetup();
          _dataManager.isCredentialsSaveChecked = event.isAuthSaveChecked;
        } else {
          await _dataManager.loadServicesList();
          await _dataManager.informationRequest();
          _dataManager.safeViewVisible = false;
          yield AuthSuccessLogin();
          _dataManager.isCredentialsSaveChecked = event.isFromSplash;
        }
      } else {
        yield AuthErrorKomplat(
          errorCode: response.errorCode,
          errorMessage: response.errorText
        );
      }
    // ignore: avoid_catches_without_on_clauses
    } catch (error, _) {
      yield AuthError(
        error: error
      );
    }
  }

  Stream<AuthState> _mapAuthSetPinToState(
    AuthSetPin event
  ) async* {
    yield AuthLoading();

    await SecureStorageManager.writePinCode(event.pin);
    await SecureStorageManager.writeCredentials(_login, _password);

    await _dataManager.loadServicesList();
    await _dataManager.informationRequest();
    _dataManager.safeViewVisible = false;

    const bioTypeMap = <KomplatBiometricType, String>{
      KomplatBiometricType.faceid: 'Face ID',
      KomplatBiometricType.touchid: 'Touch ID',
      KomplatBiometricType.biometric: 'биометрию'
    };

    yield AuthAskForBiometrics(
      biometricDescription: bioTypeMap[_dataManager.komplatBiometricType]!
    );
  }

  Stream<AuthState> _mapAuthBiometricResponseToState(
    AuthBiometricResponse event
  ) async* {
    yield AuthLoading();

    if (event.response) {
      await PreferencesHelper.setAuthWithBiometrics(true);
      _dataManager.authWithBiometricsFlag = true;
    }
    yield AuthSuccessLogin();
  }

  Stream<AuthState> _mapAuthLogOutToState(
    AuthLogOut event
  ) async* {
    yield AuthLoading();

    await SecureStorageManager.deleteCredentials();
    await PreferencesHelper.setAuthWithBiometrics(false);
    _dataManager
      ..authWithBiometricsFlag = false
      ..servicesList = []
      ..informationResponse = null;
    await SecureStorageManager.deletePinCode();
    _dataManager.safeViewVisible = true;
    Navigation.toAuth();

    yield AuthInitial();
  }
}
