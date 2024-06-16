// ignore_for_file: avoid_void_async

import 'package:bloc/bloc.dart';
import 'package:bpc/data/data.dart';
import 'package:equatable/equatable.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final DataManager dataManager;

  ChangePasswordBloc({
    required this.dataManager,
  }) : super(ChangePasswordInitial()) {
    on<ChangePasswordEvent>(_onEvent);
  }

  void _onEvent(ChangePasswordEvent event, Emitter<ChangePasswordState> emit) {
    if (event is ChangePasswordProceed)
      return _onChangePasswordProceed(event, emit);
  }

  void _onChangePasswordProceed(
    ChangePasswordProceed event,
    Emitter<ChangePasswordState> emit,
  ) async {
    emit(ChangePasswordActionLoading());

    try {
      final response = await dataManager.editUserRequest(
          needChangePassword: EditUserRequestNeedChangePassword(
              evalue: 1,
              oldPassword: event.oldPassword,
              newPassword: event.newPassword));
      if (response.errorCode.evalue == 0) {
        final login = await SecureStorageManager.read(SecureStorageKeys.login);
        if (login != null) {
          await SecureStorageManager.write(
              SecureStorageKeys.password, event.newPassword);
        }

        emit(ChangePasswordSuccess());
      } else {
        emit(ChangePasswordErrorKomplat(
            errorCode: response.errorCode.evalue,
            errorMessage: response.errorCode.errorText));
      }
    } catch (error) {
      emit(ChangePasswordError(error: error));
    }

    emit(ChangePasswordInitial());
  }
}
