// ignore_for_file: avoid_void_async

import 'package:bloc/bloc.dart';
import 'package:bpc/data/data.dart';
import 'package:equatable/equatable.dart';

part 'poll_members_event.dart';
part 'poll_members_state.dart';

class PollMembersBloc extends Bloc<PollMembersEvent, PollMembersState> {
  final DataManager dataManager;
  final int id;

  PollMembersBloc({
    required this.dataManager,
    required this.id,
  }) : super(PollMembersLoading()) {
    on<PollMembersEvent>(_onEvent);
  }

  void _onEvent(
    PollMembersEvent event,
    Emitter<PollMembersState> emit,
  ) {
    if (event is PollMembersInit) return _onPollMembersInit(event, emit);
  }

  void _onPollMembersInit(
    PollMembersInit event,
    Emitter<PollMembersState> emit,
  ) async {
    emit(PollMembersLoading());

    try {
      final response = await dataManager.pollMembersListRequest(
        id: id,
      );

      if (response.errorCode == 0) {
        emit(PollMembersLoaded(members: response.members ?? []));
      } else {
        emit(PollMembersErrorKomplat(
            errorCode: response.errorCode, errorMessage: response.errorText));
      }
      // ignore: avoid_catches_without_on_clauses
    } catch (error) {
      emit(PollMembersError(error: error));
    }
  }
}
