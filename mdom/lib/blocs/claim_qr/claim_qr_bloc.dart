// ignore_for_file: avoid_void_async

import 'package:bloc/bloc.dart';
import 'package:bpc/data/data.dart';
import 'package:bpc/models/models.dart';
import 'package:bpc/utils/utils.dart';
import 'package:dartx/dartx.dart';
import 'package:equatable/equatable.dart';

part 'claim_qr_event.dart';
part 'claim_qr_state.dart';

class ClaimQrBloc extends Bloc<ClaimQrEvent, ClaimQrState> {
  final DataManager dataManager;

  ClaimQrBloc({
    required this.dataManager,
  }) : super(ClaimQrInitial()) {
    on<ClaimQrEvent>(_onEvent);
  }

  void _onEvent(
    ClaimQrEvent event,
    Emitter<ClaimQrState> emit,
  ) {
    if (event is ClaimQrCheck) return _onClaimQrCheck(event, emit);
  }

  void _onClaimQrCheck(
    ClaimQrCheck event,
    Emitter<ClaimQrState> emit,
  ) async {
    emit(ClaimQrLoading());

    try {
      final data = QrErip.parse(event.qrData);

      if (data.accNum != null && data.accNum!.isNotEmpty) {
        final response = await dataManager.claimsListRequest(
          service: Service(
            code: data.eripCode.toInt(),
            codeRasvikom: 0,
            name: ''
          ),
          //// полностью оплачено
          // status: 2,
          status: ClaimStatus.all,
          from: event.from,
          to: DateTime.now(),
          accNum: data.accNum,
        );
        if (response.errorCode == 0) {    
          final claim = response.claims?.firstOrNull;
          if (claim != null) {
            emit(ClaimQrSuccessChecked(claim));
          } else {
            throw ClaimQrNotFoundException();
          }
        } else {
          emit(ClaimQrErrorKomplat(
            errorCode: response.errorCode,
            errorMessage: response.errorText
          ));
        }
      } else {
        throw ClaimQrMissingAccNumException();
      }
    // ignore: avoid_catches_without_on_clauses
    } catch(e) {
      emit(ClaimQrError(
        error: e
      ));
    }
  }
}
