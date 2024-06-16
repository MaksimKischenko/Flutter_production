import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bpc_nkfo/data/data.dart';
import 'package:bpc_nkfo/injection_component.dart';
import 'package:bpc_nkfo/utils/utils.dart';
import 'package:dartx/dartx.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

part 'claim_qr_event.dart';
part 'claim_qr_state.dart';

class ClaimQrNotFoundException implements Exception {
  final String cause = 'Требований не найдено';
}
class ClaimQrMissingAccNumException implements Exception {
  final String cause = 'Отсутствует лицевой счет';
}

class ClaimQrBloc extends Bloc<ClaimQrEvent, ClaimQrState> {
  final DataManager _dataManager;

  ClaimQrBloc() : _dataManager = InjectionComponent.getDependency<DataManager>(), super(ClaimQrInitial());

  @override
  Stream<ClaimQrState> mapEventToState(
    ClaimQrEvent event,
  ) async* {
    if (event is ClaimQrCheck) {
      yield* _mapClaimQrCheckToState(event);
    }
  }

  Stream<ClaimQrState> _mapClaimQrCheckToState(
    ClaimQrCheck event
  ) async* {
    yield ClaimQrLoading();

    try {
      final data = QrErip.parse(event.qrData);

      if (data.accNum != null && data.accNum!.isNotEmpty) {
        final dateFormat = DateFormat('dd.MM.yyyy');
        final response = await _dataManager.claimsListRequest(
          code: data.eripCode.toInt(),
          //// полностью оплачено
          // status: 2,
          from: dateFormat.format(event.from),
          to: dateFormat.format(DateTime.now()),
          accNum: data.accNum,
        );
        if (response.errorCode == 0) {    
          final claim = response.claims?.firstOrNull;
          if (claim != null) {
            yield ClaimQrSuccessChecked(claim);
          } else {
            throw ClaimQrNotFoundException();
          }
        } else {
          yield ClaimQrErrorKomplat(
            errorCode: response.errorCode,
            errorMessage: response.errorText
          );
        }
      } else {
        throw ClaimQrMissingAccNumException();
      }
    // ignore: avoid_catches_without_on_clauses
    } catch(e) {
      yield ClaimQrError(
        error: e
      );
    }
  }
}
