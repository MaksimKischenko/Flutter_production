import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:helppay_core/data/data.dart';
import 'package:meta/meta.dart';

part 'info_supplier_event.dart';
part 'info_supplier_state.dart';

class InfoSupplierBloc extends Bloc<InfoSupplierEvent, InfoSupplierState> {
  final DataManager dataManager;

  InfoSupplierBloc({required this.dataManager}) : super(InfoSupplierInitial()) {
    on<InfoSupplierEvent>(_onEvent);
  }

  void _onEvent(
    InfoSupplierEvent event,
    Emitter<InfoSupplierState> emit,
  ) {
    if (event is InfoSupplierLoad) {
      return _onInfoSupplierLoad(event, emit);
    }
    if (event is InfoSupplierSelected) {
      return _onInfoSupplierSelected(event, emit);
    }
  }

  // ignore: avoid_void_async
  void _onInfoSupplierLoad(
    InfoSupplierLoad event,
    Emitter<InfoSupplierState> emit,
  ) async {
    emit(InfoSupplierLoading());

    try {
      final response = await dataManager.infoSupplierRequest(
          supplierUNN: event.supplierUNN, supplierName: event.supplierName);

      final _companies = response.companies ?? [];

      if (response.errorCode?.evalue == 0) {
        emit(InfoSupplierLoaded(companies: _companies));
      } else {
        emit(
          InfoSupplierErrorKomplat(
            errorCode: response.errorCode?.evalue ?? 0,
            errorMessage: response.errorCode?.errorText ?? '',
          ),
        );
      }
      // ignore: avoid_catches_without_on_clauses
    } catch (error, _) {
      emit(InfoSupplierError(error: error));
    }
  }

  // ignore: avoid_void_async
  void _onInfoSupplierSelected(
    InfoSupplierSelected event,
    Emitter<InfoSupplierState> emit,
  ) async {
    emit(InfoSupplierLoading());
    emit(InfoSupplierInitial());
  }
}
