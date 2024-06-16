import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:web_cabinet_nkfo/config.dart';
import 'package:web_cabinet_nkfo/data/data.dart';
import 'package:web_cabinet_nkfo/injection_component.dart';
import 'package:web_cabinet_nkfo/models/models.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  DataManager dataManager;
  bool _isChangePasswordAvailable = true;

  ChangePasswordBloc() : dataManager = InjectionComponent.getDependency<DataManager>(), 
  super(ChangePasswordInitial());

  @override
  Stream<ChangePasswordState> mapEventToState(
    ChangePasswordEvent event,
  ) async* {
    if (event is ChangePasswordRun) {
      yield* _mapChangePasswordRunToState(event);
    }
  }

  Stream<ChangePasswordState> _mapChangePasswordRunToState(
    ChangePasswordRun event
  ) async* {

    _isChangePasswordAvailable = dataManager.userRights.isAvailable(EntityMethod.postM, EntityName.changePassword);

    yield ChangePasswordLoading();

    //final credentials = await PreferencesHelper.getCredentials();

    try {
      final password = AppConfig.passwordCrypter(event.password);
      final newPassword = AppConfig.passwordCrypter(event.newPassword);


      //if (credentials.item2 == password) {
      _isChangePasswordAvailable? await dataManager.changePasswordRequest(
        username: dataManager.login, 
        password: password,     
        newPassword: newPassword

      ) : log('no permisson');
        //await PreferencesHelper.setCredentials(credentials.item1!, newPassword);
        yield _isChangePasswordAvailable? ChangePasswordSuccess() 
        : const ChangePasswordError(
          error: AppConfig.changePasswordIsNotAvaliable
        );
      // } else {
      //   throw Exception('Неверный старый пароль');
      // }
    
    } on Exception catch  (error, _){
      yield ChangePasswordError(
        error: error
      );
    }
  }
}
