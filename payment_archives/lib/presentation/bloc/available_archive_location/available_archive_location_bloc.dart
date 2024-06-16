
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/use_cases/use_cases.dart';

part 'available_archive_location_event.dart';
part 'available_archive_location_state.dart';


class AvailableArchiveLocationBloc extends Bloc<AvailableArchiveLocationEvent, AvailableArchiveLocationState> {

  final AvaliableArchiveLocationsUseCase useCase;
  final int sourceId;

  AvailableArchiveLocationBloc({
    required this.sourceId
  }) 
  : useCase = AvaliableArchiveLocationsUseCase(),
  super(AvailableArchiveLocationLoading()) {
    on<AvailableArchiveLocationEvent>(_onEvent);
  }

  late List<AvailableArchiveLocation> _availableArchiveLocations;

  Future<void>? _onEvent(
    AvailableArchiveLocationEvent event,
    Emitter<AvailableArchiveLocationState> emit,
  ) {
    if (event is AvailableArchiveLocationInit) return _onDataBaseInit(event, emit);
    if (event is AvailableArchiveLocationSort) return _onSort(event, emit);
    return null;
  }


  Future<void> _onDataBaseInit(
    AvailableArchiveLocationInit event,
    Emitter<AvailableArchiveLocationState> emit,
  ) async {

    final result = await useCase.getInstances(
      id: sourceId
    );
  
    await result.fold((failure) {
      emit(AvailableArchiveLocationError(error: failure.message));
    }, (right) async {
      _availableArchiveLocations = right.data;
      emit(AvailableArchiveLocationLoaded(
        archiveLocations: _availableArchiveLocations
      ));
    });        
  }

  Future<void> _onSort(
    AvailableArchiveLocationSort event,
    Emitter<AvailableArchiveLocationState> emit,   
  ) async {

    emit(AvailableArchiveLocationLoading());

    useCase.sortValues(
      availableArchiveLocations: _availableArchiveLocations,
      sortIndex: event.sortIndex,
      ascending: event.ascending
    );

    emit(AvailableArchiveLocationLoaded(
      archiveLocations: _availableArchiveLocations
    ));
  }  
}
