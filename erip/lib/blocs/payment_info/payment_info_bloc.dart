import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bpc_nkfo/data/data.dart';
import 'package:equatable/equatable.dart';

part 'payment_info_event.dart';
part 'payment_info_state.dart';

class PaymentInfoBloc extends Bloc<PaymentInfoEvent, PaymentInfoState> {
  final Payment payment;

  PaymentInfoBloc({
    required this.payment
  }) : super(PaymentInfoLoading());

  @override
  Stream<PaymentInfoState> mapEventToState(
    PaymentInfoEvent event,
  ) async* {
    if (event is PaymentInfoInit) {
      yield* _mapPaymentInfoInitToState(event);
    }
  }

  Stream<PaymentInfoState> _mapPaymentInfoInitToState(
    PaymentInfoInit event
  ) async* {
    yield PaymentInfoLoading();

    final info = <String, dynamic>{};

    if (payment.paymentStatus == 2) info.putIfAbsent('Дата перечисления', () => payment.memDate);
    if (payment.paymentStatus == 2) info.putIfAbsent('№ платежного документа', () => payment.memNumber);
    info
      ..putIfAbsent('Код платежа', () => payment.id)
      ..putIfAbsent('Дата платежа', () => payment.paymentDate)
      ..putIfAbsent('№ счета плательщика', () => payment.accNum)
      ..putIfAbsent('Описание в требовании', () => payment.productCharacter)
      ..putIfAbsent('Сумма платежа', () => payment.paymentSum)
      ..putIfAbsent('Статус', () => payment.statusText)
      ..putIfAbsent('Код требования', () => payment.claimId);

    yield PaymentInfoInitial(
      info: info
    );
  }
}
