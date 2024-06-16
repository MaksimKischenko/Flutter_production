import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:payment_tracking_module/data/local/local_storage.dart';
import 'package:payment_tracking_module/domain/use_cases/use_cases.dart';


part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final ChangePasswordUseCase useCase;
  
  ChangePasswordBloc()
  : useCase = ChangePasswordUseCase()
  ,super(ChangePasswordInitial()) {
    on<ChangePasswordEvent>(_onEvent);
  }
  
  Future<void>? _onEvent(
    ChangePasswordEvent event,
    Emitter<ChangePasswordState> emit
  ) {
    if (event is ChangePasswordRun) return _onChangePasswordRun(event, emit);
    return null;
  }

  Future<void> _onChangePasswordRun(
    ChangePasswordRun event,
    Emitter<ChangePasswordState> emit,   

  ) async {

    emit(ChangePasswordLoading());

      final _oldPassword = useCase.changePasswordRepository.dataManager.passwordCrypter(event.oldPassword);
      final _newPassword = useCase.changePasswordRepository.dataManager.passwordCrypter(event.newPassword);

      final result = await useCase.getNewPassword(
        oldPassword: _oldPassword,
        newPassword: _newPassword
      );

      await result.fold((failure) {
        emit(ChangePasswordError(error: failure.message));
      }, (right) async{
        await LocalStorage.clearCredentials();
        emit(ChangePasswordSuccess());
      });
  }
}
