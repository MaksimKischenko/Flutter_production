// ignore_for_file: avoid_void_async

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:isc_web_app/data/data.dart';
import 'package:isc_web_app/data/data_manager.dart';


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
    ));
  }

}
