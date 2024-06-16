import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/use_cases/audit_log_use_case.dart';


part 'audit_log_event.dart';
part 'audit_log_state.dart';


class AuditLogBloc extends Bloc<AuditLogEvent, AuditLogState> {

  final AuditLogUseCase useCase;
  
  AuditLogBloc() 
  : useCase = AuditLogUseCase(),
  super(AuditLogLoading()) {
    on<AuditLogEvent>(_onEvent);
  }

  late List<AuditLog> _audits;

  Future<void>? _onEvent(
    AuditLogEvent event,
    Emitter<AuditLogState> emit,
  ) {
    if (event is AuditLogInit) return _onAuditsLogInit(event, emit);
    if (event is AuditLogSort) {
      return _onAuditsLogSort(event, emit);
    } else {
      return null;
    }
  }

  Future<void> _onAuditsLogInit(
    AuditLogInit event,
    Emitter<AuditLogState> emit,
  ) async {

    emit(AuditLogLoading());
    
    final result = await useCase.getInstances(
      dateFrom: event.dateFrom,
      dateTo: event.dateTo,
      userName: event.userName
    );

    await result.fold((failure) {
      emit(AuditLogNetworkError(error: failure.message));
    }, (right) async{
      _audits = right.data;
      emit(AuditLogLoaded(
        audits: _audits,
      ));
    });  
  }
  
  Future<void> _onAuditsLogSort(
    AuditLogSort event,
    Emitter<AuditLogState> emit,   
  ) async {

    emit(AuditLogLoading());

    useCase.sortValues(
      audits: _audits,
      ascending: event.ascending,
      sortIndex: event.sortIndex
    );

    emit(AuditLogLoaded(
      audits: _audits,
    ));
  }
}
