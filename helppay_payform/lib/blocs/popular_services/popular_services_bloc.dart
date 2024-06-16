import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:helppay_payform_app/data/data.dart';
import 'package:helppay_payform_app/models/models.dart';

part 'popular_services_event.dart';
part 'popular_services_state.dart';

class PopularServicesBloc extends Bloc<PopularServicesEvent, PopularServicesState> {
  final DataManager dataManager;
  final DynamicConfig config;

  PopularServicesBloc({
    required this.dataManager,
    required this.config
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
        count: config.listPopularRequestLoadCount,
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
    } catch(error, _) {
      emit(PopularServicesError(error: error));
    }
  }
}
