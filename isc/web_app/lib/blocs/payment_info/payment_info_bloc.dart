// ignore_for_file: avoid_void_async

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:isc_web_app/data/data.dart';
import 'package:isc_web_app/models/models.dart';

part 'payment_info_event.dart';
part 'payment_info_state.dart';

class PaymentInfoBloc extends Bloc<PaymentInfoEvent, PaymentInfoState> {
  final PaymentISC? payment;

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

    if (payment?.status == PaymentStatus.paid) info.putIfAbsent('Дата перечисления', () => payment?.memDate);
    if (payment?.status == PaymentStatus.paid) info.putIfAbsent('№ платежного документа', () => payment?.memNumber);
    info
      ..putIfAbsent('Код платежа', () => payment?.id)
      ..putIfAbsent('Дата платежа', () => payment?.paymentDate)
      ..putIfAbsent('№ счета плательщика', () => payment?.accNum)
      ..putIfAbsent('Сумма платежа', () => payment?.paymentSum)
      ..putIfAbsent('Статус', () => payment?.status.paymentStatusName)
      ..putIfAbsent('Код требования', () => payment?.claimId);


    final bankCode = payment?.bankCode ?? ''; 
    final productCharacter = payment?.productCharacter ?? ''; 
    final fio = payment?.fio ?? '';
    final adress = payment?.address ?? ''; 

    if (productCharacter.isNotEmpty) info.putIfAbsent('Описание в требовании', () => productCharacter);
    if (bankCode.isNotEmpty) info.putIfAbsent('Код банка', () => bankCode);    
    if (fio.isNotEmpty) info.putIfAbsent('ФИО', () => fio);
    if (adress.isNotEmpty) info.putIfAbsent('Адресс', () => adress);    

    emit(PaymentInfoInitial(
      info: info
    ));
  }
}
