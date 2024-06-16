import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bpc_nkfo/data/data.dart';
import 'package:bpc_nkfo/injection_component.dart';
import 'package:bpc_nkfo/models/models.dart';
import 'package:bpc_nkfo/utils/utils.dart';
import 'package:equatable/equatable.dart';

part 'claims_event.dart';
part 'claims_state.dart';

class ClaimsBloc extends Bloc<ClaimsEvent, ClaimsState> {
  final DataManager _dataManager;

  int get requestCount => 20;

  ClaimsBloc() : _dataManager = InjectionComponent.getDependency<DataManager>(), super(ClaimsInitial());

  @override
  Stream<ClaimsState> mapEventToState(
    ClaimsEvent event,
  ) async* {
    if (event is ClaimsLoad) {
      yield* _mapClaimsLoadToState(event);
    }
    if (event is ClaimsLoadMore) {
      yield* _mapClaimsLoadMoreToState(event);
    }
    if (event is ClaimsDeleteClaim) {
      yield* _mapClaimsDeleteClaimToState(event);
    }
    if (event is ClaimsNewClaim) {
      yield* _mapClaimsNewClaimToState(event);
    }
  }

  Stream<ClaimsState> _mapClaimsLoadToState(
    ClaimsLoad event
  ) async* {
    yield ClaimsLoading();

    _dataManager
      ..currentService = event.filter.service
      ..currentDateFrom = event.filter.dateFrom
      ..currentDateTo = event.filter.dateTo;

    if (event.filter.service != null) {
      try {
        final response = await _dataManager.claimsListRequest(
          code: event.filter.service?.code ?? 0,
          status: event.filter.claimsType,
          from: event.filter.dateFrom,
          to: event.filter.dateTo,
          accNum: event.filter.accNum,
          rowCount: RowCountClaims(
            evalue: requestCount
          )
        );
        if (response.errorCode == 0) {      
          yield ClaimsSuccessLoad(
            list: response.claims ?? []
          );
        } else {
          yield ClaimsErrorKomplat(
            actionType: ActionType.refresh,
            errorCode: response.errorCode,
            errorMessage: response.errorText
          );
        }
      // ignore: avoid_catches_without_on_clauses
      } catch (error, _) {
        yield ClaimsError(
          actionType: ActionType.refresh,
          error: error
        );
      }
    } else {
      yield const ClaimsError(
        actionType: ActionType.refresh,
        error: 'Нет услуг'
      );
    }
  }

  Stream<ClaimsState> _mapClaimsLoadMoreToState(
    ClaimsLoadMore event
  ) async* {
    yield ClaimsLoading();

    if (event.filter.service != null) {
      try {
        final response = await _dataManager.claimsListRequest(
          code: event.filter.service?.code ?? 0,
          status: event.filter.claimsType,
          from: event.filter.dateFrom,
          to: event.filter.dateTo,
          accNum: event.filter.accNum,
          rowCount: RowCountClaims(
            evalue: requestCount,
            claimId: event.lastClaimId
          )
        );
        if (response.errorCode == 0) {       
          yield ClaimsSuccessLoadMore(
            list: response.claims ?? []
          );
        } else {
          yield ClaimsErrorKomplat(
            actionType: ActionType.loadMore,
            errorCode: response.errorCode,
            errorMessage: response.errorText
          );
        }
      // ignore: avoid_catches_without_on_clauses
      } catch (error, _) {
        yield ClaimsError(
          actionType: ActionType.loadMore,
          error: error
        );
      }
    } else {
      yield const ClaimsError(
        actionType: ActionType.loadMore,
        error: 'Нет услуг'
      );
    }
  }

  Stream<ClaimsState> _mapClaimsDeleteClaimToState(
    ClaimsDeleteClaim event
  ) async* {
    yield ClaimsLoading();

    try {
      final response = await _dataManager.deleteClaimRequest(event.id);
      if (response.errorCode == 0) {       
        yield ClaimsSuccessDelete(event.id);
      } else {
        yield ClaimsErrorKomplat(
          actionType: ActionType.loadMore,
          errorCode: response.errorCode,
          errorMessage: response.errorText
        );
      }
    // ignore: avoid_catches_without_on_clauses
    } catch (error, _) {
      yield ClaimsError(
        actionType: ActionType.loadMore,
        error: error
      );
    }
  }

  Stream<ClaimsState> _mapClaimsNewClaimToState(
    ClaimsNewClaim event
  ) async* {
    yield ClaimsLoading();

    try {
      final data = event.data;
      final claim = AddClaimRequest(
        serviceCode: data.selectedService?.code ?? 0,
        accNum: data.accNum,
        sum: AddClaimRequestSum(evalue: data.sum!),
        dueDate: data.dueDate!.toStringFormattedWithTime(),
        fio: Fio(
          firstName: data.firstName,
          surname: data.surname,
          patronic: data.patronic
        ),
        address: Address(evalue: data.address),
        productCharacter: data.description,
        typeNotification: data.typeNotification,
        email: data.email,
        smsPhone: data.phone,
        device: event.data.devices != null || (event.data.devices?.isNotEmpty ?? false)
            ? Devices(
              count: event.data.devices?.length ?? 0,
              lastReg: event.data.devices?.asMap().map((index, device) => MapEntry(index, device.copy(idx: index))).values.toList()
            )
            : null
      );

      final response = await _dataManager.addClaimRequest(claim);
      if (response.errorCode == 0) {
        final accNum = (data.selectedService!.needGenerateAccNum ?? 0) == 1 ? response.claimId.accNum : data.accNum;
        final qrUrl = QrErip.generate(data.selectedService?.code ?? 0, accNum!, data.sum ?? 0.0);   
        
        yield ClaimsSuccessCreate(qrUrl);
      } else {
        yield ClaimsErrorKomplat(
          actionType: null,
          errorCode: response.errorCode,
          errorMessage: response.errorText
        );
      }
    // ignore: avoid_catches_without_on_clauses
    } catch (error, _) {
      yield ClaimsError(
        actionType: null,
        error: error
      );
    }
  }
}
