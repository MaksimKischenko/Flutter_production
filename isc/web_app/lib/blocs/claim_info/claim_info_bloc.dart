// ignore_for_file: avoid_void_async

import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:isc_web_app/data/data.dart';
import 'package:isc_web_app/data/data_manager.dart';
import 'package:isc_web_app/injection_component.dart';
import 'package:isc_web_app/main.dart';
import 'package:isc_web_app/routing/routes.dart';
import 'package:isc_web_app/routing/routes.gr.dart';

part 'claim_info_event.dart';
part 'claim_info_state.dart';

class ClaimInfoBloc extends Bloc<ClaimInfoEvent, ClaimInfoState> {
  final DataManager dataManager;
  final int? id; 
  Claim? claim;


  ClaimInfoBloc({
    required this.id,
    required this.claim,
  }) : dataManager = InjectionComponent.getDependency<DataManager>(), super(ClaimInfoLoading()) {
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

    if(claim == null) {
      await getIt<Routes>().push(const ClaimsRoute());
    }

    final info = <String, dynamic>{
      'Код требования': claim?.id,
      'Номер счета': claim?.accNum,
      'Дата выставления': claim?.invoiceDate,
      'Срок оплаты': claim?.dueDate
    };

    final fio = claim?.fio ?? '';
    if (fio.isNotEmpty) info.putIfAbsent('ФИО', () => fio);

    if (claim?.productCharacter != null && (claim?.productCharacter?.isNotEmpty ?? false)) info.putIfAbsent('Описание', () => claim?.productCharacter);

    info
      ..putIfAbsent('Сумма', () => claim?.sum)
      ..putIfAbsent('Сумма оплаты', () => claim?.paymentSum)
      ..putIfAbsent('Статус', () => claim?.status.claimStatusName);

    emit(ClaimInfoInitial(
      info: info,
      //qrData: qrUrl,
    ));
  }
}
