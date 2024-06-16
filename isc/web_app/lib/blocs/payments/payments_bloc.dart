import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:isc_web_app/config.dart';
import 'package:isc_web_app/data/data.dart';
import 'package:isc_web_app/data/data_manager.dart';
import 'package:isc_web_app/models/models.dart';
import 'package:isc_web_app/utils/date_helper.dart';

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
  List<PaymentISC> payments = [];

  void _onEvent(
    PaymentsEvent event,
    Emitter<PaymentsState> emit,
  ) {
    if (event is PaymentsLoad) return _onPaymentsLoad(event, emit);
    if (event is PaymentsLoadMore) return _onPaymentsLoadMore(event, emit);
    if (event is PaymentsSort) return _onPaymentsSort(event, emit);    
  }


  void _onPaymentsLoad(
    PaymentsLoad event,
    Emitter<PaymentsState> emit,
  ) async {
    emit(PaymentsLoading());

    if (event.filter == null) {
      filter = PaymentsFilterData.empty(
        serviceCode: 101 
      );
    } else {
      filter = event.filter!.copyWith(
        serviceCode: 101,
      );
    }

    if (filter.serviceCode != null) {
      try {
        final response = await dataManager.paymentListRequest(
          from: filter.dateFrom,
          to: filter.dateTo,
          status: filter.status,        
          accNum: filter.accNum,
          dateType: filter.dateType,          
          claimId: filter.claimId,
          count: AppConfig.paymentsListRequestLoadCount
        );
        if (response.errorCode == 0) {    
          emit(PaymentsSuccessLoad(
            list: response.payments ?? []
          ));
          payments = response.payments ?? []; 

        } else {
          emit(PaymentsErrorKomplat(
            actionType: ActionType.refresh,
            errorCode: response.errorCode,
            errorMessage: response.errorText
          ));
        }
      } catch (error, _) {
        emit(PaymentsError(
          actionType: ActionType.refresh,
          error: error
        ));
      }
    } else {
      emit(const PaymentsError(
        actionType: ActionType.refresh,
        error: 'Нет услуг'
      ));
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
        from: filter.dateFrom,
        to: filter.dateTo,
        accNum: filter.accNum,
        status: filter.status,          
        claimId: filter.claimId,
        dateType: filter.dateType,
        count: AppConfig.paymentsListRequestLoadCount,        
        lastPaymentId: event.lastPaymentId,
      );
      if (response.errorCode == 0) {       
        emit(PaymentsSuccessLoadMore(
          list: response.payments ?? [],
          isLoadMoreAvailable: (response.payments?.length ?? 0) >= AppConfig.paymentsListRequestLoadCount          

        ));
      } else {
        emit(PaymentsErrorKomplat(
          actionType: ActionType.loadMore,
          errorCode: response.errorCode,
          errorMessage: response.errorText
        ));
      }
    } catch (error, _) {
      emit(PaymentsError(
        actionType: ActionType.loadMore,
        error: error
      ));
    }

    emit(PaymentsInitial(
      filter: filter,
    ));
  }

  void _onPaymentsSort(
    PaymentsSort event,
    Emitter<PaymentsState> emit,   
  ) async {
    
    emit(PaymentsLoading());

    sortValues(event.ascending, event.sortIndex);

    emit(PaymentsSuccessLoad(
      list: payments
    ));
    
    emit(PaymentsInitial(
      filter: filter,
    ));    
  }

    void sortValues(bool ascending, int sortIndex) {
      switch (sortIndex) {
        case 1:
          ascending?
          payments.sort((b, a) => (a.accNum ?? '').compareTo(b.accNum ?? '')):
          payments.sort((a, b) => (a.accNum ?? '').compareTo(b.accNum ?? ''));
          break;
        case 2:
          ascending?
          payments.sort((b, a) => (a.memNumber).compareTo(b.memNumber)):
          payments.sort((a, b) => (a.memNumber).compareTo(b.memNumber));
          break;
        case 3:
          ascending?
          payments.sort((b, a) => (a.memDate.toDateFormatted()).compareTo(b.memDate.toDateFormatted())):
          payments.sort((a, b) => (a.memDate.toDateFormatted()).compareTo(b.memDate.toDateFormatted()));
          break;  
        case 4:
          ascending?
          payments.sort((b, a) => (a.fio ?? '').compareTo(b.fio ?? '')):
          payments.sort((a, b) => (a.fio ?? '').compareTo(b.fio ?? ''));
          break;         
        case 5:
          ascending?
          payments.sort((b, a) => (a.id).compareTo(b.id)):
          payments.sort((a, b) => (a.id).compareTo(b.id));
          break;
        case 6:
          ascending?
          payments.sort((b, a) => (a.paymentDate.toDateFormatted()).compareTo(b.paymentDate.toDateFormatted())):
          payments.sort((a, b) => (a.paymentDate.toDateFormatted()).compareTo(b.paymentDate.toDateFormatted()));
          break;   
        case 7:
          ascending?
          payments.sort((b, a) => (a.paymentSum).compareTo(b.paymentSum)):
          payments.sort((a, b) => (a.paymentSum).compareTo(b.paymentSum));
          break;                   
        case 8:
          ascending?
          payments.sort((b, a) => (a.claimId ?? 0).compareTo(b.claimId ?? 0)):
          payments.sort((a, b) => (a.claimId ?? 0).compareTo(b.claimId ?? 0));
          break;  
        case 9:
          ascending?
          payments.sort((b, a) => (a.status.paymentStatusName).compareTo(b.status.paymentStatusName)):
          payments.sort((a, b) => (a.status.paymentStatusName).compareTo(b.status.paymentStatusName));
          break;                                                                                                                                                                                                                                                  
      }
  }
}
