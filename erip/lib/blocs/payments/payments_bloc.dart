import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bpc_nkfo/data/data.dart';
import 'package:bpc_nkfo/injection_component.dart';
import 'package:bpc_nkfo/models/models.dart';
import 'package:equatable/equatable.dart';

part 'payments_event.dart';
part 'payments_state.dart';

class PaymentsBloc extends Bloc<PaymentsEvent, PaymentsState> {
  // need to safe filters
  final bool savefilters;
  final DataManager _dataManager;

  int get requestCount => 20;

  PaymentsBloc({
    this.savefilters = true
  }) : _dataManager = InjectionComponent.getDependency<DataManager>(), super(PaymentsInitial());

  @override
  Stream<PaymentsState> mapEventToState(
    PaymentsEvent event,
  ) async* {
    if (event is PaymentsLoad) {
      yield* _mapPaymentsLoadToState(event);
    }
    if (event is PaymentsLoadMore) {
      yield* _mapPaymentsLoadMoreToState(event);
    }
  }

  Stream<PaymentsState> _mapPaymentsLoadToState(
    PaymentsLoad event
  ) async* {
    yield PaymentsLoading();

    if (savefilters) {
      _dataManager
      ..currentService = event.filter.service
      ..currentDateFrom = event.filter.dateFrom
      ..currentDateTo = event.filter.dateTo;
    }

    if (event.filter.service != null) {
      try {
        final response = await _dataManager.paymentListRequest(
          serviceCode: event.filter.service?.code ?? 0,
          dateType: event.filter.dateType,
          from: event.filter.dateFrom,
          to: event.filter.dateTo,
          accNum: event.filter.accNum,
          status: event.filter.paymentsType,
          claimId: event.filter.claimId,
          rowCount: RowCountPayments(
            evalue: requestCount
          )
        );
        if (response.errorCode == 0) {      
          yield PaymentsSuccessLoad(
            list: response.payments ?? []
          );
        } else {
          yield PaymentsErrorKomplat(
            actionType: ActionType.refresh,
            errorCode: response.errorCode,
            errorMessage: response.errorText
          );
        }
      // ignore: avoid_catches_without_on_clauses
      } catch (error, _) {
        yield PaymentsError(
          actionType: ActionType.refresh,
          error: error
        );
      }
    } else {
      yield const PaymentsError(
        actionType: ActionType.refresh,
        error: 'Нет услуг'
      );
    }
  }

  Stream<PaymentsState> _mapPaymentsLoadMoreToState(
    PaymentsLoadMore event
  ) async* {
    yield PaymentsLoading();

    if (event.filter.service != null) {
      try {
        final response = await _dataManager.paymentListRequest(
          serviceCode: event.filter.service?.code ?? 0,
          dateType: event.filter.dateType,
          from: event.filter.dateFrom,
          to: event.filter.dateTo,
          accNum: event.filter.accNum,
          status: event.filter.paymentsType,
          claimId: event.filter.claimId,
          rowCount: RowCountPayments(
            evalue: requestCount,
            paymentId: event.lastPaymentId
          )
        );
        if (response.errorCode == 0) {       
          yield PaymentsSuccessLoadMore(
            list: response.payments ?? []
          );
        } else {
          yield PaymentsErrorKomplat(
            actionType: ActionType.loadMore,
            errorCode: response.errorCode,
            errorMessage: response.errorText
          );
        }
      // ignore: avoid_catches_without_on_clauses
      } catch (error, _) {
        yield PaymentsError(
          actionType: ActionType.loadMore,
          error: error
        );
      }
    } else {
      yield const PaymentsError(
        actionType: ActionType.loadMore,
        error: 'Нет услуг'
      );
    }
  }
}
