import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:payment_tracking_module/data/data.dart';
import 'package:payment_tracking_module/domain/use_cases/use_cases.dart';


part 'rule_allocation_event.dart';
part 'rule_allocation_state.dart';

class RuleAllocationBloc extends Bloc<RuleAllocationEvent, RuleAllocationState> {

  final RuleAllocationUseCase useCase;
  
  RuleAllocationBloc() 
  : useCase = RuleAllocationUseCase(), 
  super(RuleAllocationLoading()) {
    on<RuleAllocationEvent>(_onEvent);
  }

  late List<RuleAllocationData> _ruleAllocations;

  Future<void>? _onEvent(
    RuleAllocationEvent event,
    Emitter<RuleAllocationState> emit,
  ) {
    if (event is RuleAllocationInit) return _onRuleInit(event, emit);
    if (event is NewRoleAllocationUpdatedTable) return _onNewRole(event, emit);
    if (event is EditedRuleAllocationUpdateTable) return _onUpdateRuleAllocation(event, emit);
    if (event is RuleAllocationsDeleteRuleAllocation) return _onDeleteRuleAllocation(event, emit);
    if (event is RuleAllocationSort) return _onSortRuleAllocation(event, emit);
    return null;    
  }


  Future<void> _onRuleInit(
    RuleAllocationInit event,
    Emitter<RuleAllocationState> emit,
  ) async {

    final result = await useCase.getRuleAlInstances();

    await result.fold((failure) {
      emit(RuleAllocationError(error: failure.message));
    }, (right) async{
      _ruleAllocations = right.data;
      emit(RuleAllocationLoaded(
        ruleAllocations: _ruleAllocations
      ));
    });  
  }


  Future<void> _onNewRole(
    NewRoleAllocationUpdatedTable event,
    Emitter<RuleAllocationState> emit,
  ) async {

    emit(RuleAllocationLoading());
    
    _ruleAllocations.insert(0, event.ruleAllocation);

    emit(RuleAllocationsAddRuleAllocationSuccess());
    
    emit(RuleAllocationLoaded(
      ruleAllocations: _ruleAllocations
    ));
  }

  Future<void> _onUpdateRuleAllocation(
    EditedRuleAllocationUpdateTable event,
    Emitter<RuleAllocationState> emit,
  ) async {

    emit(RuleAllocationLoading());
    
    final index = _ruleAllocations.indexWhere((e) => e.id == event.ruleAllocation.id);
      if (index > -1) {
        _ruleAllocations[index] = event.ruleAllocation;
      }

    emit(RuleAllocationsEditRuleAllocationSuccess());
    
    emit(RuleAllocationLoaded(
      ruleAllocations: _ruleAllocations
    ));
  }

  Future<void> _onDeleteRuleAllocation(
    RuleAllocationsDeleteRuleAllocation event,
    Emitter<RuleAllocationState> emit,
  ) async {

    emit(RuleAllocationLoading());

    final result = await useCase.deleteInstance(
      id: event.ruleAllocationId
    );

    await result.fold((failure) {
      emit(RuleAllocationError(error: failure.message));
    }, (right) async{
      _ruleAllocations.removeWhere((e) => e.id == event.ruleAllocationId); 
      emit(RuleAllocationsDeleteRuleAllocationSuccess());
      emit(RuleAllocationLoaded(
        ruleAllocations: _ruleAllocations
      ));      
    });     
  }

  Future<void> _onSortRuleAllocation(
    RuleAllocationSort event,
    Emitter<RuleAllocationState> emit,   
  ) async {

    emit(RuleAllocationLoading());

    useCase.sortValues(
      ruleAllocations: _ruleAllocations,
      ascending: event.ascending,
      sortIndex: event.sortIndex
    );

    emit(RuleAllocationLoaded(
      ruleAllocations: _ruleAllocations
    ));
  }
}
