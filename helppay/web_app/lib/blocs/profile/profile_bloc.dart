// ignore_for_file: avoid_void_async

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:helppay_core/data/data.dart';


part 'profile_event.dart';
part 'profile_state.dart';

// void _log(dynamic message) =>
//     Logger.helpPayLog(message, name: 'web_profile_bloc');

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
  }

  void _onProfileInit(
    ProfileInit event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    // _log('dataManager lookups data - ${dataManager.lookups?.items?[0].name}');
    emit(ProfileInitial(
      email: dataManager.email ?? '',
      username: dataManager.username,
      lookups: dataManager.lookups,
      userParams: dataManager.userParams ?? [],
    ));
  }

  void _onProfileParamsChanged(
    ProfileParamsChanged event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());

    try {
      final response = await dataManager.editUserRequest(
          userParams: MdomRequestParams(params: event.params));
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
    emit(
      ProfileInitial(
        email: dataManager.email ?? '',
        username: dataManager.username,
        lookups: dataManager.lookups,
        userParams: dataManager.userParams ?? [],
      ),
    );
  }
}
