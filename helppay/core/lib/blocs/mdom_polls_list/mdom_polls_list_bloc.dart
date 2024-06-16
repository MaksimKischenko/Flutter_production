// ignore_for_file: avoid_void_async

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:helppay_core/helppay_core.dart';

part 'mdom_polls_list_event.dart';
part 'mdom_polls_list_state.dart';

void _log(dynamic message) =>
    Logger.helpPayLog(message, name: 'mdom_polls_list_bloc');

class MdomPollsListBloc extends Bloc<MdomPollsListEvent, MdomPollsListState> {
  final DataManager dataManager;
  // final int supplierId;

  MdomPollsListBloc({
    required this.dataManager,
    // required this.supplierId,
  }) : super(MdomPollsListLoading()) {
    on<MdomPollsListEvent>(_onEvent);
  }

  late PollsListFiltersData filters;

  void _onEvent(
    MdomPollsListEvent event,
    Emitter<MdomPollsListState> emit,
  ) {
    if (event is MdomPollsListInit) return _onMdomPollsListInit(event, emit);
    if (event is MdomPollsListLoadMore) {
      return _onMdomPollsListLoadMore(event, emit);
    }
    if (event is MdomPollsListGetNotificationCount) {
      return _onMdomPollsListGetNotificationCount(event, emit);
    }
  }

  void _onMdomPollsListInit(
    MdomPollsListInit event,
    Emitter<MdomPollsListState> emit,
  ) async {
    emit(MdomPollsListLoading());

    try {
      final response = await dataManager.pollsListRequest(
          // topic: ,
          status: event.filters.status,
          stopDateFrom: event.filters.stopDateFrom,
          stopDateTo: event.filters.stopDateTo,
          supplierId: event.supplierId);
      if (response.errorCode == 0) {
        filters = event.filters;
        // emit(MdomPollsListLoaded(
        //   participantsCount: response.participantsCount ?? 0,
        //   polls: response.polls ?? [],
        //   notificationsUnreadCount: 0,
        // ));
        response.polls?.forEach(
          (e) => _log('Current poll $e - ${e.currentResultHiden}'),
        );
        _log('Current polls - ${response.polls}');
        add(MdomPollsListGetNotificationCount(
          supplierId: event.supplierId,
          participantsCount: response.participantsCount ?? 0,
          polls: response.polls ?? [],
        ));
      } else {
        emit(MdomPollsListErrorKomplat(
            actionType: ActionType.refresh,
            errorCode: response.errorCode,
            errorMessage: response.errorText));
      }
      // ignore: avoid_catches_without_on_clauses
    } catch (error, _) {
      emit(MdomPollsListError(actionType: ActionType.refresh, error: error));
    }
  }

  void _onMdomPollsListGetNotificationCount(
    MdomPollsListGetNotificationCount event,
    Emitter<MdomPollsListState> emit,
  ) async {
    emit(MdomPollsListLoading());

    try {
      final response = await dataManager.notifyListRequest(
        supplierId: event.supplierId,
        rowCount: const NotifyListRequestRowCount(
          value: 100,
          id: 0,
        ),
      );
      if (response.errorCode == 0) {
        _log('unread count - ${response.unreadCount}');

        emit(
          MdomPollsListLoaded(
            participantsCount: event.participantsCount,
            polls: event.polls,
            notificationsUnreadCount: response.unreadCount ?? 0,
          ),
        );
      } else {
        emit(
          MdomPollsListLoaded(
            participantsCount: state.participantsCount,
            polls: state.polls,
            notificationsUnreadCount: response.unreadCount ?? 0,
          ),
        );
      }
      // ignore: avoid_catches_without_on_clauses
    } catch (error, _) {
      emit(MdomPollsListError(actionType: ActionType.refresh, error: error));
    }
  }

  void _onMdomPollsListLoadMore(
    MdomPollsListLoadMore event,
    Emitter<MdomPollsListState> emit,
  ) async {
    emit(MdomPollsListLoading());

    try {
      final response = await dataManager.pollsListRequest(
          // topic: ,
          status: filters.status,
          stopDateFrom: filters.stopDateFrom,
          stopDateTo: filters.stopDateTo,
          supplierId: event.supplierId,
          count: event.count,
          lastPollId: event.lastPollId);
      if (response.errorCode == 0) {
        emit(MdomPollsListLoadedMore(polls: response.polls ?? []));
      } else {
        emit(MdomPollsListErrorKomplat(
            actionType: ActionType.loadMore,
            errorCode: response.errorCode,
            errorMessage: response.errorText));
      }
      // ignore: avoid_catches_without_on_clauses
    } catch (error, _) {
      emit(MdomPollsListError(actionType: ActionType.loadMore, error: error));
    }
  }
}
