// ignore_for_file: avoid_void_async

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_core/data/data.dart';
import 'package:helppay_core/models/models.dart';
import 'package:helppay_core/utils/utils.dart';

part 'auth_event.dart';
part 'auth_state.dart';

void _log(dynamic message) => Logger.helpPayLog(message, name: 'auth_bloc');

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final DataManager dataManager;

  String? email;
  String? password;
  String? secretKey;

  AuthBloc({required this.dataManager}) : super(AuthInitial()) {
    on<AuthEvent>(_onEvent);
  }

  void _onEvent(AuthEvent event, Emitter<AuthState> emit) {
    if (event is AuthRun) return _onAuthRun(event, emit);
    if (event is AuthSetPin) return _onAuthSetPin(event, emit);
    if (event is AuthLogOut) return _onAuthLogOut(event, emit);
    if (event is AuthRefreshToken) return _onAuthRefreshToken(event, emit);
  }

  void _onAuthRun(AuthRun event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final response = await dataManager.loginRequest(
        login: event.data.login,
        password: event.data.password,
      );

      if (response.errorCode.evalue == 0) {
        // _log('auth response lookups data- ${response.lookups?.lookups[0]}');
        // _log(
        //     'auth response lookups data value- ${response.lookups?.lookups[0].items?[1].evalue}');

        dataManager.email = event.data.login;
        email = event.data.login;
        password = event.data.password;
        secretKey = response.helppayKey;
        // await SecureStorageManager.write(SecureStorageKeys.secretKeyPart,
        //     '707BDCE37B9A7A7B358FFC92E2B002BF37147AFB10D14F049A02F8C7F8A0F78C');
        // final secretKey =
        //     await SecureStorageManager.read(SecureStorageKeys.secretKeyPart);
        // _log('secretKey $secretKey');
        dataManager
          ..terminalId = response.token?.terminalId ?? ''
          ..token = response.token?.evalue ?? ''
          ..versionReg = response.token?.version ?? ''
          ..userParams = response.params?.params
          ..lookups = response.lookups?.lookups[0]
          ..userProducts = response.products;

        emit(AuthSuccess());
      } else {
        emit(AuthErrorKomplat(
            errorCode: response.errorCode.evalue,
            errorMessage: response.errorCode.errorText));
      }
    } catch (error) {
      emit(AuthError(error: error));
    }
    // yield AuthInitial();
  }

  void _onAuthRefreshToken(
      AuthRefreshToken event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      _log('old token - ${dataManager.token}');

      final response = await dataManager.refreshTokenRequest(dataManager.token);
      if (response.errorCode?.evalue == 0) {
        // dataManager.email = event.data.email;
        // _email = event.data.email;
        // _password = event.data.password;

        dataManager.token = response.token.evalue!;
        _log('new token - ${dataManager.token}');

        emit(AuthSuccess());
      } else {
        emit(
          AuthErrorKomplat(
            errorCode: response.errorCode!.evalue,
            errorMessage: response.errorText,
          ),
        );
      }
    } catch (error) {
      emit(AuthError(error: error));
    }
    // yield AuthInitial();
  }

  void _onAuthSetPin(AuthSetPin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    await SecureStorageManager.write(SecureStorageKeys.pincode, event.pin);
    await SecureStorageManager.write(SecureStorageKeys.login, email);
    await SecureStorageManager.write(SecureStorageKeys.password, password);
    await SecureStorageManager.write(SecureStorageKeys.secretKeyPart,
        '707BDCE37B9A7A7B358FFC92E2B002BF37147AFB10D14F049A02F8C7F8A0F78C');
    final secretKey =
        await SecureStorageManager.read(SecureStorageKeys.secretKeyPart);
    _log('secretKey $secretKey');
    // await SecureStorageManager.write(
    //     SecureStorageKeys.secretKeyPart, _secretKey); //TODO uncomment this for secret key request
    dataManager.email = email;
    email = null;
    password = null;
    dataManager.safeViewVisible = false;

    emit(AuthPinSetSuccess(
        askForBimetrics: dataManager.isAvailableBiometricAuth,
        komplatBiometricType: dataManager.komplatBiometricType));
  }

  void _onAuthLogOut(AuthLogOut event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    unawaited(SecureStorageManager.write(SecureStorageKeys.login, null));
    unawaited(SecureStorageManager.write(SecureStorageKeys.password, null));
    unawaited(
        SecureStorageManager.write(SecureStorageKeys.secretKeyPart, null));
    unawaited(PreferencesHelper.write(PrefsKeys.authWithBiometric, false));
    dataManager.authWithBiometricsFlag = false;
    unawaited(SecureStorageManager.write(SecureStorageKeys.pincode, null));
    dataManager.safeViewVisible = true;
    emit(AuthLogOutSuccess());

    emit(AuthInitial());
  }
}
