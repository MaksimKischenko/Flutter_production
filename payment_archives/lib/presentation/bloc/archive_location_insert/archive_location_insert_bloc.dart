import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/use_cases/use_cases.dart';


part 'archive_location_insert_event.dart';
part 'archive_location_insert_state.dart';



class ArchiveLocationInsertBloc extends Bloc<ArchiveLocationInsertEvent, ArchiveLocationInsertState> {

  final ArchiveLocationUseCase useCase;

  ArchiveLocationInsertBloc() 
  : useCase = ArchiveLocationUseCase(),
  super(ArchiveLocationInsertLoading()) {
    on<ArchiveLocationInsertEvent>(_onEvent);
  }

  Future<void>? _onEvent(
    ArchiveLocationInsertEvent event,
    Emitter<ArchiveLocationInsertState> emit,
  ) {
    if (event is ArchiveLocationInsertInit) return _onArchiveLocationInsertInit(event, emit);
    if (event is ArchiveLocationInsertRun) return _onArchiveLocationInsertRun(event, emit);
    return null;
  }


  Future<void> _onArchiveLocationInsertInit(
    ArchiveLocationInsertInit event,
    Emitter<ArchiveLocationInsertState> emit,       
  ) async {
    emit(ArchiveLocationInsertInitial());
  }


  Future<void> _onArchiveLocationInsertRun(
    ArchiveLocationInsertRun event,
    Emitter<ArchiveLocationInsertState> emit,        
  ) async {

    emit(ArchiveLocationInsertLoading());


    final result = await useCase.saveInstance(
      archiveLocationInsertBody: event.archiveLocationInsertBody
    );

    await result.fold((failure) {
      emit(ArchiveLocationInsertNetworkError(error: failure.message));
      emit(ArchiveLocationInsertInitial());
    }, (right) async {
      emit(ArchiveLocationInsertSuccess(
        archiveLocation: right.data.first
      ));   
    }); 
  }
}
