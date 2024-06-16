// ignore_for_file: avoid_void_async
import 'package:bloc/bloc.dart';
import 'package:bpc/data/data.dart';
import 'package:bpc/models/models.dart';
import 'package:bpc/utils/loger.dart';
import 'package:bpc/utils/route_helper.dart';
import 'package:bpc/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'auth_mdom_event.dart';
part 'auth_mdom_state.dart';

void _log(dynamic message) =>
    Logger.helpPayLog(message, name: 'auth_mdom_bloc');

class AuthMdomBloc extends Bloc<AuthMdomEvent, AuthMdomState> {
  final DataManager dataManager;

  late String _email;
  late String _password;

  AuthMdomBloc({
    required this.dataManager,
  }) : super(AuthMdomInitial()) {
    on<AuthMdomEvent>(_onEvent);
  }

  static const kTerminalIdFiz = 'TERM_FIZ_MB';

  void _onEvent(
    AuthMdomEvent event,
    Emitter<AuthMdomState> emit,
  ) {
    if (event is AuthMdomRun) return _onAuthMdomRun(event, emit);
    if (event is AuthMdomSetPin) return _onAuthMdomSetPin(event, emit);
    if (event is AuthMdomBiometricResponse) {
      return _onAuthMdomBiometricResponse(event, emit);
    }
    if (event is AuthMdomLogOut) return _onAuthMdomLogOut(event, emit);
    if (event is AuthCheck) return _onAuthCheck(event, emit);
  }

  void _onAuthMdomRun(
    AuthMdomRun event,
    Emitter<AuthMdomState> emit,
  ) async {
    emit(AuthMdomLoading());

    try {
      final response = await dataManager.loginRequest(
        login: event.email,
        password: event.password,
      );
      if (response.errorCode.evalue == 0) {
        if (response.token!.terminalId == kTerminalIdFiz) {
          throw OnlyEntityException();
        }
        dataManager
          ..email = event.email
          ..terminanlId = response.token!.terminalId!
          ..token = response.token?.evalue ?? ''
          ..versionReg = response.token!.version!
          ..userParams = response.params?.params;

        if (event.isAuthSaveChecked) {
          _email = event.email;
          _password = event.password;

          if (!kIsWeb) {
            emit(AuthMdomPinSetup());
          } else {
            emit(AuthMdomLoading());

            await dataManager.loadServicesList();
            await dataManager.informationRequest();

            await SecureStorageManager.write(SecureStorageKeys.login, _email);
            await SecureStorageManager.write(
                SecureStorageKeys.password, _password);

            // dataManager.safeViewVisible = false;
            emit(AuthMdomSuccessLogin());
          }
          dataManager.isCredentialsSaveChecked = event.isAuthSaveChecked;
        } else {
          await dataManager.loadServicesList();
          await dataManager.informationRequest();
          dataManager.safeViewVisible = false;
          emit(AuthMdomSuccessLogin());
          dataManager.isCredentialsSaveChecked = event.isFromSplash;
        }
      } else {
        emit(AuthMdomErrorKomplat(
            errorCode: response.errorCode.evalue,
            errorMessage: response.errorCode.errorText));
      }
      // ignore: avoid_catches_without_on_clauses
    } catch (error) {
      emit(AuthMdomError(error: error));
    }
    // yield AuthInitial();
  }

  void _onAuthCheck(AuthCheck event, Emitter<AuthMdomState> emit) async {
    final url = RouteHelper.parsePathWithStringParams(event.path);
    // emit(AuthLoading());

    final credentials = await PreferencesHelper.getCredentials();

    if (credentials.item1 != null && credentials.item2 != null) {
      try {
        final response = await dataManager.loginRequest(
          login: credentials.item1,
          password: credentials.item2,
        );

        if (response.errorCode.evalue == 0) {
          dataManager
            ..email = credentials.item1
            ..terminanlId = response.token?.terminalId ?? ''
            ..token = response.token?.evalue ?? ''
            ..versionReg = response.token?.version ?? ''
            ..userParams = response.params?.params;
          emit(AuthMdomSuccessLogin());
        } else {
          emit(AuthMdomErrorKomplat(
              errorCode: response.errorCode.evalue,
              errorMessage: response.errorCode.errorText));
        }
        emit(
          AuthAuthorized(
              needToNavigate:
                  url.key == '' || url.key == '/' || url.key == '/auth'),
        ); //false
      } on DioException catch (e) {
        String? message;
        if (e.type == DioExceptionType.badResponse) {
          message = (e.response?.data as Map?)?['message'] as String?;
        }
        emit(AuthMdomError(
            error: message ?? 'Сервер не может обработать ваш запрос'));

        await PreferencesHelper.clearCredentials();

        emit(AuthUnauthorized(needToNavigate: url.key != '/auth'));
        // ignore: avoid_catches_without_on_clauses
      } catch (error, _) {
        emit(AuthMdomError(error: error));
        emit(AuthUnauthorized(needToNavigate: url.key != '/auth'));
      }
    } else {
      emit(AuthUnauthorized(needToNavigate: url.key != '/auth'));
    }
  }

  void _onAuthMdomSetPin(
    AuthMdomSetPin event,
    Emitter<AuthMdomState> emit,
  ) async {
    emit(AuthMdomLoading());

    await dataManager.loadServicesList();
    await dataManager.informationRequest();

    await SecureStorageManager.write(SecureStorageKeys.pincode, event.pin);
    await SecureStorageManager.write(SecureStorageKeys.login, _email);
    await SecureStorageManager.write(SecureStorageKeys.password, _password);

    const bioTypeMap = <KomplatBiometricType, String>{
      KomplatBiometricType.faceid: 'Face ID',
      KomplatBiometricType.touchid: 'Touch ID',
      KomplatBiometricType.biometric: 'биометрию'
    };

    if (dataManager.isAvailableBiometricAuth) {
      emit(
        AuthMdomAskForBiometrics(
          biometricDescription: bioTypeMap[dataManager.komplatBiometricType]!,
        ),
      );
    } else {
      emit(AuthMdomSuccessLogin());
    }
  }

  void _onAuthMdomBiometricResponse(
    AuthMdomBiometricResponse event,
    Emitter<AuthMdomState> emit,
  ) async {
    emit(AuthMdomLoading());

    if (event.response) {
      await PreferencesHelper.write(PrefsKeys.authWithBiometric, true);
      dataManager.authWithBiometricsFlag = true;
    }
    dataManager.safeViewVisible = false;
    emit(AuthMdomSuccessLogin());
  }

  void _onAuthMdomLogOut(
    AuthMdomLogOut event,
    Emitter<AuthMdomState> emit,
  ) async {
    emit(AuthMdomLoading());

    await PreferencesHelper.clearAll();
    await SecureStorageManager.clearAll();

    dataManager
      ..authWithBiometricsFlag = false
      ..servicesList = []
      ..informationResponse = null
      ..safeViewVisible = true
      ..token = '';

    // unawaited(Navigation.toSplash());
    emit(const AuthUnauthorized(needToNavigate: false));

    emit(AuthMdomInitial());
  }
}
