// ignore_for_file: avoid_void_async

import 'package:bloc/bloc.dart';
import 'package:bpc/data/data.dart';
import 'package:bpc/models/models.dart';
import 'package:equatable/equatable.dart';

part 'polls_list_event.dart';
part 'polls_list_state.dart';

class PollsListBloc extends Bloc<PollsListEvent, PollsListState> {
  final DataManager dataManager;

  PollsListBloc({
    required this.dataManager,
  }) : super(PollsListLoading()) {
    on<PollsListEvent>(_onEvent);
  }

  late PollsListFiltersData filters;

  void _onEvent(
    PollsListEvent event,
    Emitter<PollsListState> emit,
  ) {
    if (event is PollsListInit) return  _onPollsListInit(event, emit);
    if (event is PollsListLoadMore) return _onPollsListLoadMore(event, emit);
    if (event is PollsListNotifyPoll) return _onPollsListNotifyPoll(event, emit);
    if (event is PollsListCancelPoll) return _onPollsListCancelPoll(event, emit);
    if (event is PollsListDeletePoll) return _onPollsListDeletePoll(event, emit);
    if (event is PollsListEditPoll) return _onPollsListEditPoll(event, emit);
  }

  void _onPollsListInit(
    PollsListInit event,
    Emitter<PollsListState> emit,
  ) async {
    emit(PollsListLoading());

    try {
      final response = await dataManager.pollsListRequest(
        topic: event.filters.topic,
        status: event.filters.status,
        stopDateFrom: event.filters.stopDateFrom,
        stopDateTo: event.filters.stopDateTo,
      );
      if (response.errorCode == 0) {   
        filters = event.filters;   
        emit(PollsListLoaded(
          confirmedCount: response.confirmedCount ?? 0,
          participantsCount: response.participantsCount ?? 0,
          polls: response.polls ?? []
        ));
      } else {
        emit(PollsListErrorKomplat(
          actionType: ActionType.refresh,
          errorCode: response.errorCode,
          errorMessage: response.errorText
        ));
      }
    // ignore: avoid_catches_without_on_clauses
    } catch (error, _) {
      emit(PollsListError(
        actionType: ActionType.refresh,
        error: error
      ));
    }
  }

  void _onPollsListLoadMore(
    PollsListLoadMore event,
    Emitter<PollsListState> emit,
  ) async {
    emit(PollsListLoading());

    try {
      final response = await dataManager.pollsListRequest(
        topic: filters.topic,
        status: filters.status,
        stopDateFrom: filters.stopDateFrom,
        stopDateTo: filters.stopDateTo,
        lastPollId: event.lastPollId
      );
      if (response.errorCode == 0) {      
        emit(PollsListLoadedMore(
          polls: response.polls ?? []
        ));
      } else {
        emit(PollsListErrorKomplat(
          actionType: ActionType.loadMore,
          errorCode: response.errorCode,
          errorMessage: response.errorText
        ));
      }
    // ignore: avoid_catches_without_on_clauses
    } catch (error, _) {
      emit(PollsListError(
        actionType: ActionType.loadMore,
        error: error
      ));
    }
  }

  void _onPollsListNotifyPoll(
    PollsListNotifyPoll event,
    Emitter<PollsListState> emit,
  ) async {
    emit(PollsListLoading());

    try {
      final response = await dataManager.notificationPollRequest(
        id: event.id,
        message: event.message
      );
      if (response.errorCode == 0) {      
        emit(PollListNotifyPollSuccess(
          id: event.id
        ));
      } else {
        emit(PollsListErrorKomplat(
          errorCode: response.errorCode,
          errorMessage: response.errorText
        ));
      }
    // ignore: avoid_catches_without_on_clauses
    } catch (error, _) {
      emit(PollsListError(
        error: error
      ));
    }
  }

  void _onPollsListCancelPoll(
    PollsListCancelPoll event,
    Emitter<PollsListState> emit,
  ) async {
    emit(PollsListLoading());

    try {
      final response = await dataManager.cancelPollRequest(
        id: event.id,
      );
      if (response.errorCode == 0) {      
        emit(PollsListCancelPollSuccess(
          id: event.id,
        ));
      } else {
        emit(PollsListErrorKomplat(
          errorCode: response.errorCode,
          errorMessage: response.errorText
        ));
      }
    // ignore: avoid_catches_without_on_clauses
    } catch (error, _) {
      emit(PollsListError(
        error: error
      ));
    }
  }

  void _onPollsListDeletePoll(
    PollsListDeletePoll event,
    Emitter<PollsListState> emit,
  ) async {
    emit(PollsListLoading());

    try {
      final response = await dataManager.deletePollRequest(
        id: event.id,
      );
      if (response.errorCode == 0) {      
        emit(PollsListDeletePollSuccess(
          id: event.id,
        ));
      } else {
        emit(PollsListErrorKomplat(
          errorCode: response.errorCode,
          errorMessage: response.errorText
        ));
      }
    // ignore: avoid_catches_without_on_clauses
    } catch (error, _) {
      emit(PollsListError(
        error: error
      ));
    }
  }

  void _onPollsListEditPoll(
    PollsListEditPoll event,
    Emitter<PollsListState> emit,
  ) async {
    emit(PollsListLoading());

    emit(PollsListEditPollSuccess(
      poll: event.poll,
    ));
  }
}
