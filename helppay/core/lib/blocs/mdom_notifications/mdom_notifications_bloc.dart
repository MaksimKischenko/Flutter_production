import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helppay_core/config.dart';
import 'package:helppay_core/data/data.dart';

part 'mdom_notifications_event.dart';
part 'mdom_notifications_state.dart';

// void _log(dynamic message) =>
//     Logger.helpPayLog(message, name: 'mdom_notification_bloc');

class MdomNotificationsBloc
    extends Bloc<MdomNotificationsEvent, MdomNotificationsState> {
  final DataManager dataManager;
  final int supplierId;
  List<ResponseNotification> _notifications = [];
  int _lastNotificationIndicator = 0;

  MdomNotificationsBloc({required this.dataManager, required this.supplierId})
      : super(MdomNotificationsLoading()) {
    on<MdomNotificationsEvent>(_onEvent);
  }

  bool _firstLoaded = false;

  void _onEvent(
    MdomNotificationsEvent event,
    Emitter<MdomNotificationsState> emit,
  ) {
    if (event is MdomNotificationsInit) {
      return _onMdomNotificationsInit(event, emit);
    }
    if (event is MdomNotificationsCheckLoaded) {
      return _onMdomNotificationsCheckLoaded(event, emit);
    }
    if (event is MdomNotificationsReadAll) {
      return _onMdomNotificationsReadAll(event, emit);
    }
    if (event is MdomNotificationsLoadMore) {
      return _onMdomNotificationsLoadMore(event, emit);
    }
  }

  // ignore: avoid_void_async
  void _onMdomNotificationsInit(
    MdomNotificationsInit event,
    Emitter<MdomNotificationsState> emit,
  ) async {
    emit(MdomNotificationsLoading());

    try {
      final response = await dataManager.notifyListRequest(
        supplierId: supplierId,
        rowCount: NotifyListRequestRowCount(
          value: CoreConfig.notificationsListRequestLoadCount,
          id: event.notificationId == 0 ? 0 : event.notificationId,
        ),
      );
      _notifications = response.notification ?? [];
      if (_notifications.isNotEmpty) {
        _lastNotificationIndicator = _notifications.map((e) => e.id).reduce(
            (value, element) =>
                value > element ? value : element); //take max element
      }
      if (response.errorCode == 0) {
        _notifications.sort((a, b) => b.id.compareTo(a.id));

        emit(MdomNotificationsLoaded(notification: _notifications));
        _firstLoaded = true;
      } else {
        emit(
          MdomNotificationsErrorKomplat(
            errorCode: response.errorCode,
            errorMessage: response.errorText!,
          ),
        );
      }
      // ignore: avoid_catches_without_on_clauses
    } catch (error, _) {
      emit(MdomNotificationsError(error: error));
    }
  }

  // ignore: avoid_void_async
  void _onMdomNotificationsCheckLoaded(
    MdomNotificationsCheckLoaded event,
    Emitter<MdomNotificationsState> emit,
  ) async {
    if (!_firstLoaded) {
      emit(MdomNotificationsToggleRefresh());
    } else {
      if (state is MdomNotificationsLoaded) {
        final tempState = state;
        emit(MdomNotificationsLoading());
        emit(tempState);
      }
    }
  }

  // ignore: avoid_void_async
  void _onMdomNotificationsLoadMore(
    MdomNotificationsLoadMore event,
    Emitter<MdomNotificationsState> emit,
  ) async {
    try {
      final response = await dataManager.notifyListRequest(
        supplierId: supplierId,
        rowCount: NotifyListRequestRowCount(
            value: event.notificationListLength +
                CoreConfig.notificationsListRequestLoadCount,
            id: event.lastNotificationId),
      );
      if (response.errorCode == 0) {
        emit(MdomNotificationsLoadedMore(
            notifications: response.notification ?? []));
      } else {
        emit(
          MdomNotificationsErrorKomplat(
            errorCode: response.errorCode,
            errorMessage: response.errorText!,
          ),
        );
      }
      // ignore: avoid_catches_without_on_clauses
    } catch (error, _) {
      emit(MdomNotificationsError(error: error));
    }
  }

  // ignore: avoid_void_async
  void _onMdomNotificationsReadAll(
    MdomNotificationsReadAll event,
    Emitter<MdomNotificationsState> emit,
  ) async {
    try {
      final response = await dataManager.notifyReadRequest(
          lastNotificationIndicator: _lastNotificationIndicator); //mock data
      if (response.errorCode == 0) {
        emit(MdomNotificationsLoaded(
            notification:
                _notifications.map((e) => e.copyWith(status: 2)).toList()));
      } else {
        emit(
          MdomNotificationsErrorKomplat(
            errorCode: response.errorCode,
            errorMessage: response.errorText!,
          ),
        );
      }
      // ignore: avoid_catches_without_on_clauses
    } catch (error, _) {
      emit(MdomNotificationsError(error: error));
    }
  }
}
