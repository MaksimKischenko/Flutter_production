import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bpc_nkfo/data/data.dart';
import 'package:bpc_nkfo/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:kotlin_flavor/scope_functions.dart';

part 'claim_info_event.dart';
part 'claim_info_state.dart';

class ClaimInfoBloc extends Bloc<ClaimInfoEvent, ClaimInfoState> {
  final Claim claim;
  final Service service;

  ClaimInfoBloc({
    required this.claim,
    required this.service
  }) : super(ClaimInfoLoading());

  @override
  Stream<ClaimInfoState> mapEventToState(
    ClaimInfoEvent event,
  ) async* {
    if (event is ClaimInfoInit) {
      yield* _mapClaimInfoInitToState(event);
    }
  }

  Stream<ClaimInfoState> _mapClaimInfoInitToState(
    ClaimInfoInit event
  ) async* {
    yield ClaimInfoLoading();

    final qrUrl = QrErip.generate(service.code ?? 0, claim.accNum, (claim.sum - claim.paymentSum).roundFixed());
    // print(qrUrl);

    final info = <String, dynamic>{
      'Код требования': claim.id,
      'Номер счета': claim.accNum,
      'Дата выставления': claim.invoiceDate,
      'Срок оплаты': claim.dueDate
    };

    var fio = claim.fio.surname ?? '';
    claim.fio.firstName?.let((it) => fio += ' $it');
    claim.fio.patronic?.let((it) => fio += ' $it');
    if (fio.isNotEmpty) info.putIfAbsent('ФИО', () => fio);

    if (claim.productCharacter != null && (claim.productCharacter?.isNotEmpty ?? false)) info.putIfAbsent('Описание', () => claim.productCharacter);

    info
      ..putIfAbsent('Сумма', () => claim.sum)
      ..putIfAbsent('Сумма оплаты', () => claim.paymentSum)
      ..putIfAbsent('Статус', () => claim.statusText);

    yield ClaimInfoInitial(
      devices: claim.device?.lastReg ?? [],
      info: info,
      qrData: qrUrl,
      serviceName: service.name
    );
  }
}
