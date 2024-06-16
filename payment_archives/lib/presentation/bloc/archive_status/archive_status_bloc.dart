import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/use_cases/use_cases.dart';

part 'archive_status_event.dart';
part 'archive_status_state.dart';


class ArchiveStatusBloc extends Bloc<ArchiveStatusEvent, ArchiveStatusState> {

  final ArchiveStatusUseCase useCase;
  
  ArchiveStatusBloc() 
  : useCase = ArchiveStatusUseCase(),
  super(ArchiveStatusLoading()) {
    on<ArchiveStatusEvent>(_onEvent);
  }

  late List<ArchiveStatus> _archiveStatuses;

  Future<void>? _onEvent(
    ArchiveStatusEvent event,
    Emitter<ArchiveStatusState> emit,
  ) {
    if (event is ArchiveStatusInit) return _onArchivesStatusInit(event, emit);
    if (event is ArchiveStatusSort) return _onArchiveStatusSort(event, emit);
    return null;
  }

  Future<void> _onArchivesStatusInit(
    ArchiveStatusInit event,
    Emitter<ArchiveStatusState> emit,
  ) async {
    final result = await useCase.getInstances();

    await result.fold((failure) {
      emit(ArchiveStatusError(error: failure.message));
    }, (right) async{
      _archiveStatuses = right.data;
      emit(ArchiveStatusLoaded(
        statuses: _archiveStatuses
      ));
    });       
  }

  Future<void> _onArchiveStatusSort(
    ArchiveStatusSort event,
    Emitter<ArchiveStatusState> emit,
  ) async {

    emit(ArchiveStatusLoading());

    useCase.sortValues(
      archiveStatuses: _archiveStatuses,
      ascending: event.ascending,
      sortIndex: event.sortIndex
    );
      
    emit(ArchiveStatusLoaded(
      statuses: _archiveStatuses
    ));
  }
}
