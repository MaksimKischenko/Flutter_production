// ignore_for_file: avoid_void_async

import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:kpm_fl/config.dart';
import 'package:kpm_fl/data/data.dart';
import 'package:kpm_fl/models/models.dart';

part 'all_services_event.dart';
part 'all_services_state.dart';

class AllServicesBloc extends Bloc<AllServicesEvent, AllServicesState> {
  final DataManager dataManager;
  
  AllServicesBloc({
    required this.dataManager
  }) : super(AllServicesLoading()) {
    on<AllServicesEvent>(_onEvent);
  }

  void _onEvent(
    AllServicesEvent event,
    Emitter<AllServicesState> emit
  ) {
    if (event is AllServicesInit) return _onAllServicesInit(event, emit);
  }

  void _onAllServicesInit(
    AllServicesInit event,
    Emitter<AllServicesState> emit
  ) async {
    emit(AllServicesLoading());

    try {
      final response = await dataManager.getPayListRequest(
        payCode: AppConfig.allServicesCode,
      );
      if ((response.errorCode ?? 0) == 0) {
        emit(AllServicesLoaded(
          services: response.payRecord?.map(EripService.fromPayRecord).toList() ?? []
        ));
      } else {
        if (response.errorCode == 502) {
          // empty list
          emit(const AllServicesLoaded(
            services: []
          ));
        } else {
          emit(AllServicesErrorKomplat(
            request: RequestType.getPayList,
            errorCode: response.errorCode,
            errorText: response.errorText
          ));
        }
      }
    // ignore: avoid_catches_without_on_clauses
    } catch(error, _) {
      emit(AllServicesError(
        error: error
      ));
    }
  }
}
