// ignore_for_file: avoid_void_async

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kpm_fl/config.dart';
import 'package:kpm_fl/data/data.dart';
import 'package:kpm_fl/models/models.dart';

part 'popular_services_event.dart';
part 'popular_services_state.dart';

class PopularServicesBloc extends Bloc<PopularServicesEvent, PopularServicesState> {
  final DataManager dataManager;
  
  PopularServicesBloc({
    required this.dataManager
  }) : super(PopularServicesLoading()) {
    on<PopularServicesEvent>(_onEvent);
  }

  void _onEvent(
    PopularServicesEvent event,
    Emitter<PopularServicesState> emit
  ) {
    if (event is PopularServicesInit) return _onPopularServicesInit(event, emit);
  }

  void _onPopularServicesInit(
    PopularServicesInit event,
    Emitter<PopularServicesState> emit
  ) async {
    emit(PopularServicesLoading());

    try {
      final response = await dataManager.listPopularRequest(
        count: AppConfig.listPopularRequestLoadCount,
      );
      if ((response.errorCode ?? 0) == 0) {
        emit(PopularServicesLoaded(
          payRecords: response.payRecord ?? []
        ));
      } else {
        emit(PopularServicesErrorKomplat(
          request: RequestType.listPopular,
          errorCode: response.errorCode,
          errorText: response.errorText
        ));
      }
    // ignore: avoid_catches_without_on_clauses
    } catch(error, _) {
      emit(PopularServicesError(error: error));
    }
  }
}
