// ignore_for_file: avoid_void_async

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:helppay_core/data/data.dart';
import 'package:helppay_core/models/models.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final DataManager dataManager;

  ProfileBloc({
    required this.dataManager,
  }) : super(ProfileLoading()) {
    on<ProfileEvent>(_onEvent);
  }

  void _onEvent(
    ProfileEvent event,
    Emitter<ProfileState> emit,
  ) {
    if (event is ProfileInit) return _onProfileInit(event, emit);
    if (event is ProfileParamsChanged) {
      return _onProfileParamsChanged(event, emit);
    }
    if (event is ProfileChangeAuthWithBiometrics) {
      return _onProfileChangeAuthWithBiometrics(event, emit);
    }
  }

  void _onProfileInit(
    ProfileInit event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());

    emit(ProfileInitial(
        email: dataManager.email ?? '',
        username: dataManager.username,
        userParams: dataManager.userParams ?? [],
        lookups: dataManager.lookups,
        isAvailableBiometricAuth: dataManager.isAvailableBiometricAuth,
        komplatBiometricType: dataManager.komplatBiometricType,
        authWithBiometricsFlag: dataManager.authWithBiometricsFlag));
  }

  void _onProfileParamsChanged(
    ProfileParamsChanged event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    final params = MdomRequestParams(
        params: event.params
            .map((e) => MdomRequestParam(
                  name: e.name,
                  id: e.id,
                  idParent: e.idParent,
                  evalue: e.evalue,
                  alias: e.alias,
                ))
            .toList());
    try {
      final response = await dataManager.editUserRequest(userParams: params);
      if (response.errorCode.evalue == 0) {
        for (final changedParam in event.params) {
          dataManager.userParams
              ?.firstWhere((param) => param.id == changedParam.id)
              .evalue = changedParam.evalue;
        }

        emit(ProfileSuccessEdit());
      } else {
        emit(ProfileErrorKomplat(
            errorCode: response.errorCode.evalue,
            errorMessage: response.errorCode.errorText));
      }
    } catch (error) {
      emit(ProfileError(error: error));
    }
    emit(ProfileInitial(
      email: dataManager.email ?? '',
      username: dataManager.username,
      userParams: dataManager.userParams ?? [],
      lookups: dataManager.lookups,
      isAvailableBiometricAuth: dataManager.isAvailableBiometricAuth,
      komplatBiometricType: dataManager.komplatBiometricType,
      authWithBiometricsFlag: dataManager.authWithBiometricsFlag,
    ));
  }

  void _onProfileChangeAuthWithBiometrics(
    ProfileChangeAuthWithBiometrics event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());

    await PreferencesHelper.write(PrefsKeys.authWithBiometric, event.value);
    dataManager.authWithBiometricsFlag = event.value;

    emit(ProfileInitial(
        email: dataManager.email ?? '',
        username: dataManager.username,
        userParams: dataManager.userParams ?? [],
        isAvailableBiometricAuth: dataManager.isAvailableBiometricAuth,
        komplatBiometricType: dataManager.komplatBiometricType,
        authWithBiometricsFlag: dataManager.authWithBiometricsFlag));
  }
}
