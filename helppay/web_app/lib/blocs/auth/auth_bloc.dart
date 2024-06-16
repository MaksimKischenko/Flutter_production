// ignore_for_file: avoid_void_async

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_core/helppay_core.dart';
import 'package:helppay_web_app/data/local/preferences_helper.dart';

part 'auth_event.dart';
part 'auth_state.dart';

void _log(dynamic message) => Logger.helpPayLog(message, name: 'web_auth_bloc');

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final DataManager dataManager;

  AuthBloc({required this.dataManager}) : super(AuthInitial()) {
    on<AuthEvent>(_onEvent);
  }

  void _onEvent(AuthEvent event, Emitter<AuthState> emit) {
    if (event is AuthCheck) return _onAuthCheck(event, emit);
    if (event is AuthRun) return _onAuthRun(event, emit);
    if (event is AuthLogOut) return _onAuthLogOut(event, emit);
  }

  void _onAuthCheck(AuthCheck event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final credentials = await PreferencesHelperWeb.getCredentials();

    if (credentials.item1 != null && credentials.item2 != null) {
      try {
        final response = await dataManager.loginRequest(
          login: credentials.item1,
          password: credentials.item2,
        );
        _log('Data after login - ${response.lookups?.lookups[0]}');
        _log(
            'Data after login - ${response.lookups?.lookups[0].items?[0].name}');

        if (response.errorCode.evalue == 0) {
          dataManager
            ..email = credentials.item1
            ..terminalId = response.token?.terminalId ?? ''
            ..token = response.token?.evalue ?? ''
            ..versionReg = response.token?.version ?? ''
            ..userParams = response.params?.params
            ..lookups = response.lookups?.lookups[0]
            ..userProducts = response.products;
          emit(AuthSuccess());
          _log('Data saved in storage - ${dataManager.lookups}');
        } else {
          emit(AuthErrorKomplat(
              errorCode: response.errorCode.evalue,
              errorMessage: response.errorCode.errorText));
        }
        emit(AuthAuthorized());
      } on DioException catch (e) {
        String? message;
        if (e.type == DioExceptionType.badResponse) {
          message = (e.response?.data as Map?)?['message'] as String?;
        }
        emit(AuthError(
            error: message ?? 'Сервер не может обработать ваш запрос'));

        await PreferencesHelperWeb.clearCredentials();

        emit(AuthUnauthorized());
      } catch (error, _) {
        emit(AuthError(error: error));
        emit(AuthUnauthorized());
      }
    } else {
      emit(AuthUnauthorized());
    }
  }

  void _onAuthRun(AuthRun event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final response = await dataManager.loginRequest(
        login: event.data.login,
        password: event.data.password,
      );

      if (response.errorCode.evalue == 0) {
        _log('User products - ${response.products}');
        dataManager
          ..email = event.data.login
          ..terminalId = response.token?.terminalId ?? ''
          ..token = response.token?.evalue ?? ''
          ..versionReg = response.token?.version ?? ''
          ..userParams = response.params?.params
          ..lookups = response.lookups?.lookups[0]
          ..userProducts = response.products;
        emit(AuthSuccess());

        await PreferencesHelperWeb.setCredentials(
            event.data.login ?? '', event.data.password ?? '');

        emit(AuthAuthorized());
      } else {
        emit(AuthErrorKomplat(
            errorCode: response.errorCode.evalue,
            errorMessage: response.errorCode.errorText));
      }
    } catch (error) {
      emit(AuthError(error: error));
      emit(AuthUnauthorized());
    }
  }

  void _onAuthLogOut(AuthLogOut event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await PreferencesHelperWeb.clearCredentials();
    dataManager.token = '';
    emit(AuthLogOutSuccess());
    emit(AuthUnauthorized());
    emit(AuthInitial());
  }
}
