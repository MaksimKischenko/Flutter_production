part of 'rule_allocation_update_bloc.dart';

abstract class RuleAllocationUpdateEvent extends Equatable {
  const RuleAllocationUpdateEvent();

  @override
  List<Object?> get props => [];
}


class RuleAllocationUpdateInit extends RuleAllocationUpdateEvent {}

class RuleAllocationUpdateRun extends RuleAllocationUpdateEvent {
  final RuleAllocationUpdateRequest ruleAllocation;

  const RuleAllocationUpdateRun(this.ruleAllocation);

  @override
  List<Object?> get props => [ruleAllocation];
}
