// ignore_for_file: avoid_void_async

import 'package:bloc/bloc.dart';
import 'package:bpc/data/data.dart';
import 'package:bpc/models/models.dart';
import 'package:equatable/equatable.dart';

part 'payments_event.dart';
part 'payments_state.dart';

class PaymentsBloc extends Bloc<PaymentsEvent, PaymentsState> {
  final DataManager dataManager;

  PaymentsBloc({
    required this.dataManager,
  }) : super(PaymentsInitial(
          filter: PaymentsFilterData.empty(),
        )) {
    on<PaymentsEvent>(_onEvent);
  }

  late PaymentsFilterData filter;

  void _onEvent(
    PaymentsEvent event,
    Emitter<PaymentsState> emit,
  ) {
    if (event is PaymentsLoad) return _onPaymentsLoad(event, emit);
    if (event is PaymentsLoadMore) return _onPaymentsLoadMore(event, emit);
  }

  void _onPaymentsLoad(
    PaymentsLoad event,
    Emitter<PaymentsState> emit,
  ) async {
    emit(PaymentsLoading());

    if (event.filter == null) {
      filter = PaymentsFilterData.empty(
        service: dataManager.servicesList.first,
      );
    } else {
      filter = event.filter!;
    }

    if (filter.service != null) {
      try {
        final response = await dataManager.paymentListRequest(
          service: filter.service!,
          status: filter.status,
          dateType: filter.dateType,
          from: filter.dateFrom,
          to: filter.dateTo,
          accNum: filter.accNum,
          claimId: filter.claimId,
        );
        if (response.errorCode == 0) {
          emit(PaymentsSuccessLoad(list: response.payments ?? []));
        } else {
          emit(PaymentsErrorKomplat(
              actionType: ActionType.refresh,
              errorCode: response.errorCode,
              errorMessage: response.errorText));
        }
        // ignore: avoid_catches_without_on_clauses
      } catch (error) {
        emit(PaymentsError(actionType: ActionType.refresh, error: error));
      }
    } else {
      emit(const PaymentsError(
          actionType: ActionType.refresh, error: 'Нет услуг'));
    }

    emit(PaymentsInitial(
      filter: filter,
    ));
  }

  void _onPaymentsLoadMore(
    PaymentsLoadMore event,
    Emitter<PaymentsState> emit,
  ) async {
    emit(PaymentsLoading());

    try {
      final response = await dataManager.paymentListRequest(
        service: filter.service!,
        status: filter.status,
        dateType: filter.dateType,
        from: filter.dateFrom,
        to: filter.dateTo,
        accNum: filter.accNum,
        claimId: filter.claimId,
        lastPaymentId: event.lastPaymentId,
      );
      if (response.errorCode == 0) {
        emit(PaymentsSuccessLoadMore(list: response.payments ?? []));
      } else {
        emit(PaymentsErrorKomplat(
            actionType: ActionType.loadMore,
            errorCode: response.errorCode,
            errorMessage: response.errorText));
      }
      // ignore: avoid_catches_without_on_clauses
    } catch (error) {
      emit(PaymentsError(actionType: ActionType.loadMore, error: error));
    }

    emit(PaymentsInitial(
      filter: filter,
    ));
  }
}
