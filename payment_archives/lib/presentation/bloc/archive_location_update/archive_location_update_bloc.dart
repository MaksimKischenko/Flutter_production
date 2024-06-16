import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/use_cases/use_cases.dart';

part 'archive_location_update_event.dart';
part 'archive_location_update_state.dart';

class ArchiveLocationUpdateBloc extends Bloc<ArchiveLocationUpdateEvent, ArchiveLocationUpdateState> {
  final ArchiveLocationUseCase useCase;
  final int? id;
  ArchiveLocation? archiveLocation;
 

  ArchiveLocationUpdateBloc({
    required this.id,
    required this.archiveLocation
  }) : useCase = ArchiveLocationUseCase(),
  super(ArchiveLocationUpdateLoading()) {
    on<ArchiveLocationUpdateEvent>(_onEvent);
  }


  Future<void>? _onEvent(
    ArchiveLocationUpdateEvent event,
    Emitter<ArchiveLocationUpdateState> emit,
  ) {
    if (event is ArchiveLocationUpdateInit) return _onArchiveLocationUpdateInit(event, emit);
    if (event is ArchiveLocationUpdateRun) return _onArchiveLocationUpdateRun(event, emit);
    return null;
  }

  Future<void> _onArchiveLocationUpdateInit(
    ArchiveLocationUpdateInit event,
    Emitter<ArchiveLocationUpdateState> emit,       
  ) async {

    if (archiveLocation?.id == null) {
      final result = await useCase.getInstances(
        id: id
      );
      await result.fold((failure) {
        emit(ArchiveLocationUpdateNetworkError(error: failure.message));
      }, (right) async{
        archiveLocation = right.data.first;
      });       
    }
    
    emit(ArchiveLocationUpdateInitial(
        archiveLocation: archiveLocation,
    ));
  }

  Future<void> _onArchiveLocationUpdateRun(
    ArchiveLocationUpdateRun event,
    Emitter<ArchiveLocationUpdateState> emit,        
  ) async {

    emit(ArchiveLocationUpdateLoading());

    final result = await useCase.editInstance(
      id: id ?? 0,
      request: event.archiveLocation
    );   

    await result.fold((failure) {
      emit(ArchiveLocationUpdateNetworkError(error: failure.message));
      emit(ArchiveLocationUpdateInitial(
        archiveLocation: archiveLocation,
      ));
    }, (right) async{
      emit(ArchiveLocationUpdateSuccess(
        archiveLocation: right.data.first
      ));   
    }); 
  }
}
