part of 'rule_allocation_bloc.dart';

abstract class RuleAllocationState extends Equatable {
  const RuleAllocationState();
  
  @override
  List<Object?> get props => [];
}

class RuleAllocationLoading extends RuleAllocationState {}

class RuleAllocationLoaded extends RuleAllocationState {
  final List<RuleAllocationData> ruleAllocations;

  const RuleAllocationLoaded({
    required this.ruleAllocations,
  });

  @override
  List<Object?> get props => [ruleAllocations];
}

class RuleAllocationsDeleteRuleAllocationSuccess extends RuleAllocationState {}

class RuleAllocationsEditRuleAllocationSuccess extends RuleAllocationState {}

class RuleAllocationsAddRuleAllocationSuccess extends RuleAllocationState {}

class RuleAllocationError extends RuleAllocationState {
  final Object? error;

  const RuleAllocationError({this.error});

  @override
  List<Object?> get props => [error];
}


