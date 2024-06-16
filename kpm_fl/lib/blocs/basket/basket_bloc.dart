// ignore_for_file: avoid_void_async

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kpm_fl/data/data.dart';
import 'package:kpm_fl/models/models.dart';

part 'basket_event.dart';
part 'basket_state.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  final DataManager dataManager;

  BasketBloc({
    required this.dataManager
  }) : super(const BasketClosed()) {
    on<BasketEvent>(_onEvent);
  }

  var _payments = <BasketItemWrapper>[];
  bool get isBasketEmpty => _payments.isEmpty;

  String? get kioskReceipt => dataManager.kioskReceipt;
  String? get barcode => dataManager.barcode;

  void _onEvent(
    BasketEvent event,
    Emitter<BasketState> emit
  ) {
    if (event is BasketInit) return _onBasketInit(event, emit);
    if (event is BasketClose) return _onBasketClose(event, emit);
    if (event is BasketAddPayment) return _onBasketAddPayment(event, emit);
    if (event is BasketDeletePayment) return _onBasketDeletePayment(event, emit);
    if (event is BasketDeleteAllPayments) return _onBasketDeleteAllPayments(event, emit);
  }

  void _onBasketInit(
    BasketInit event,
    Emitter<BasketState> emit
  ) async {
    emit(BasketLoading());

    try {
      final response = await dataManager.openBasketRequest();
      if ((response.errorCode ?? 0) == 0) {
        dataManager
          ..paymentsCount = 0
          ..kioskReceipt = response.kioskReceipt
          ..barcode = response.barcode;

        emit(BasketOpened(
          payments: _payments,
          kioskReceipt: dataManager.kioskReceipt!,
          barcode: dataManager.barcode!
        ));
      } else {
        emit(BasketErrorKomplat(
          request: RequestType.openBasket,
          errorCode: response.errorCode,
          errorText: response.errorText,
        ));
      }
    // ignore: avoid_catches_without_on_clauses
    } catch(e, _) {
      emit(BasketError(
        error: e,
      ));
      emit(const BasketClosed());
    }
  }

  void _onBasketClose(
    BasketClose event,
    Emitter<BasketState> emit
  ) async {
    if (dataManager.barcode == null) return;
    emit(BasketLoading());

    try {
      final response = await dataManager.closeBasketRequest(
        barcode: dataManager.barcode!
      );
      if ((response.errorCode ?? 0) == 0) {
        emit(BasketClosed(
          kioskReceipt: kioskReceipt,
          barcode: barcode
        ));
        dataManager
          ..paymentsCount = 0
          ..kioskReceipt = null
          ..barcode = null;
        _payments.clear();
      } else {
        emit(BasketErrorKomplat(
          request: RequestType.closeBasket,
          errorCode: response.errorCode,
          errorText: response.errorText,
        ));
      }
    // ignore: avoid_catches_without_on_clauses
    } catch(e, _) {
      emit(BasketError(
        error: e,
      ));
      emit(BasketOpened(
        payments: _payments,
        kioskReceipt: dataManager.kioskReceipt!,
        barcode: dataManager.barcode!
      ));
    }
  }

  void _onBasketAddPayment(
    BasketAddPayment event,
    Emitter<BasketState> emit
  ) async {
    if (dataManager.barcode == null) return;
    emit(BasketLoading());

    _payments.add(event.item);

    emit(BasketOpened(
      payments: _payments,
      kioskReceipt: kioskReceipt!,
      barcode: barcode!
    ));
  }

  void _onBasketDeletePayment(
    BasketDeletePayment event,
    Emitter<BasketState> emit
  ) async {
    if (dataManager.barcode == null) return;
    emit(BasketLoading());

    try {
      final response = await dataManager.confirmRequest(
        service: event.item,
        isCanceled: true
      );
      if ((response.errorCode ?? 0) == 0) {
        _payments.removeWhere((e) => e.payment.paymentID == event.item.paymentID);
      } else {
        emit(BasketErrorKomplat(
          request: RequestType.closeBasket,
          errorCode: response.errorCode,
          errorText: response.errorText,
        ));
      }
    // ignore: avoid_catches_without_on_clauses
    } catch(e, _) {
      emit(BasketError(
        error: e,
      ));
    }

    emit(BasketOpened(
      payments: _payments,
      kioskReceipt: dataManager.kioskReceipt!,
      barcode: dataManager.barcode!
    ));
  }

  void _onBasketDeleteAllPayments(
    BasketDeleteAllPayments event,
    Emitter<BasketState> emit
  ) async {
    if (dataManager.barcode == null) return;
    emit(BasketLoading());

    final newPaymentsList = List<BasketItemWrapper>.from(_payments);

    for (final item in _payments) {
      try {
        final response = await dataManager.confirmRequest(
          service: item.payment,
          isCanceled: true
        );
        if ((response.errorCode ?? 0) == 0) {
          newPaymentsList.removeWhere((e) => e.payment.paymentID == item.payment.paymentID);
        } else {
          emit(BasketErrorKomplat(
            request: RequestType.closeBasket,
            errorCode: response.errorCode,
            errorText: response.errorText,
          ));
        }
      // ignore: avoid_catches_without_on_clauses
      } catch(e, _) {
        emit(BasketError(
          error: e,
        ));
      } 
    }
    _payments = newPaymentsList;
    emit(BasketOpened(
      payments: _payments,
      kioskReceipt: dataManager.kioskReceipt!,
      barcode: dataManager.barcode!
    ));
  }
}
