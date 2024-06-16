part of 'rule_allocation_bloc.dart';

abstract class RuleAllocationEvent extends Equatable {
  const RuleAllocationEvent();

  @override
  List<Object?> get props => [];
}

class RuleAllocationInit extends RuleAllocationEvent {}

class NewRoleAllocationUpdatedTable extends RuleAllocationEvent {
  final RuleAllocationData ruleAllocation;

  const NewRoleAllocationUpdatedTable({
    required this.ruleAllocation,
  });

  @override
  List<Object?> get props => [ruleAllocation];
}

class EditedRuleAllocationUpdateTable extends RuleAllocationEvent {
  final RuleAllocationData ruleAllocation;

  const EditedRuleAllocationUpdateTable(this.ruleAllocation);

  @override
  List<Object?> get props => [ruleAllocation];
}

class RuleAllocationSort extends RuleAllocationEvent {

  final bool ascending;
  final int sortIndex;

  const RuleAllocationSort({
    required this.ascending,
    required this.sortIndex
  });

  @override
  List<Object> get props => [ascending, sortIndex];

}

class RuleAllocationsDeleteRuleAllocation extends RuleAllocationEvent {
  final int ruleAllocationId;

  const RuleAllocationsDeleteRuleAllocation(this.ruleAllocationId);

  @override
  List<Object?> get props => [ruleAllocationId];
}