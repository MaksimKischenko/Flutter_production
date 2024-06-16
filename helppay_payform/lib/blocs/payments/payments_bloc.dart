// ignore_for_file: avoid_void_async

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:helppay_payform_app/data/data.dart';
import 'package:helppay_payform_app/models/models.dart';
import 'package:helppay_payform_app/utils/utils.dart';

part 'payments_event.dart';
part 'payments_state.dart';

class PaymentsBloc extends Bloc<PaymentsEvent, PaymentsState> {
  final DataManager dataManager;

  PaymentsBloc({
    required this.dataManager
  }) : super(const PaymentsInitial(
    maxAmount: 0,
    totalAmount: 0,
    remainingAmount: 0,
    payments: []
  )) {
    on<PaymentsEvent>(_onEvent);
  }

  double get totalAmount => dataManager.payments.fold<double>(0, (prev, item) => prev + item.amount);

  void _onEvent(
    PaymentsEvent event,
    Emitter<PaymentsState> emit
  ) {
    if (event is PaymentsInit) return _onPaymentsInit(event, emit);
    if (event is PaymentsDeletePayment) return _onPaymentsDeletePayment(event, emit);
    if (event is PaymentsUpdate) return _onPaymentsUpdate(event, emit);
  }

  void _onPaymentsInit(
    PaymentsInit event,
    Emitter<PaymentsState> emit
  ) {
    emit(PaymentsLoading());
    dataManager
      ..payments = event.payments
      ..maxAmount = event.maxAmount;
    emit(PaymentsInitial(
      maxAmount: dataManager.maxAmount,
      totalAmount: totalAmount,
      remainingAmount: (dataManager.maxAmount - totalAmount).fixedRound(),
      payments: dataManager.payments
    ));
  }

  void _onPaymentsDeletePayment(
    PaymentsDeletePayment event,
    Emitter<PaymentsState> emit
  ) async {
    emit(PaymentsLoading());

    try {
      final response = await dataManager.deletePaymentResponse(event.payment);

      if ((response.errorCode ?? 0) == 0) {
        dataManager.payments.removeWhere((e) => e.id == event.payment.id);
        emit(PaymentsDeletePaymentSuccess(event.payment.id));
      } else {
        emit(PaymentsErrorKomplat(
          request: RequestType.listPopular,
          errorCode: response.errorCode,
          errorText: response.errorText
        ));
      }
    // ignore: avoid_catches_without_on_clauses, empty_catches
    } catch (error, _) {
      emit(PaymentsError(error: error));
    }

    emit(PaymentsInitial(
      maxAmount: dataManager.maxAmount,
      totalAmount: dataManager.payments.fold(0, (prev, item) => prev + item.amount),
      remainingAmount: (dataManager.maxAmount - totalAmount).fixedRound(),
      payments: dataManager.payments
    ));
  }

  void _onPaymentsUpdate(
    PaymentsUpdate event,
    Emitter<PaymentsState> emit
  ) async {
    emit(PaymentsLoading());
    
    try {
      final response = await dataManager.paymentsRequest(dataManager.getPaymentsToken ?? '');
      if (response.error?.isEmpty ?? false) throw Exception(response.error);
      
      dataManager.payments = response.payments ?? [];
    // ignore: avoid_catches_without_on_clauses, empty_catches
    } catch (error, _) {
      
    }

    emit(PaymentsInitial(
      maxAmount: dataManager.maxAmount,
      totalAmount: dataManager.payments.fold(0, (prev, item) => prev + item.amount),
      remainingAmount: (dataManager.maxAmount - totalAmount).fixedRound(),
      payments: dataManager.payments
    ));
  }
}
