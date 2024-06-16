import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:web_cabinet_nkfo/config.dart';
import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/data/remote_models/user_right_response.dart';
import 'package:web_cabinet_nkfo/injection_component.dart';
import 'package:web_cabinet_nkfo/route_helper.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  DataManager dataManager;
  AuthBloc()
      : dataManager = InjectionComponent.getDependency<DataManager>(),
        super(AuthLoading());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AuthCheck) {
      yield* _mapAuthCheckToState(event);
    } else if (event is AuthRun) {
      yield* _mapAuthRunToState(event);
    } else if (event is AuthLogOut) {
      yield* _mapAuthLogOutToState(event);
    }
  }

  Stream<AuthState> _mapAuthCheckToState(AuthCheck event) async* {
    final url = RouteHelper.parsePathWithStringParams(event.path);
    final next = url.key != '' && url.key != '/' ? url.value : null;

    yield AuthLoading();

    final credentials = await PreferencesHelper.getCredentials();
    if (kDebugMode) {
      print('credentials ${credentials.item1} ${credentials.item2}');
    }
    if (credentials.item1 != null && credentials.item2 != null) {
      try {
        final response = await dataManager.loginUserRequest(
            username: credentials.item1!, password: credentials.item2!);

        dataManager.token = response.token;

        final userRightResponse = await dataManager.userRightRequest();

        dataManager.userRights = UserRightsWrapper(userRightResponse);

        yield AuthAuthorized(
          needToNavigate: url.key == '' || url.key == '/' || url.key == '/auth',
        );
      } on DioError catch (e) {
        String? message;
        if (e.type == DioErrorType.response) {
          message = (e.response?.data as Map?)?['message'] as String?;
        }

        yield AuthError(
            error: message ?? 'Сервер не может обработать ваш запрос');
        await PreferencesHelper.clearCredentials();
        yield AuthUnauthorized(needToNavigate: url.key != '/auth');
        
      } on Exception catch  (error, _){
        yield AuthError(error: error);
        yield AuthUnauthorized(needToNavigate: url.key != '/auth', next: next);
      }
    } else {
      yield AuthUnauthorized(needToNavigate: url.key != '/auth', next: next);
    }
  }

  Stream<AuthState> _mapAuthRunToState(AuthRun event) async* {
    yield AuthLoading();

    try {
      final password = AppConfig.passwordCrypter(event.password);
      final response = await dataManager.loginUserRequest(
          username: event.login, password: password);

      dataManager.token = response.token;

      final userRightResponse = await dataManager.userRightRequest();

      dataManager.userRights = UserRightsWrapper(userRightResponse);

      if(kDebugMode) await PreferencesHelper.setCredentials(event.login, password);

      yield AuthAuthorized(needToNavigate: true, next: event.next);
      
      dataManager.login = event.login;


    } on Exception catch  (error, _){
      yield AuthError(error: error);
      yield const AuthUnauthorized(needToNavigate: false);
    }
  }

  Stream<AuthState> _mapAuthLogOutToState(AuthLogOut event) async* {
    yield AuthLoading();

    try {
      await dataManager.logoutUserRequest();
      await PreferencesHelper.clearCredentials();
      dataManager..token = null
      ..userRights = UserRightsWrapper.empty();

      yield AuthLogOutSuccess();

      yield const AuthUnauthorized(needToNavigate: false);

      dataManager.login = '';
    } on Exception catch  (error, _) {
      yield AuthError(error: error);
    }
  }
}
