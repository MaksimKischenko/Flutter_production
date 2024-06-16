// ignore_for_file: avoid_void_async

import 'package:bloc/bloc.dart';
import 'package:bpc/data/data.dart';
import 'package:bpc/models/models.dart';
import 'package:bpc/utils/utils.dart';
import 'package:dartx/dartx.dart';
import 'package:equatable/equatable.dart';

part 'new_claim_event.dart';
part 'new_claim_state.dart';

class NewClaimBloc extends Bloc<NewClaimEvent, NewClaimState> {
  final DataManager dataManager;

  NewClaimBloc({
    required this.dataManager,
  }) : super(NewClaimInitial()) {
    on<NewClaimEvent>(_onEvent);
  }

  void _onEvent(
    NewClaimEvent event,
    Emitter<NewClaimState> emit,
  ) {
    if (event is NewClaimProceed) return _onNewClaimProceed(event, emit);
  }

  void _onNewClaimProceed(
    NewClaimProceed event,
    Emitter<NewClaimState> emit,
  ) async {
    emit(NewClaimLoading());

    try {
      final data = event.data;
      final claim = AddClaimRequest(
          serviceCode: data.selectedService!.code,
          accNum: data.accNum,
          sum: AddClaimRequestSum(evalue: data.sum!),
          dueDate: data.dueDate!.toStringFormattedWithTime(),
          fio: Fio(
              firstName: data.firstName,
              surname: data.surname,
              patronic: data.patronic),
          address: Address(evalue: data.address),
          productCharacter: data.description,
          typeNotification: data.typeNotification,
          email: data.email,
          smsPhone: data.phone,
          device: event.data.devices != null ||
                  (event.data.devices?.isNotEmpty ?? false)
              ? Devices(
                  count: event.data.devices?.length ?? 0,
                  lastReg: event.data.devices
                      ?.asMap()
                      .map((index, device) =>
                          MapEntry(index, device.copy(idx: index)))
                      .values
                      .toList())
              : null);

      final response = await dataManager.addClaimRequest(claim);
      if (response.errorCode == 0) {
        Claim? claim;
        try {
          final newClaimResponse = await dataManager.claimsListRequest(
              service: event.data.selectedService!,
              status: ClaimStatus.all,
              from: DateTime.now(),
              to: DateTime.now(),
              claimId: response.claimId.evalue);
          claim = newClaimResponse.claims?.firstOrNull;
          // ignore: avoid_catches_without_on_clauses, empty_catches
        } catch (error) {}
        final accNum = (data.selectedService!.needGenerateAccNum ?? 0) == 1
            ? response.claimId.accNum
            : data.accNum;
        final qrUrl = QrErip.generate(
            data.selectedService!.code, accNum!, data.sum ?? 0.0);

        emit(NewClaimSuccessCreate(
          service: event.data.selectedService!,
          claim: claim,
          qrUrl: qrUrl,
        ));
      } else {
        emit(NewClaimErrorKomplat(
            errorCode: response.errorCode, errorMessage: response.errorText));
      }
      // ignore: avoid_catches_without_on_clauses
    } catch (error) {
      emit(NewClaimError(error: error));
    }
  }
}
