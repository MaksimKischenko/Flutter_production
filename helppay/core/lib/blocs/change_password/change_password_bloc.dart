import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:helppay_core/data/data.dart';
import 'package:helppay_core/generated/translations.g.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final DataManager dataManager;

  ChangePasswordBloc({required this.dataManager})
      : super(ChangePasswordLoading()) {
    on<ChangePasswordEvent>(_onEvent);
  }

  Future<void>? _onEvent(ChangePasswordEvent event, Emitter<ChangePasswordState> emit) {
    if (event is ChangePasswordInit) return _onChangePassword(event, emit);
    if (event is ChangePasswordAction) {
      return _onChangePasswordAction(event, emit);
    }
    return null;
  }

  Future<void> _onChangePassword(
      ChangePasswordInit event, Emitter<ChangePasswordState> emit) async {
    emit(ChangePasswordLoading());

    final oldPassword =  await SecureStorageManager.read(SecureStorageKeys.password);
    emit(ChangePasswordInitial(oldPassword: oldPassword ?? ''));
  }

  Future<void> _onChangePasswordAction(
      ChangePasswordAction event, Emitter<ChangePasswordState> emit) async {
    emit(ChangePasswordActionLoading());

    final password = await SecureStorageManager.read(SecureStorageKeys.password);

    if (password == event.oldPassword) {
      try {
        final response = await dataManager.editUserRequest(
            needChangePassword: EditUserRequestNeedChangePassword(
                evalue: 1,
                oldPassword: event.oldPassword,
                newPassword: event.newPassword));
        if (response.errorCode.evalue == 0) {
          await SecureStorageManager.write(
              SecureStorageKeys.password, event.newPassword);

          emit(ChangePasswordSuccess());
        } else {
          emit(ChangePasswordErrorKomplat(
              errorCode: response.errorCode.evalue,
              errorMessage: response.errorCode.errorText));
        }
      } catch (error) {
        emit(ChangePasswordError(error: error));
      }
    } else {
      emit(ChangePasswordError(
        error: t.exceptions.changePasswordBloc.wrongOldPassword,
      ));
    }

    emit(ChangePasswordInitial(oldPassword: password ?? ''));
  }
}
