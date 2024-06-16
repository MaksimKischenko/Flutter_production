import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/use_cases/use_cases.dart';


part 'archive_location_event.dart';
part 'archive_location_state.dart';



class ArchiveLocationBloc extends Bloc<ArchiveLocationEvent, ArchiveLocationState> {

  final ArchiveLocationUseCase useCase;

  ArchiveLocationBloc() 
  : useCase = ArchiveLocationUseCase(),
  super(ArchiveLocationLoading()) {
    on<ArchiveLocationEvent>(_onEvent);
  }

  late List<ArchiveLocation> _archiveLocations;

  Future<void>? _onEvent(
    ArchiveLocationEvent event,
    Emitter<ArchiveLocationState> emit,
  ) {
    if (event is ArchiveLocationInit) return _onDataBaseInit(event, emit);
    if (event is NewArchiveLocationUpdateTable) return _onNewDataBaseDir(event, emit);
    if (event is EditedArchiveLocationUpdateTable) return _onUpdateArchiveLocation(event, emit);
    if (event is ArchiveLocationsDeleteArchiveLocation) return _onDeleteArchiveLocation(event, emit);  
    if (event is ArchiveLocationSort) return _onSortArchiveLocation(event, emit);
    return null;          
  }


  Future<void> _onDataBaseInit(
    ArchiveLocationInit event,
    Emitter<ArchiveLocationState> emit,
  ) async {

    final result = await useCase.getInstances();

    await result.fold((failure) {
      emit(ArchiveLocationError(error: failure.message));
    }, (right) async{
      _archiveLocations = right.data;
      emit(ArchiveLocationLoaded(
        archiveLocations: _archiveLocations
      ));
    });    
  }

  Future<void> _onNewDataBaseDir(
    NewArchiveLocationUpdateTable event,
    Emitter<ArchiveLocationState> emit,
  ) async {

    emit(ArchiveLocationLoading());
    
    _archiveLocations.insert(0, event.newArchiveLocation);

    emit(ArchiveLocationsAddArchiveLocationSuccess());
    
    emit(ArchiveLocationLoaded(
      archiveLocations: _archiveLocations
    ));
  }

  Future<void> _onUpdateArchiveLocation(
    EditedArchiveLocationUpdateTable event,
    Emitter<ArchiveLocationState> emit,
  ) async {

    emit(ArchiveLocationLoading());
    
    final index = _archiveLocations.indexWhere((e) => e.id == event.archiveLocation.id);
      if (index > -1) {
        _archiveLocations[index] = event.archiveLocation;
      }

    emit(ArchiveLocationsEditArchiveLocationSuccess());
    
    emit(ArchiveLocationLoaded(
      archiveLocations: _archiveLocations
    ));
  }

  Future<void> _onDeleteArchiveLocation(
    ArchiveLocationsDeleteArchiveLocation event,
    Emitter<ArchiveLocationState> emit,
  ) async {

    emit(ArchiveLocationLoading());

    final result = await useCase.deleteInstance(
      id: event.archiveLocationId
    );

    await result.fold((failure) {
      emit(ArchiveLocationError(error: failure.message));
    }, (right) async{
      _archiveLocations.removeWhere((e) => e.id == event.archiveLocationId); 
      emit(ArchiveLocationsDeleteArchiveLocationSuccess());
      emit(ArchiveLocationLoaded(
        archiveLocations: _archiveLocations
      ));      
    });    
  }

  Future<void> _onSortArchiveLocation(
    ArchiveLocationSort event,
    Emitter<ArchiveLocationState> emit,   
  ) async {

    emit(ArchiveLocationLoading());

    useCase.sortValues(
      archiveLocations: _archiveLocations,
      sortIndex: event.sortIndex,
      ascending: event.ascending
    );

    emit(ArchiveLocationLoaded(
      archiveLocations: _archiveLocations
    ));
  }
}
