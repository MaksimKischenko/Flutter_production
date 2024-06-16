import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/use_cases/use_cases.dart';


part 'rule_allocation_update_event.dart';
part 'rule_allocation_update_state.dart';

class RuleAllocationUpdateBloc extends Bloc<RuleAllocationUpdateEvent, RuleAllocationUpdateState> {

  final RuleAllocationUseCase useCase;
  final int? id;
  RuleAllocationData? ruleAllocationData;
 
  RuleAllocationUpdateBloc({
    required this.id,
    required this.ruleAllocationData
  }) 
  : useCase = RuleAllocationUseCase(),
  super(RuleAllocationUpdateLoading()) {
    on<RuleAllocationUpdateEvent>(_onEvent);
  }

  List<DataSource> _dataSources = [];
  List<ArchiveLocation> _archiveLocations = [];

  Future<void>? _onEvent(
    RuleAllocationUpdateEvent event,
    Emitter<RuleAllocationUpdateState> emit,
  ) {
    if (event is RuleAllocationUpdateInit) return _onRuleAllocationUpdateInit(event, emit);
    if (event is RuleAllocationUpdateRun) return _onRuleAllocationUpdateRun(event, emit);
    return null;
  }

  Future<void> _onRuleAllocationUpdateInit(
    RuleAllocationUpdateInit event,
    Emitter<RuleAllocationUpdateState> emit,       
  ) async {

    final resultDataSources = await useCase.getDataSInstances();
    final resultArchiveLocations = await useCase.getArchiveAlInstances();

    await resultDataSources.fold((failure) {
      emit(RuleAllocationUpdateNetworkError(error: failure.message));
    }, (right) async{
      _dataSources = right.data;
    });   

    await resultArchiveLocations.fold((failure) {
      emit(RuleAllocationUpdateNetworkError(error: failure.message));
    }, (right) async{
      _archiveLocations = right.data;
    });   

    if (ruleAllocationData?.locationId == null) {
      final resultRuleAllocation = await useCase.getRuleAlInstances(
        id: id
      );

      await resultRuleAllocation.fold((failure) {
        emit(RuleAllocationUpdateNetworkError(error: failure.message));
      }, (right) async{
        ruleAllocationData = right.data.first;
      });   
    }

    emit(RuleAllocationUpdateInitial(
      ruleAllocationData: ruleAllocationData,
      dataSources: _dataSources,
      archiveLocations: _archiveLocations
    ));
  }

  Future<void> _onRuleAllocationUpdateRun(
    RuleAllocationUpdateRun event,
    Emitter<RuleAllocationUpdateState> emit,        
  ) async {

    emit(RuleAllocationUpdateLoading());

     final result = await useCase.editInstance(
      id: id ?? 0,
      request: event.ruleAllocation
    );

    await result.fold((failure) {
      emit(RuleAllocationUpdateNetworkError(
        error: failure.message
      ));

      emit(RuleAllocationUpdateInitial(
        ruleAllocationData: ruleAllocationData,
        dataSources: _dataSources,
        archiveLocations: _archiveLocations        
      ));    
    }, (right) async{
      emit(RuleAllocationUpdateSuccess(
        ruleAllocationData: right.data.first
      ));  
    }); 
  }
}
