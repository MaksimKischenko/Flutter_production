// ignore_for_file: avoid_void_async

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:helppay_core/config.dart';
import 'package:helppay_core/data/data.dart';
import 'package:helppay_core/models/models.dart';
import 'package:helppay_core/utils/utils.dart';

part 'payments_history_event.dart';
part 'payments_history_state.dart';

class PaymentsHistoryBloc
    extends Bloc<PaymentsHistoryEvent, PaymentsHistoryState> {
  final DataManager dataManager;

  PaymentsHistoryFiltersScreenArgs searchFilters =
      PaymentsHistoryFiltersScreenArgs(
          dateFrom: DateTime.now()
              .subtract(const Duration(days: 14))
              .toStringFormatted(),
          dateTo: DateTime.now().toStringFormatted(),
          selectedProduct: null);

  PaymentsHistoryBloc({
    required this.dataManager,
  }) : super(PaymentsHistoryInitial()) {
    on<PaymentsHistoryEvent>(_onEvent);
  }

  void _onEvent(
      PaymentsHistoryEvent event, Emitter<PaymentsHistoryState> emit) {
    if (event is PaymentsHistoryInit) {
      return _onPaymentsHistoryInit(event, emit);
    }
    if (event is PaymentsHistoryLoad) {
      return _onPaymentsHistoryLoad(event, emit);
    }
    if (event is PaymentsHistoryLoadMore) {
      return _onPaymentsHistoryLoadMore(event, emit);
    }
  }

  void _onPaymentsHistoryInit(
    PaymentsHistoryInit event,
    Emitter<PaymentsHistoryState> emit,
  ) async {
    // update after new user login
    emit(PaymentsHistoryLoading());

    searchFilters = PaymentsHistoryFiltersScreenArgs(
        dateFrom: DateTime.now()
            .subtract(const Duration(days: 14))
            .toStringFormatted(),
        dateTo: DateTime.now().toStringFormatted(),
        selectedProduct: null);

    emit(const PaymentsHistorySuccessLoad(list: []));
  }

  void _onPaymentsHistoryLoad(
    PaymentsHistoryLoad event,
    Emitter<PaymentsHistoryState> emit,
  ) async {
    emit(PaymentsHistoryLoading());

    final selectedProduct =
        event.searchFilters.selectedProduct ?? dataManager.mainProduct;
    final type = _getProductType(selectedProduct);
    if (type == null) throw Exception();

    try {
      final response = await dataManager.getOperationHistoryRequest(
          sourceId: GetOperationHistoryRequestSourceId(
            evalue:
                selectedProduct!.params.findByAlias(AliasList.number)!.evalue!,
            type: type,
          ),
          dateFrom: event.searchFilters.dateFrom,
          dateTo: event.searchFilters.dateTo,
          count: CoreConfig.getOperationHistoryRequestLoadCount);
      if (response.errorCode == 0) {
        searchFilters = event.searchFilters;

        emit(PaymentsHistorySuccessLoad(
            list: response.paymentList?.payments?.
            where((element) => element.resultDescription.code >= 0).toList() ?? []));
      } else {
        emit(PaymentsHistoryErrorKomplat(
            actionType: ActionType.refresh,
            errorCode: response.errorCode,
            errorMessage: response.errorText));
      }
    } catch (error) {
      emit(PaymentsHistoryError(actionType: ActionType.refresh, error: error));
    }
  }

  void _onPaymentsHistoryLoadMore(
      PaymentsHistoryLoadMore event, Emitter<PaymentsHistoryState> emit) async {
    emit(PaymentsHistoryLoading());

    final selectedProduct =
        searchFilters.selectedProduct ?? dataManager.mainProduct;
    final type = _getProductType(selectedProduct);

    if (type == null) throw Exception();

    try {
      final response = await dataManager.getOperationHistoryRequest(
          sourceId: GetOperationHistoryRequestSourceId(
            evalue:
                selectedProduct!.params.findByAlias(AliasList.number)!.evalue!,
            type: type,
          ),
          dateFrom: searchFilters.dateFrom,
          dateTo: searchFilters.dateTo,
          count: CoreConfig.getOperationHistoryRequestLoadCount,
          lastPaymentId: event.lastPaymentId);
      if (response.errorCode == 0) {
        emit(
          PaymentsHistorySuccessLoadMore(
              list: response.paymentList?.payments?.
              where((element) => element.resultDescription.code >= 0).toList() ?? []),
        );
      } else {
        emit(
          PaymentsHistoryErrorKomplat(
              actionType: ActionType.loadMore,
              errorCode: response.errorCode,
              errorMessage: response.errorText),
        );
      }
    } catch (error) {
      emit(
        PaymentsHistoryError(actionType: ActionType.loadMore, error: error),
      );
    }
  }

  String? _getProductType(MdomLoginResponseProductsCurrent? product) {
    final typePan = product?.params.findByAlias(AliasList.typePan)!.evalue;
    if (typePan == AliasList.typePanAccount) {
      return 'ACCOUNT';
    } else if (typePan == AliasList.typePanCard) {
      return 'PAN';
    } else {
      return null;
    }
  }
}
