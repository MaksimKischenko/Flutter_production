// ignore_for_file: avoid_void_async

import 'package:bloc/bloc.dart';
import 'package:bpc/data/data.dart';
import 'package:equatable/equatable.dart';

part 'features_event.dart';
part 'features_state.dart';

class FeaturesBloc extends Bloc<FeaturesEvent, FeaturesState> {
  final DataManager dataManager;

  FeaturesBloc({
    required this.dataManager,
  }) : super(const FeaturesState()) {
    on<FeaturesEvent>(_onEvent);
  }

  void _onEvent(
    FeaturesEvent event,
    Emitter<FeaturesState> emit,
  ) {
    if (event is FeaturesInit) return _onFeaturesInit(event, emit);
  }

  void _onFeaturesInit(
    FeaturesInit event,
    Emitter<FeaturesState> emit,
  ) async {
    emit(
      FeaturesState(
        availableFeatures: dataManager.availableFeatures,
        organizationTitle: dataManager.informationResponse?.shortName,
        organizationUnp: dataManager.informationResponse?.unp,
        isPollAvailable: dataManager.informationResponse?.pollAvailable == 1,
      ),
    );
  }
}
