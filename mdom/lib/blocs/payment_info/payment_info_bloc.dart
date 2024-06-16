// ignore_for_file: avoid_void_async

import 'package:bloc/bloc.dart';
import 'package:bpc/data/data.dart';
import 'package:bpc/models/models.dart';
import 'package:equatable/equatable.dart';

part 'payment_info_event.dart';
part 'payment_info_state.dart';

class PaymentInfoBloc extends Bloc<PaymentInfoEvent, PaymentInfoState> {
  final Payment payment;

  PaymentInfoBloc({
    required this.payment,
  }) : super(PaymentInfoLoading()) {
    on<PaymentInfoEvent>(_onEvent);
  }

  void _onEvent(
    PaymentInfoEvent event,
    Emitter<PaymentInfoState> emit,
  ) {
    if (event is PaymentInfoInit) return _onPaymentInfoInit(event, emit);
  }

  void _onPaymentInfoInit(
    PaymentInfoInit event,
    Emitter<PaymentInfoState> emit,
  ) async {
    emit(PaymentInfoLoading());

    final info = <String, dynamic>{};

    if (payment.status == PaymentStatus.paid) info.putIfAbsent('Дата перечисления', () => payment.memDate);
    if (payment.status == PaymentStatus.paid) info.putIfAbsent('№ платежного документа', () => payment.memNumber);
    info
      ..putIfAbsent('Код платежа', () => payment.id)
      ..putIfAbsent('Дата платежа', () => payment.paymentDate)
      ..putIfAbsent('№ счета плательщика', () => payment.accNum)
      ..putIfAbsent('Описание в требовании', () => payment.productCharacter)
      ..putIfAbsent('Сумма платежа', () => payment.paymentSum)
      ..putIfAbsent('Статус', () => payment.status.name)
      ..putIfAbsent('Код требования', () => payment.claimId);

    emit(PaymentInfoInitial(
      info: info
    ));
  }
}
