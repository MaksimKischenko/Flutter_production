import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/use_cases/use_cases.dart';


part 'rule_allocation_insert_event.dart';
part 'rule_allocation_insert_state.dart';



class RuleAllocationInsertBloc extends Bloc<RuleAllocationInsertEvent, RuleAllocationInsertState> {

  final RuleAllocationUseCase useCase;

  RuleAllocationInsertBloc() 
  : useCase = RuleAllocationUseCase(),
  super(RuleAllocationInsertLoading()) {
    on<RuleAllocationInsertEvent>(_onEvent);
  }

  List<DataSource> _dataSources  = [];
  List<ArchiveLocation> _archiveLocations  = [];

  Future<void>? _onEvent(
    RuleAllocationInsertEvent event,
    Emitter<RuleAllocationInsertState> emit,
  ) {
    if (event is RuleAllocationInsertInit) return _onRuleAllocationInsertInit(event, emit);
    if (event is RuleAllocationInsertRun) return _onARuleAllocationInsertRun(event, emit);
    return null;
  }



  Future<void> _onRuleAllocationInsertInit(
    RuleAllocationInsertInit event,
    Emitter<RuleAllocationInsertState> emit,       
  ) async {

    final resultDataSources = await useCase.getDataSInstances();
    final resultArchiveLocations = await useCase.getArchiveAlInstances();

    await resultDataSources.fold((failure) {
      emit(RuleAllocationInsertNetworkError(error: failure.message));
    }, (right) async{
      _dataSources = right.data;
    });   

    await resultArchiveLocations.fold((failure) {
      emit(RuleAllocationInsertNetworkError(error: failure.message));
    }, (right) async{
      _archiveLocations = right.data;
    });   

    emit(RuleAllocationInsertInitial(
      dataSources: _dataSources,
      archiveLocations: _archiveLocations
    ));
  }


  Future<void> _onARuleAllocationInsertRun(
    RuleAllocationInsertRun event,
    Emitter<RuleAllocationInsertState> emit,        
  ) async {

    emit(RuleAllocationInsertLoading());

     final result = await useCase.saveInstance(
      event.ruleAllocationInsertBody
    );

    await result.fold((failure) {
      emit(RuleAllocationInsertNetworkError(error: failure.message));
      emit(RuleAllocationInsertInitial(
        dataSources: _dataSources,
        archiveLocations: _archiveLocations
      ));      
    }, (right) async{
      emit(RuleAllocationInsertSuccess(
        ruleAllocationdata: right.data.first
      ));   
    });      
  }
}
