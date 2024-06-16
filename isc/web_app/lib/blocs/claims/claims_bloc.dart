import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:isc_web_app/config.dart';
import 'package:isc_web_app/data/data.dart';
import 'package:isc_web_app/data/data_manager.dart';
import 'package:isc_web_app/models/models.dart';
import 'package:isc_web_app/utils/date_helper.dart';

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
  List<Claim> claims = [];

  void _onEvent(
    ClaimsEvent event,
    Emitter<ClaimsState> emit,
  ) {
    if (event is ClaimsLoad) return _onClaimsLoad(event, emit);
    if (event is ClaimsLoadMore) return _onClaimsLoadMore(event, emit);
    if (event is ClaimsSort) return _onClaimSort(event, emit);
  } 

  void _onClaimsLoad(
    ClaimsLoad event,
    Emitter<ClaimsState> emit,
  ) async {
    emit(ClaimsLoading());

    if (event.filter == null) {
      filter = ClaimsFilterData.empty(
        serviceCode: 101 
      );
    } else {
      filter = event.filter!.copyWith(
        serviceCode: 101, 
      );
    }

    if (filter.serviceCode != null) {
      try {
        final response = await dataManager.claimsListRequest(
          from: filter.dateFrom,
          to: filter.dateTo,
          accNum: filter.accNum,
          status: filter.status,
          count: AppConfig.claimsListRequestLoadCount
        );
        if (response.errorCode == 0) {      
          emit(ClaimsSuccessLoad(
            list: response.claims ?? []
          ));
          claims = response.claims ?? [];
        } else {
          emit(ClaimsErrorKomplat(
            actionType: ActionType.refresh,
            errorCode: response.errorCode,
            errorMessage: response.errorText
          ));
        }
      } catch (error, _) {
        emit(ClaimsError(
          actionType: ActionType.refresh,
          error: error
        ));
      }
    } else {
      emit(const ClaimsError(
        actionType: ActionType.refresh,
        error: 'Нет услуг'
      ));
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
        from: filter.dateFrom,
        to: filter.dateTo,
        accNum: filter.accNum,
        status: filter.status,
        count: AppConfig.claimsListRequestLoadCount,
        lastClaimId: event.lastClaimId,
      );
      if (response.errorCode == 0) {       
        emit(ClaimsSuccessLoadMore(
          list: response.claims ?? [],
          isLoadMoreAvailable: (response.claims?.length ?? 0) >= AppConfig.claimsListRequestLoadCount
        ));
      } else {
        emit(ClaimsErrorKomplat(
          actionType: ActionType.loadMore,
          errorCode: response.errorCode,
          errorMessage: response.errorText
        ));
      }
    } catch (error, _) {
      emit(ClaimsError(
        actionType: ActionType.loadMore,
        error: error
      ));
    }

    emit(ClaimsInitial(
      filter: filter,
    ));
  }

  void _onClaimSort(
    ClaimsSort event,
    Emitter<ClaimsState> emit,   
  ) async {
    
    emit(ClaimsLoading());

    sortValues(event.ascending, event.sortIndex);

    emit(ClaimsSuccessLoad(
      list: claims
    ));
    
    emit(ClaimsInitial(
      filter: filter,
    )); 
  }

    void sortValues(bool ascending, int sortIndex) {
      switch (sortIndex) {
        case 1:
          ascending?
          claims.sort((b, a) => (a.id).compareTo(b.id)):
          claims.sort((a, b) => (a.id).compareTo(b.id));
          break;
        case 2:
          ascending?
          claims.sort((b, a) => (a.accNum).compareTo(b.accNum)):
          claims.sort((a, b) => (a.accNum).compareTo(b.accNum));
          break;
        case 3:
          ascending?
          claims.sort((b, a) => (a.invoiceDate.toDateFormatted()).compareTo(b.invoiceDate.toDateFormatted())):
          claims.sort((a, b) => (a.invoiceDate.toDateFormatted()).compareTo(b.invoiceDate.toDateFormatted()));
          break;  
        case 4:
          ascending?
          claims.sort((b, a) => (a.dueDate.toDateFormatted()).compareTo(b.dueDate.toDateFormatted())):
          claims.sort((a, b) => (a.dueDate.toDateFormatted()).compareTo(b.dueDate.toDateFormatted()));
          break;  
        case 5:
          ascending?
          claims.sort((b, a) => (a.fio ?? '').compareTo(b.fio ?? '')):
          claims.sort((a, b) => (a.fio ?? '').compareTo(b.fio ?? ''));
          break;  
        case 6:
          ascending?
          claims.sort((b, a) => (a.sum).compareTo(b.sum)):
          claims.sort((a, b) => (a.sum).compareTo(b.sum));
          break;  
        case 7:
          ascending?
          claims.sort((b, a) => (a.paymentSum).compareTo(b.paymentSum)):
          claims.sort((a, b) => (a.paymentSum).compareTo(b.paymentSum));
          break;    
        case 8:
          ascending?
          claims.sort((b, a) => (a.status.claimStatusName).compareTo(b.status.claimStatusName)):
          claims.sort((a, b) => (a.status.claimStatusName).compareTo(b.status.claimStatusName));
          break;                                                                                                                                                                                                                                             
      }
  }
}