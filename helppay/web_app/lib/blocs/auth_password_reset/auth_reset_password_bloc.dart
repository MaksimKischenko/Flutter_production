// ignore_for_file: avoid_void_async
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_core/data/data.dart';
import 'package:helppay_core/models/models.dart';

part 'auth_reset_password_event.dart';
part 'auth_reset_password_state.dart';

class AuthResetPasswordBloc
    extends Bloc<AuthResetPasswordEvent, AuthResetPasswordState> {
  final DataManager dataManager;

  AuthResetPasswordBloc({required this.dataManager})
      : super(AuthResetInitial()) {
    on<AuthResetPasswordEvent>(_onEvent);
  }

  void _onEvent(
      AuthResetPasswordEvent event, Emitter<AuthResetPasswordState> emit) {
    if (event is AuthResetPassword) return _onAuthResetPassword(event, emit);
  }

  void _onAuthResetPassword(
      AuthResetPassword event, Emitter<AuthResetPasswordState> emit) async {
    emit(AuthResetLoading());

    try {
      final response = await dataManager.resetPasswordRequest(
        login: event.data.login,
        email: event.data.email,
        phone: event.data.phone,
      );
      if (response.errorCode.evalue == 0) {
        emit(AuthResetSuccess());
      } else {
        emit(
          AuthResetErrorKomplat(
            errorCode: response.errorCode.evalue,
            errorMessage: response.errorCode.errorText,
          ),
        );
      }
    } catch (error) {
      emit(AuthResetError(error: error));
    }
  }
}
