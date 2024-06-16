// ignore_for_file: avoid_void_async

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:helppay_payform_app/data/data.dart';
import 'package:helppay_payform_app/models/models.dart';

part 'services_event.dart';
part 'services_state.dart';

class ServicesBloc extends Bloc<ServicesEvent, ServicesState> {
  final DataManager dataManager;
  final int diType;

  ServicesBloc({
    required this.dataManager,
    required this.diType
  }) : super(ServicesLoading()) {
    on<ServicesEvent>(_onEvent);
  }

  void _onEvent(
    ServicesEvent event,
    Emitter<ServicesState> emit
  ) {
    if (event is ServicesInit) return _onServicesInit(event, emit);
  }

  void _onServicesInit(
    ServicesInit event,
    Emitter<ServicesState> emit
  ) async {
    emit(ServicesLoading());

    try {
      final response = await dataManager.getPayListRequest(
        payCode: event.code,
        diType: diType
      );
      if ((response.errorCode ?? 0) == 0) {
        emit(ServicesLoaded(
          code: event.code,
          payRecords: response.payRecord ?? []
        ));
      } else {
        emit(ServicesErrorKomplat(
          lastCode: event.code,
          request: RequestType.getPayList,
          errorCode: response.errorCode,
          errorText: response.errorText
        ));
      }
    // ignore: avoid_catches_without_on_clauses
    } catch(error, _) {
      emit(ServicesError(
        lastCode: event.code,
        error: error
      ));
    }
  }
}
