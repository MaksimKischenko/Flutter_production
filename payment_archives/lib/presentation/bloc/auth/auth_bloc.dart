import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/data/local/local_storage.dart';
import 'package:payment_tracking_module/domain/entities/entities.dart';
import 'package:payment_tracking_module/domain/use_cases/use_cases.dart';


part 'auth_event.dart';
part 'auth_state.dart';


class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {
  final TokenUseCase useCase;

  AuthBloc(): 
  useCase = TokenUseCase(),
  super(AuthInitial()) {
    on<AuthEvent>(_onEvent);
  }
  
  Future<void>? _onEvent(
    AuthEvent event,
    Emitter<AuthState> emit
  ) {
    if (event is AuthRun) return _onAuthRun(event, emit);
    if (event is AuthRefreshToken) return _onAuthRefresh(event, emit);
    if (event is AuthLogOut) {
      return _onAuthLogOut(event, emit);
    } else {
      return null;
    }
  }

  bool _saveCredentials = false;

  Future<void> _onAuthRun(
    AuthRun event,
    Emitter<AuthState> emit
  ) async {
    emit(AuthLoading());

      final _password =  useCase.dataManager.passwordCrypter(event.data.password ?? '');
      final result = await useCase.getTokenRequest(
        username: event.data.login ?? '', 
        password: _password, 
        grantType: TokenRequestData.grantTypePassword.name
      );
  
      await result.fold((failure) {
        emit(AuthError(error: failure.message));
        emit(AuthUnauthorized());
      }, (right) async {
          emit(AuthSuccess());
          final _decodedToken = JwtDecoder.decode(right.data.accessToken ?? '');
          final _tokenData = TokenBodyData.fromJson(_decodedToken);
          useCase.dataManager
          ..tokendata = _tokenData
          ..accessToken = right.data.accessToken
          ..refreshToken = right.data.refreshToken
          ..login = event.data.login ?? '';   
          _saveCredentials = event.saveCredentials ?? false;   

          if(_saveCredentials) {
            await LocalStorage.setCredentials(event.data.login ?? '', event.data.password ?? '');
          }

          emit(AuthAuthorized(
            accessToken: right.data.accessToken,
            refreshToken: right.data.refreshToken,
            tokenData: _tokenData,
            saveCredentials: _saveCredentials,
            login: event.data.login ?? '',
            password: event.data.password ?? ''
          ));   
      });  
  }


   Future<void> _onAuthRefresh(
    AuthRefreshToken event,
    Emitter<AuthState> emit
  ) async {

    final result = await useCase.getTokenRequest(
      grantType: TokenRequestData.grantTypeRefresh.name,
      refreshToken: useCase.dataManager.refreshToken
    );

    await result.fold((failure) {
        emit(AuthError(error: failure.message));
        emit(AuthUnauthorized());
    }, (right) async {
        final _decodedToken = JwtDecoder.decode(right.data.accessToken ?? '');
        final _tokenData = TokenBodyData.fromJson(_decodedToken);

        useCase.dataManager
        ..tokendata = _tokenData
        ..accessToken = right.data.accessToken
        ..refreshToken = right.data.refreshToken;   
    });      
  }

  Future<void> _onAuthLogOut(
    AuthLogOut event,
    Emitter<AuthState> emit
  ) async {
    emit(AuthLoading());
    
    if(!_saveCredentials) unawaited(LocalStorage.clearCredentials());
    unawaited(HydratedBloc.storage.clear());

    useCase.dataManager
    ..tokendata = null
    ..login = ''
    ..accessToken = null
    ..refreshToken = null;

    emit(AuthLogOutSuccess());
    emit(AuthUnauthorized());
    emit(AuthInitial());
  }
  
  @override
  AuthState? fromJson(Map<String, dynamic> json)  {
    useCase.dataManager
    ..accessToken = json['accessToken'] as String?
    ..refreshToken = json['refreshToken'] as String?
    ..login = (json['login'] as String?) ?? ''
    ..tokendata = TokenBodyData.fromJson(JwtDecoder.decode((json['accessToken'] as String?) ?? ''));

    _saveCredentials = (json['saveCredentials'] as bool?) ?? false;

    if(_saveCredentials) LocalStorage.setCredentials(json['login'] as String, json['password'] as String);

    return AuthAuthorized(
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
      saveCredentials: json['saveCredentials'] as bool?,
      login: json['login'] as String?,
      password: json['password'] as String?,
    );
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    if(state is AuthAuthorized) {
      return {
        'accessToken': state.accessToken,
        'refreshToken': state.refreshToken,
        'saveCredentials' : state.saveCredentials,
        'login' : state.login,
        'password': state.password
      };
    }
    return null;
  }
}

