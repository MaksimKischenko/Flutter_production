import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/use_cases/use_cases.dart';



part 'archive_part_event.dart';
part 'archive_part_state.dart';

class ArchivePartBloc extends Bloc<ArchivePartEvent, ArchivePartState> {

  final ArchiveDBPartsUseCase useCase;
  final int id;
  
  ArchivePartBloc({
    required this.id
  }) 
  : useCase = ArchiveDBPartsUseCase(),
  super(ArchivePartLoading()) {
    on<ArchivePartEvent>(_onEvent);
  }

  late List<ArchiveDBPart> _archiveParts;

  Future<void>? _onEvent(
    ArchivePartEvent event,
    Emitter<ArchivePartState> emit,
  ) {
    if (event is ArchivePartInit) return _onArchivePartsInit(event, emit);
    if (event is ArchivePartSort) return _onArchivePartSort(event, emit);
    return null;
  }

  Future<void> _onArchivePartsInit(
    ArchivePartInit event,
    Emitter<ArchivePartState> emit,
  ) async {

    final result = await useCase.getInstances(
      id: id
    );
  
    await result.fold((failure) {
      emit(ArchivePartError(error: failure.message));
    }, (right) async {
      _archiveParts = right.data;
      emit(ArchivePartLoaded(
        archiveParts: _archiveParts
      ));
    });    
  }

  Future<void> _onArchivePartSort(
    ArchivePartSort event,
    Emitter<ArchivePartState> emit,
  ) async {

     emit(ArchivePartLoading());

     useCase.sortValues(
      archiveParts: _archiveParts,
      ascending: event.ascending,
      sortIndex: event.sortIndex
     );

     emit(ArchivePartLoaded(
      archiveParts: _archiveParts
     ));
  }
}
