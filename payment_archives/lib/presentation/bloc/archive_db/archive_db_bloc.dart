import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/use_cases/use_cases.dart';



part 'archive_db_event.dart';
part 'archive_db_state.dart';

class ArchiveDbBloc extends Bloc<ArchiveDbEvent, ArchiveDbState> {
  final ArchiveDBUseCase useCase;
  
  ArchiveDbBloc() 
  : useCase = ArchiveDBUseCase(),
  super(ArchiveDbLoading()) {
    on<ArchiveDbEvent>(_onEvent);
  }

  late List<ArchiveDB> _archives;

  Future<void>? _onEvent(
    ArchiveDbEvent event,
    Emitter<ArchiveDbState> emit,
  ) {
    if (event is ArchiveDbInit) return _onArchivesInit(event, emit);
    if (event is ArchiveDbSort) return _onArchivesSort(event, emit);
    return null;
  }

  Future<void> _onArchivesInit(
    ArchiveDbInit event,
    Emitter<ArchiveDbState> emit,
  ) async {

    final result = await useCase.getInstances();
  
    await result.fold((failure) {
      emit(ArchiveDbError(error: failure.message));
    }, (right) async {
      _archives = right.data;
      emit(ArchiveDbLoaded(
        archives: _archives
      ));
    });
  }

  Future<void> _onArchivesSort(
    ArchiveDbSort event,
    Emitter<ArchiveDbState> emit,
  ) async {

     emit(ArchiveDbLoading());

     useCase.sortValues(
      archives: _archives,
      sortIndex: event.sortIndex,
      ascending: event.ascending
     );

     emit(ArchiveDbLoaded(
      archives: _archives
     ));
  }
}
