import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:payment_tracking_module/data/remote_models/get_map_allocation_data_response.dart';
import 'package:payment_tracking_module/domain/use_cases/use_cases.dart';

part 'map_allocation_event.dart';
part 'map_allocation_state.dart';


class MapAllocationBloc extends Bloc<MapAllocationEvent, MapAllocationState> {

  final MapAllocationsUseCase useCase;
  final int id;
  
  MapAllocationBloc({
    required this.id
  }) : useCase = MapAllocationsUseCase(),
  super(MapAllocationLoading()) {
    on<MapAllocationEvent>(_onEvent);
  }

  late List<MapAllocationData> _mapAllocations;

  Future<void>? _onEvent(
    MapAllocationEvent event,
    Emitter<MapAllocationState> emit,
  ) {
    if (event is MapAllocationInit) return _onMapAllocationInit(event, emit);
    if (event is MapAllocationSort) return _onMapAllocationSort(event, emit);
    return null;
  }

  Future<void> _onMapAllocationInit(
    MapAllocationInit event,
    Emitter<MapAllocationState> emit,
  ) async {

    final result = await useCase.getInstances(
      id: id
    );
  
    await result.fold((failure) {
      emit(MapAllocationError(error: failure.message));
    }, (right) async {
      _mapAllocations = right.data;
      emit(MapAllocationLoaded(
        mapAllocations: _mapAllocations
      ));
    });    
  }
  
  Future<void> _onMapAllocationSort(
    MapAllocationSort event,
    Emitter<MapAllocationState> emit,   
  ) async {

    emit(MapAllocationLoading());

    useCase.sortValues(
      mapAllocations: _mapAllocations,
      ascending: event.ascending,
      sortIndex: event.sortIndex
    );

    emit(MapAllocationLoaded(
      mapAllocations: _mapAllocations
    ));
  }
}
