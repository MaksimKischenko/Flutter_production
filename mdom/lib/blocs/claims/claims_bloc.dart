// ignore_for_file: avoid_void_async

import 'package:bloc/bloc.dart';
import 'package:bpc/data/data.dart';
import 'package:bpc/models/models.dart';
import 'package:bpc/utils/utils.dart';
import 'package:equatable/equatable.dart';

part 'claims_event.dart';
part 'claims_state.dart';

class ClaimsBloc extends Bloc<ClaimsEvent, ClaimsState> {
  final DataManager dataManager;

  ClaimsBloc({
    required this.dataManager,
  }) : super(ClaimsInitial(
          filter: ClaimsFilterData.empty(),
        )) {
    on<ClaimsEvent>(_onEvent);
  }

  late ClaimsFilterData filter;

  void _onEvent(
    ClaimsEvent event,
    Emitter<ClaimsState> emit,
  ) {
    if (event is ClaimsLoad) return _onClaimsLoad(event, emit);
    if (event is ClaimsLoadMore) return _onClaimsLoadMore(event, emit);
    if (event is ClaimsDeleteClaim) return _onClaimsDeleteClaim(event, emit);
    if (event is ClaimsNewClaimIncome)
      return _onClaimsNewClaimIncome(event, emit);
  }

  void _onClaimsLoad(
    ClaimsLoad event,
    Emitter<ClaimsState> emit,
  ) async {
    emit(ClaimsLoading());

    if (event.filter == null) {
      filter = ClaimsFilterData.empty(
        service: dataManager.servicesList.first,
      );
    } else {
      filter = event.filter!;
    }

    if (filter.service != null) {
      try {
        final response = await dataManager.claimsListRequest(
          service: filter.service!,
          status: filter.status,
          from: filter.dateFrom,
          to: filter.dateTo,
          accNum: filter.accNum,
        );
        if (response.errorCode == 0) {
          emit(ClaimsSuccessLoad(list: response.claims ?? []));
        } else {
          emit(ClaimsErrorKomplat(
              actionType: ActionType.refresh,
              errorCode: response.errorCode,
              errorMessage: response.errorText));
        }
        // ignore: avoid_catches_without_on_clauses
      } catch (error) {
        emit(ClaimsError(actionType: ActionType.refresh, error: error));
      }
    } else {
      emit(const ClaimsError(
          actionType: ActionType.refresh, error: 'Нет услуг'));
    }

    emit(ClaimsInitial(
      filter: filter,
    ));
  }

  void _onClaimsLoadMore(
    ClaimsLoadMore event,
    Emitter<ClaimsState> emit,
  ) async {
    emit(ClaimsLoading());

    try {
      final response = await dataManager.claimsListRequest(
        service: filter.service!,
        status: filter.status,
        from: filter.dateFrom,
        to: filter.dateTo,
        accNum: filter.accNum,
        lastClaimId: event.lastClaimId,
      );
      if (response.errorCode == 0) {
        emit(ClaimsSuccessLoadMore(list: response.claims ?? []));
      } else {
        emit(ClaimsErrorKomplat(
            actionType: ActionType.loadMore,
            errorCode: response.errorCode,
            errorMessage: response.errorText));
      }
      // ignore: avoid_catches_without_on_clauses
    } catch (error) {
      emit(ClaimsError(actionType: ActionType.loadMore, error: error));
    }

    emit(ClaimsInitial(
      filter: filter,
    ));
  }

  void _onClaimsDeleteClaim(
    ClaimsDeleteClaim event,
    Emitter<ClaimsState> emit,
  ) async {
    emit(ClaimsLoading());

    try {
      final response = await dataManager.deleteClaimRequest(event.id);
      if (response.errorCode == 0) {
        emit(ClaimsSuccessDelete(event.id));
      } else {
        emit(ClaimsErrorKomplat(
            actionType: ActionType.loadMore,
            errorCode: response.errorCode,
            errorMessage: response.errorText));
      }
      // ignore: avoid_catches_without_on_clauses
    } catch (error) {
      emit(ClaimsError(actionType: ActionType.loadMore, error: error));
    }

    emit(ClaimsInitial(
      filter: filter,
    ));
  }

  void _onClaimsNewClaimIncome(
    ClaimsNewClaimIncome event,
    Emitter<ClaimsState> emit,
  ) async {
    final claimDate = event.claim.invoiceDate.toDateFormatted();

    final accNumCompareResult = filter.accNum == event.claim.accNum;

    final statusCompareResult =
        filter.status == ClaimStatus.all || event.claim.status == filter.status;

    if (filter.service?.code == event.service.code &&
        filter.dateFrom.isBefore(claimDate) &&
        filter.dateTo.isAfter(claimDate) &&
        accNumCompareResult &&
        statusCompareResult) {
      emit(ClaimsSuccessIncome(event.claim));
    }

    emit(ClaimsInitial(
      filter: filter,
    ));
  }
}
