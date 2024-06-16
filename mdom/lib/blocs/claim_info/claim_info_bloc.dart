// ignore_for_file: avoid_void_async

import 'package:bloc/bloc.dart';
import 'package:bpc/data/data.dart';
import 'package:bpc/models/models.dart';
import 'package:bpc/utils/utils.dart';
import 'package:equatable/equatable.dart';

part 'claim_info_event.dart';
part 'claim_info_state.dart';

class ClaimInfoBloc extends Bloc<ClaimInfoEvent, ClaimInfoState> {
  final Claim claim;
  final Service service;

  ClaimInfoBloc({
    required this.claim,
    required this.service,
  }) : super(ClaimInfoLoading()) {
    on<ClaimInfoEvent>(_onEvent);
  }

  void _onEvent(
    ClaimInfoEvent event,
    Emitter<ClaimInfoState> emit,
  ) {
    if (event is ClaimInfoInit) return _onClaimInfoInit(event, emit);
  }

  void _onClaimInfoInit(
    ClaimInfoInit event,
    Emitter<ClaimInfoState> emit,
  ) async {
    emit(ClaimInfoLoading());

    final qrUrl = QrErip.generate(service.code, claim.accNum, (claim.sum - claim.paymentSum).roundFixed());
    // print(qrUrl);

    final info = <String, dynamic>{
      'Код требования': claim.id,
      'Номер счета': claim.accNum,
      'Дата выставления': claim.invoiceDate,
      'Срок оплаты': claim.dueDate
    };

    var fio = claim.fio.surname ?? '';
    if (claim.fio.firstName != null) {
      fio += '${fio.isEmpty ? "" : " "}${claim.fio.firstName}';
    }
    if (claim.fio.patronic != null) {
      fio += '${fio.isEmpty ? "" : " "}${claim.fio.patronic}';
    }
    if (fio.isNotEmpty) info.putIfAbsent('ФИО', () => fio);

    if (claim.productCharacter != null && (claim.productCharacter?.isNotEmpty ?? false)) info.putIfAbsent('Описание', () => claim.productCharacter);

    info
      ..putIfAbsent('Сумма', () => claim.sum)
      ..putIfAbsent('Сумма оплаты', () => claim.paymentSum)
      ..putIfAbsent('Статус', () => claim.status.name);

    emit(ClaimInfoInitial(
      devices: claim.device?.lastReg ?? [],
      info: info,
      qrData: qrUrl,
      serviceName: service.name
    ));
  }
}
